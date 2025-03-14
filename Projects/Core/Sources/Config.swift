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
            static let amplitudeAPIKey = "AMPLITUDE_APIKEY"
        }
    }
    
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("plist cannot found.")
        }
        return dict
    }()
    
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
}
