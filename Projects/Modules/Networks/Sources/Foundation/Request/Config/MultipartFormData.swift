//
//  Multipart.swift
//  Networks
//
//  Created by 류희재 on 1/11/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

public struct MultipartFormData {
    public let name: String
    public let filename: String?
    public let mimeType: String?
    public let data: Data

    public init(
        name: String,
        filename: String? = nil,
        mimeType: String? = nil,
        data: Data
    ) {
        self.name = name
        self.filename = filename
        self.mimeType = mimeType
        self.data = data
    }

    public static func text(
        _ name: String,
        _ value: String
    ) -> MultipartFormData { .init(name: name, data: Data(value.utf8)) }

    public static func file(
        name: String,
        filename: String,
        mimeType: String,
        fileData: Data
    ) -> MultipartFormData {
        .init(
            name: name,
            filename: filename,
            mimeType: mimeType,
            data: fileData
        )
    }
}
