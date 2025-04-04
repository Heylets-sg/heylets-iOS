//
//  CGFloat+.swift
//  Core
//
//  Created by 류희재 on 4/4/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import UIKit

public extension Int {
    var adjusted: CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        let ratio: CGFloat = screenWidth / 390
        let ratioH: CGFloat = screenHeight / 844
        return ratio <= ratioH ? CGFloat(self) * ratio : CGFloat(self) * ratioH
    }
    
    func adjusted(_ height: Int) -> CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        let ratio: CGFloat = screenWidth / 390
        let ratioH: CGFloat = screenHeight / 844
        return ratio <= ratioH ? CGFloat(self) * ratio : CGFloat(self) * ratioH
    }
}
