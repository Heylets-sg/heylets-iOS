//
//  AppServiceType.swift
//  Networks
//
//  Created by 류희재 on 1/14/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine
import SystemConfiguration
import Darwin

import Domain

// Version 및 AppStoreResponse 구현 (이전 코드에서 사용)
public struct Version: Comparable {
    let major: Int
    let minor: Int
    let patch: Int
    
    public init(_ versionString: String) {
        let components = versionString.split(separator: ".").map { Int($0) ?? 0 }
        self.major = components.count > 0 ? components[0] : 0
        self.minor = components.count > 1 ? components[1] : 0
        self.patch = components.count > 2 ? components[2] : 0
    }
    
    public static func < (lhs: Version, rhs: Version) -> Bool {
        if lhs.major != rhs.major {
            return lhs.major < rhs.major
        } else if lhs.minor != rhs.minor {
            return lhs.minor < rhs.minor
        } else {
            return lhs.patch < rhs.patch
        }
    }
    
    public var versionString: String {
        return "\(major).\(minor).\(patch)"
    }
}

//public protocol AppServiceType {
//    static func isLatestVersion() -> AnyPublisher<Bool, Never>
//    static func getLocalAppVersion() -> Version
//    static func getAppStoreVersion() -> AnyPublisher<Version, Error>
//    static func getDeviceIdentifier() -> String
//    static func getOSVersion() -> String
//    static func getDeviceModelName() -> String
//}
    
public actor AppService {
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
    
    // 키체인에 저장된 디바이스 ID를 가져오거나 없으면 생성
    static public func getDeviceIdentifier() -> String {
        if let savedID = KeychainHelper.load(key: "device_identifier") {
            return savedID
        }
        
        let newID = UUID().uuidString
        KeychainHelper.save(newID, key: "device_identifier")
        return newID
    }
    
    // ProcessInfo를 사용하여 OS 버전 가져오기
    static public func getOSVersion() -> String {
        let version = ProcessInfo.processInfo.operatingSystemVersion
        return "\(version.majorVersion).\(version.minorVersion).\(version.patchVersion)"
    }
    
    // utsname을 사용하여 디바이스 모델 이름 가져오기
    static public func getDeviceModelName() -> String {
        // 시뮬레이터 체크
        let simulatorModelName = ProcessInfo.processInfo.environment["SIMULATOR_DEVICE_NAME"] ?? ""
        if !simulatorModelName.isEmpty {
            return simulatorModelName
        }
        
        // 실제 기기 모델 코드 가져오기
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let modelCode = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        // 모델 코드를 모델 이름으로 변환 (예: "iPhone14,3" -> "iPhone 13 Pro")
        return modelCodeToMarketingName(modelCode)
    }
    
    // 모델 코드를 마케팅 이름으로 변환하는 함수
    private static func modelCodeToMarketingName(_ modelCode: String) -> String {
        // 일반적으로 사용되는 모델 코드와 마케팅 이름 매핑
        let modelMap: [String: String] = [
            // iPhone
            "iPhone14,3": "iPhone 13 Pro",
            "iPhone14,4": "iPhone 13 Mini",
            "iPhone14,5": "iPhone 13",
            "iPhone14,2": "iPhone 13 Pro Max",
            "iPhone15,2": "iPhone 14 Pro",
            "iPhone15,3": "iPhone 14 Pro Max",
            "iPhone15,4": "iPhone 14 Plus",
            "iPhone15,5": "iPhone 14",
            "iPhone16,1": "iPhone 15 Pro",
            "iPhone16,2": "iPhone 15 Pro Max",
            "iPhone16,3": "iPhone 15 Plus",
            "iPhone16,4": "iPhone 15",
            // iPad
            "iPad13,1": "iPad Air 4",
            "iPad13,2": "iPad Air 4",
            "iPad13,4": "iPad Pro 11-inch (3rd generation)",
            "iPad13,5": "iPad Pro 11-inch (3rd generation)",
            "iPad13,6": "iPad Pro 11-inch (3rd generation)",
            "iPad13,7": "iPad Pro 11-inch (3rd generation)",
            "iPad13,8": "iPad Pro 12.9-inch (5th generation)",
            "iPad13,9": "iPad Pro 12.9-inch (5th generation)",
            "iPad13,10": "iPad Pro 12.9-inch (5th generation)",
            "iPad13,11": "iPad Pro 12.9-inch (5th generation)",
            "iPad14,1": "iPad mini (6th generation)",
            "iPad14,2": "iPad mini (6th generation)",
            "iPad13,16": "iPad (10th generation)",
            "iPad13,17": "iPad (10th generation)",
            "iPad13,18": "iPad (10th generation)",
            "iPad13,19": "iPad (10th generation)",
            // 더 많은 모델 추가 가능
        ]
        
        return modelMap[modelCode] ?? modelCode // 매핑이 없으면 모델 코드 그대로 반환
    }
}

// KeychainHelper - 디바이스 ID 저장을 위한 유틸리티
private struct KeychainHelper {
    static func save(_ value: String, key: String) {
        guard let data = value.data(using: .utf8) else { return }
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecValueData as String: data,
            kSecAttrAccessible as String: kSecAttrAccessibleAfterFirstUnlock
        ]
        
        // 기존 항목 삭제 후 새로 추가
        SecItemDelete(query as CFDictionary)
        SecItemAdd(query as CFDictionary, nil)
    }
    
    static func load(key: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        guard status == errSecSuccess,
              let data = result as? Data,
              let value = String(data: data, encoding: .utf8) else {
            return nil
        }
        
        return value
    }
}
