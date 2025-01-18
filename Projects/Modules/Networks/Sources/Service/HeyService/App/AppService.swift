//
//  AppServiceType.swift
//  Networks
//
//  Created by 류희재 on 1/14/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine
import UIKit

import Domain

//public protocol AppServiceType {
//    static func isLatestVersion() -> AnyPublisher<Bool, Never>
//    static func getLocalAppVersion() -> Version
//    static func getAppStoreVersion() -> AnyPublisher<Version, Error>
//    static func getDeviceIdentifier() -> String
//    static func getOSVersion() -> String
//    static func getDeviceModelName() -> String
//}
    

public struct AppService {
    public static let shared = AppService()
    private init() {}
    static func isLatestVersion() -> AnyPublisher<Bool, Never> {
        getAppStoreVersion()
            .map { (appStore: $0, local: getLocalAppVersion()) }
            .map { $0.appStore <= $0.local }
            .catch { _ in return Just(true)} // 앱스토어 버전을 가져오지 못하면 항상 최신 버전으로 처리
            .eraseToAnyPublisher()
    }
    
    static public func getLocalAppVersion() -> Version {
        guard let dictionary = Bundle.main.infoDictionary,
              let version = dictionary["CFBundleShortVersionString"] as? String
        else { return Version("0.0.0") }
        return Version(version)
    }
    
    static public func getAppStoreVersion() -> AnyPublisher<Version, Error> {
        Just(())
            .tryMap {
                guard let bundleID = Bundle.main.infoDictionary?["CFBundleIdentifier"] as? String,
                      let url = URL(string: "http://itunes.apple.com/lookup?bundleId=" + bundleID)
                else { throw NSError() }
                return url
            }
            .flatMap {
                URLSession.shared.dataTaskPublisher(for: $0)
                    .tryMap { output in
                        guard let response = output.response as? HTTPURLResponse,
                              (200...299).contains(response.statusCode)
                        else {
                            throw NSError()
                        }
                        print(output.data)
                        return output.data
                    }
            }
            .decode(type: AppStoreResponse.self, decoder: JSONDecoder())
            .compactMap { $0.results.first?.version }
            .map { Version($0) }
            .eraseToAnyPublisher()
    }
    
    // App Store에 설치되어 있지 않으면 bundleID를 반환한다.
    static public func getDeviceIdentifier() -> String {
        return UIDevice.current.identifierForVendor?.uuidString ?? ""
    }
    
    static public func getOSVersion() -> String {
        return UIDevice.current.systemVersion
    }
    
    static public func getDeviceModelName() -> String {
            // [1]. 시뮬레이터 체크 수행 실시
            var modelName = ProcessInfo.processInfo.environment["SIMULATOR_DEVICE_NAME"] ?? ""
            if modelName.isEmpty == false && modelName.count > 0 {
                return modelName
            }
            
            // [2]. 실제 디바이스 체크 수행 실시
            let device = UIDevice.current
            let selName = "_\("deviceInfo")ForKey:"
            let selector = NSSelectorFromString(selName)
            
            if device.responds(to: selector) { // [옵셔널 체크 실시]
                modelName = String(describing: device.perform(selector, with: "marketing-name").takeRetainedValue())
            }
            return modelName
        }
}
