//
//  Color.swift
//  DSKit
//
//  Created by 류희재 on 12/18/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI

public extension Color {
    static let heyGray1 = Color(DSKitAsset.heyGray1.color)
    static let heyGray2 = Color(DSKitAsset.heyGray2.color)
    static let heyGray3 = Color(DSKitAsset.heyGray3.color)
    static let heyGray4 = Color(DSKitAsset.heyGray4.color)
    static let heyGray5 = Color(DSKitAsset.heyGray5.color)
    static let heyGray6 = Color(DSKitAsset.heyGray6.color)
    static let heyGray7 = Color(DSKitAsset.heyGray7.color)
    static let heyGray8 = Color(DSKitAsset.heyGray8.color)
    static let heyGray9 = Color(DSKitAsset.heyGray9.color)
    static let heyGray10 = Color(DSKitAsset.heyGray10.color)
    static let heyGrid = Color(DSKitAsset.heyGridColor.color)
    static let heyDimmed = Color(DSKitAsset.heyDimmedColor.color)
    static let heyGreen = Color(DSKitAsset.heyGreen.color)
    static let heyMain = Color(DSKitAsset.heyMain.color)
    static let heySubError = Color(DSKitAsset.heySubError.color)
    static let heySubMain = Color(DSKitAsset.heySubMain.color)
    static let heySubMain2 = Color(DSKitAsset.heySubMain2.color)
    static let heySubMain3 = Color(DSKitAsset.heySubMain3.color)
    static let heyWhite = Color(DSKitAsset.heyWhite.color)
    static let heyBlack = Color(DSKitAsset.heyBlack.color)
    static let heyDarkBlue = Color(DSKitAsset.heyDarkBlue.color)
}

import SwiftUI

// MARK: - 시맨틱 컬러 extension
public extension Color {
    // 시맨틱 컬러를 위한 네임스페이스
    enum Common {
        // MARK: - Background
        public enum Background {
            public static let `default` = Color(DSKitAsset.backgroundDefault.color)
            public static var opacity60 = Color(DSKitAsset.backgroundOpacity60.color)
        }
        
        // MARK: - Cursor
        public enum Cursor {
            public static let `default` = Color(DSKitAsset.cursorDefault.color)
        }
        
        // MARK: - InputField
        public enum InputField {
            public static let `default` = Color(DSKitAsset.inputDefault.color)
            public static let toDo = Color(DSKitAsset.inputfieldToDo.color)
            public static let securityCode = Color(DSKitAsset.inputfieldSecurityCode.color)
        }
        
        // MARK: - Placeholder
        public enum Placeholder {
            public static let `default` = Color(DSKitAsset.placeholderDefault.color)
        }
        
        // MARK: - Hint
        public enum Hint {
            public static let `default` = Color(DSKitAsset.hintDefault.color)
        }
        
        // MARK: - TextActive
        public enum TextActive {
            public static let `default` = Color(DSKitAsset.textActiveDefault.color)
            public static let `else` = Color(DSKitAsset.textActiveElse.color)
        }
        
        // MARK: - CTA
        public enum CTA {
            public static let active = Color(DSKitAsset.ctaActive.color)
            public static let unactive = Color(DSKitAsset.ctaUnactive.color)
            public static let onboarding = Color(DSKitAsset.ctaOnboarding.color)
        }
        
        // MARK: - CTAText
        public enum CTAText {
            public static let active = Color(DSKitAsset.ctaTextActive.color)
            public static let unactive = Color(DSKitAsset.ctaTextUnactive.color)
        }
        
        // MARK: - TextPrimary
        public enum TextPrimary {
            public static let `default` = Color(DSKitAsset.textPrimaryDefault.color)
        }
        
        // MARK: - Error
        public enum Error {
            public static let `default` = Color(DSKitAsset.errorDefault.color)
        }
        
        // MARK: - Success
        public enum Success {
            public static let `default` = Color(DSKitAsset.successDefault.color)
        }
        
        // MARK: - Button
        public enum Button {
            public static let active = Color(DSKitAsset.buttonActive.color)
            public static let active2 = Color(DSKitAsset.buttonActive2.color)
            public static let unactive = Color(DSKitAsset.buttonUnactive.color)
            public static let verify = Color(DSKitAsset.buttonVerify.color)
            public static let skip = Color(DSKitAsset.buttonSkip.color)
        }
        
        // MARK: - ButtonText
        public enum ButtonText {
            public static let verify = Color(DSKitAsset.buttonTextVerify.color)
            public static let skip = Color(DSKitAsset.buttonTextSkip.color)
        }
        
        // MARK: - ButtonClose
        public enum ButtonClose {
            public static let `default` = Color(DSKitAsset.buttonCloseDefault.color)
        }
        
        // MARK: - ButtonBack
        public enum ButtonBack {
            public static let `default` = Color(DSKitAsset.buttonBackDefault.color)
            public static let `else` = Color(DSKitAsset.buttonBackElse.color)
        }
        
        // MARK: - MainText
        public enum MainText {
            public static let `default` = Color(DSKitAsset.mainTextDefault.color)
            public static let `else` = Color(DSKitAsset.mainTextElse.color)
        }
        
        // MARK: - SubText
        public enum SubText {
            public static let `default` = Color(DSKitAsset.subTextDefault.color)
        }
        
        // MARK: - GuideText
        public enum GuideText {
            public static let `default` = Color(DSKitAsset.guideTextDefault.color)
        }
        
        // MARK: - HandleBar
        public enum HandleBar {
            public static let `default` = Color(DSKitAsset.handleBarDefault.color)
        }
        
        public enum Divider {
            public static let `default` = Color(DSKitAsset.dividerDefault.color)
        }
    }
    
    // 쉬운 접근을 위한 네임스페이스 프로퍼티
    static var common: Common.Type {
        return Common.self
    }
}
