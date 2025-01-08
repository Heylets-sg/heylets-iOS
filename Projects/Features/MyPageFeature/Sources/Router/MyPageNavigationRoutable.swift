//
//  MyPageNavigationRoutable.swift
//  MyPageFeature
//
//  Created by 류희재 on 12/26/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine

import Core

public protocol MyPageNavigationRoutable {
    var destinations: [MyPageNavigationDestination] { get set }
    
    func push(to view: MyPageNavigationDestination)
    func pop()
    func popToRootView()
}
