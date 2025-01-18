//
//  DeleteAccountDTO.swift
//  Networks
//
//  Created by 류희재 on 1/17/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

public struct DeleteAccountRequest: Encodable {
    let password: String
    
    public init(_ password: String) {
        self.password = password
    }
}

