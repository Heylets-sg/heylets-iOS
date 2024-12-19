////
////  DIContainerProtocol.swift
////  Core
////
////  Created by 류희재 on 12/19/24.
////  Copyright © 2024 Heylets-iOS. All rights reserved.
////
//
//import Foundation
//
//public protocol DIContainerProtocol {
//    func register<T>(_ type: T.Type, factory: @escaping () -> T)
//    func resolve<T>(_ type: T.Type) -> T?
//}
//
//final public class DIContainer: DIContainerProtocol, ObservableObject {
//    public init() {}
//    private var registry: [String: Any] = [:]
//    
//    // 의존성 등록
//    public func register<T>(_ type: T.Type, factory: @escaping () -> T) {
//        let key = String(describing: type)
//        registry[key] = factory
//    }
//    
//    // 의존성 해결
//    public func resolve<T>(_ type: T.Type) -> T? {
//        let key = String(describing: type)
//        guard let factory = registry[key] as? () -> T else { return nil }
//        return factory()
//    }
//}
