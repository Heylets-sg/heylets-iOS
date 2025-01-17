//
//  Version.swift
//  Domain
//
//  Created by 류희재 on 1/14/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

public struct Version {
    
    let major: Int
    let minor: Int
    let patch: Int

    public var versionString: String {
        return "\(major).\(minor).\(patch)"
    }

    public init(_ versionString: String) {
        let versions = versionString.split(separator: ".").map{ Int($0) }
        self.major = versions[0] ?? 0
        self.minor = versions[1] ?? 0
        self.patch = 0
    }
}

extension Version : Comparable {
    
    static public func < (lhs: Version, rhs: Version) -> Bool {
        guard lhs.major == rhs.major else { return lhs.major < rhs.major }
        guard lhs.minor == rhs.minor else { return lhs.minor < rhs.minor }
        return lhs.patch < rhs.patch
    }
    
}

