import Foundation
import Combine
import Core

public final class BaseService<Target: URLRequestTargetType> {
    
    public init() {
        // 인터셉터 등록
        SessionInterceptor.shared.register(adapter: TokenAdapter())
        SessionInterceptor.shared.register(retrier: TokenRetrier(session: session))
    }
    
    public typealias API = Target
    
    private lazy var session: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10
        configuration.timeoutIntervalForResource = 10
        return URLSession(configuration: configuration, delegate: SessionInterceptor.shared, delegateQueue: nil)
    }()
    
    // MARK: - Public Methods
    
    func requestWithResult<T: Decodable>(_ target: API) -> AnyPublisher<T, HeyNetworkError> {
        return fetchResponse(with: target)
            .flatMap { response in
                self.validate(response: response, target: target)
                    .map { _ in response.data! }
                    .mapError { $0 }
            }
            .flatMap { data in
                self.decode(data: data)
                    .mapError { ErrorHandler.handleDecodingError(data: data, decodingType: T.self, error: $0) }
            }
            .eraseToAnyPublisher()
    }
    
    func requestWithNoResult(_ target: API) -> AnyPublisher<Void, HeyNetworkError> {
        return fetchResponse(with: target)
            .flatMap { response in
                self.validate(response: response, target: target)
                    .map { _ in response.data! }
                    .mapError { $0 }
            }
            .flatMap { data -> AnyPublisher<VoidResult, HeyNetworkError> in
                self.decodeNoResult(data: data)
                    .mapError { ErrorHandler.handleDecodingError(data: data, decodingType: VoidResult.self, error: $0) }
                    .eraseToAnyPublisher()
            }
            .map { _ in () }
            .eraseToAnyPublisher()
    }
}

// MARK: - Network Request & Response Handling
extension BaseService {
    
    /// 네트워크 요청 생성 및 처리 메소드
    private func fetchResponse(with target: API) -> AnyPublisher<NetworkResponse, HeyNetworkError> {
        return RequestHandler.createURLRequest(for: target)
            .map { $0 }
            .handleEvents(receiveOutput: { NetworkLogHandler.requestLogging($0) })
            .flatMap { [weak self] urlRequest -> AnyPublisher<NetworkResponse, HeyNetworkError> in
                guard let self = self else {
                    return Fail(error: .unknownError).eraseToAnyPublisher()
                }
                
                return self.executeRequest(urlRequest: urlRequest, target: target)
            }
            .handleEvents(receiveOutput: { NetworkLogHandler.responseLogging(target, result: $0) })
            .eraseToAnyPublisher()
    }
    
    /// 실제 네트워크 요청 실행 메소드
    private func executeRequest(urlRequest: URLRequest, target: API) -> AnyPublisher<NetworkResponse, HeyNetworkError> {
        return performDataTask(with: urlRequest)
            .mapError { ErrorHandler.handleNoResponseError(target, error: $0) }
            .eraseToAnyPublisher()
    }
    
    /// URLSession 데이터 태스크 수행 메소드
    private func performDataTask(with urlRequest: URLRequest) -> AnyPublisher<NetworkResponse, HeyNetworkError.ResponseError> {
        return session.dataTaskPublisher(for: urlRequest)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw HeyNetworkError.ResponseError.unhandled
                }
                return NetworkResponse(data: data, response: httpResponse, error: nil)
            }
            .mapError { $0 as! HeyNetworkError.ResponseError }
            .eraseToAnyPublisher()
    }
    
    /// 응답 유효성 검사 메서드
    private func validate(response: NetworkResponse, target: API) -> AnyPublisher<Void, HeyNetworkError> {
        guard response.response.isValidateStatus() else {
            // 401 인증 오류는 TokenRetrier에서 처리되므로 여기서는 단순히 에러 반환
            let error = ErrorHandler.handleInvalidResponse(response: response)
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        return Just(())
            .setFailureType(to: HeyNetworkError.self)
            .eraseToAnyPublisher()
    }
}

// MARK: - Decoding Methods
extension BaseService {
    /// 일반 응답 디코딩 메소드
    private func decode<T: Decodable>(data: Data) -> AnyPublisher<T, HeyNetworkError.DecodeError> {
        return Just(data)
            .decode(type: GenericResponse<T>.self, decoder: JSONDecoder())
            .mapError { _ in .decodingFailed }
            .map { $0.data! }
            .eraseToAnyPublisher()
    }
    
    /// 빈 응답 디코딩 메소드
    private func decodeNoResult(data: Data) -> AnyPublisher<VoidResult, HeyNetworkError.DecodeError> {
        return Just(data)
            .decode(type: GenericResponse<VoidResult>.self, decoder: JSONDecoder())
            .mapError { _ in .decodingFailed }
            .map { _ in VoidResult() }
            .eraseToAnyPublisher()
    }
}

// HTTP 상태코드 유효성 검사 확장
extension HTTPURLResponse {
    func isValidateStatus() -> Bool {
        return (200...299).contains(self.statusCode)
    }
    
    func unAuthorized() -> Bool {
        return self.statusCode == 401
    }
}
