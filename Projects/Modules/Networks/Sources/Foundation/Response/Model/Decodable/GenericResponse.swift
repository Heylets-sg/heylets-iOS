//
//  GenericResponse.swift
//  Networks
//
//  Created by 류희재 on 1/8/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

struct GenericResponse<T: Decodable>: Decodable {
    var success: Bool
    var message: String?
    var data: T?
    var metaData: MetaData
    
    enum CodingKeys: CodingKey {
        case success
        case message
        case data
        case metadata
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.success = ((try? container.decode(Int.self, forKey: .success)) != nil)
        self.message = (try? container.decode(String.self, forKey: .message)) ?? ""
        self.data = try container.decodeIfPresent(T.self, forKey: .data)
        self.metaData = try container.decode(MetaData.self, forKey: .metadata)
    }
}

struct MetaData: Codable {
    let timestamp, apiVersion, traceID: String
    let extra: String?
    
    enum CodingKeys: String, CodingKey {
        case timestamp, apiVersion
        case traceID = "traceId"
        case extra
    }
}

