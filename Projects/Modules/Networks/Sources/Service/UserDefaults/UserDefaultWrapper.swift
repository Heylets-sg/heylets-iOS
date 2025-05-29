////
////  UserDefaultWrapper.swift
////  Networks
////
////  Created by 류희재 on 1/19/25.
////  Copyright © 2025 Heylets-iOS. All rights reserved.
////
//
//import Foundation
//
//@propertyWrapper
//public struct UserDefaultWrapper<T>: @unchecked Sendable {
//    private let key: String
//    private let defaultValue: T
//    
//    public var wrappedValue: T {
//        get {
//            return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
//        }
//        set {
//            UserDefaults.standard.set(newValue, forKey: key)
//        }
//    }
//    
//    init(key: String, defaultValue: T) {
//        self.key = key
//        self.defaultValue = defaultValue
//    }
//}
//
