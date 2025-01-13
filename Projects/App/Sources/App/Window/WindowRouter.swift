//
//  WindowRouter.swift
//  BaseFeatureDependency
//
//  Created by 류희재 on 12/19/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

//import Foundation
//import Combine
//
//import Core
//import BaseFeatureDependency
//
//final class WindowRouter: WindowRoutable, ObservableObjectSettable {
//    
//    public var objectWillChange: ObservableObjectPublisher?
//    
//    var destination: WindowDestination = .splash {
//        didSet {
//            objectWillChange?.send()
//        }
//    }
//    
//    func `switch`(to destination: WindowDestination) {
//        self.destination = destination
//    }
//}
