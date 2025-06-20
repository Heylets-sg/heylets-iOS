import Foundation
import Security

public struct SecureTokenStorage {
    private init() {}  // 인스턴스 생성 금지
    
    public static func setAuthTokens(access: String, refresh: String?) {
        saveToKeychain(access, key: "heyAccessToken")
        saveToKeychain(refresh ?? "", key: "heyRefreshToken")
        print("🔐 인증 토큰 안전하게 저장 완료")
    }
    
    public static func getAccessToken() -> String {
        loadFromKeychain(key: "heyAccessToken") ?? ""
    }
    
    public static func getRefreshToken() -> String {
        loadFromKeychain(key: "heyRefreshToken") ?? ""
    }
    
    public static func clearAuthTokens() {
        deleteFromKeychain(key: "heyAccessToken")
        deleteFromKeychain(key: "heyRefreshToken")
        print("🗑️ 인증 토큰 삭제 완료")
    }
    
    public static func isTokenExist() -> Bool {
        !getAccessToken().isEmpty
    }
    
    // MARK: - Private Keychain Operations
    private static func saveToKeychain(_ value: String, key: String) {
        let data = Data(value.utf8)
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecValueData as String: data,
            kSecAttrAccessible as String: kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly
        ]
        
        // 기존 항목 삭제 후 새로 추가
        SecItemDelete(query as CFDictionary)
        let status = SecItemAdd(query as CFDictionary, nil)
        
        // 🎯 작은 개선: 에러 로깅
        if status != errSecSuccess {
            print("❌ Keychain 저장 실패 [\(key)]: \(status)")
        }
    }
    
    private static func loadFromKeychain(key: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        if status == errSecSuccess,
           let data = result as? Data {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }
    
    private static func deleteFromKeychain(key: String) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key
        ]
        SecItemDelete(query as CFDictionary)
    }
}
