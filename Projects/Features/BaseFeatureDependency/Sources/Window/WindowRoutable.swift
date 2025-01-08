//
//  WindowRoutable.swift
//  BaseFeatureDependency
//
//  Created by 류희재 on 12/19/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine

public protocol WindowRoutable {
    var destination: WindowDestination { get }
    func `switch`(to destination: WindowDestination)
}
