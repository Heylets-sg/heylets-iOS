//
//  Config.swift
//  Core
//
//  Created by 류희재 on 3/14/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

public enum Config {
    enum Keys {
        enum Plist {
            static let baseURL = "BASE_URL"
            static let amplitudeAPIKey = "AMPLITUDE_API_KEY"
            static let env = "ENV"
        }
    }
    
    private static var infoDictionary: [String: Any] {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Info.plist not found.")
        }
        return dict
    }
    
    static public let baseURL: String = {
        guard let key = Config.infoDictionary[Keys.Plist.baseURL] as? String else {
            fatalError("Base URL is not set in plist for this configuration.")
        }
        return key
    }()
    
    static public let amplitudeAPIKey: String = {
        guard let key = Config.infoDictionary[Keys.Plist.amplitudeAPIKey] as? String else {
            fatalError("Base URL is not set in plist for this configuration.")
        }
        return key
    }()
    
    static public let environment: String = {
        guard let key = Config.infoDictionary[Keys.Plist.env] as? String else {
            fatalError("Enviroment is not set in plist for this configuration.")
        }
        return key
    }()
}

extension Config {
    public static var isDevEnvironment: Bool {
        return environment == "DEV"
    }
    
    public static var isTestEnvironment: Bool {
        return environment == "DEV" || environment == "QA"
    }
}
