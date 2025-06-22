//
//  Color.swift
//  DSKit
//
//  Created by 류희재 on 12/18/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI

public extension Color {
    static let heyMain = Color(.heyMain)
    static let heyWhite = Color(.heyWhite)
    static let heyBlack = Color(.heyBlack)
}

// MARK: - 시맨틱 컬러 extension
public extension Color {
    // 시맨틱 컬러를 위한 네임스페이스
    enum Common {
        // MARK: - Background
        public enum Background {
            public static let `default` = Color(.backgroundDefault)
            public static let opacity60 = Color(.backgroundOpacity60)
        }
        
        // MARK: - Cursor
        public enum Cursor {
            public static let `default` = Color(.cursorDefault)
        }
        
        // MARK: - InputField
        public enum InputField {
            public static let `default` = Color(.inputDefault)
            public static let toDo = Color(.inputfieldToDo)
            public static let securityCode = Color(.inputfieldSecurityCode)
        }
        
        // MARK: - Placeholder
        public enum Placeholder {
            public static let `default` = Color(.placeholderDefault)
        }
        
        // MARK: - Hint
        public enum Hint {
            public static let `default` = Color(.hintDefault)
        }
        
        // MARK: - TextActive
        public enum TextActive {
            public static let `default` = Color(.textActiveDefault)
            public static let `else` = Color(.textActiveElse)
        }
        
        // MARK: - CTA
        public enum CTA {
            public static let active = Color(.ctaActive)
            public static let unactive = Color(.ctaUnactive)
            public static let onboarding = Color(.ctaOnboarding)
        }
        
        // MARK: - CTAText
        public enum CTAText {
            public static let active = Color(.ctaTextActive)
            public static let unactive = Color(.ctaTextUnactive)
        }
        
        // MARK: - TextPrimary
        public enum TextPrimary {
            public static let `default` = Color(.textPrimaryDefault)
        }
        
        // MARK: - Error
        public enum Error {
            public static let `default` = Color(.errorDefault)
        }
        
        // MARK: - Success
        public enum Success {
            public static let `default` = Color(.successDefault)
        }
        
        // MARK: - Button
        public enum Button {
            public static let active = Color(.buttonActive)
            public static let active2 = Color(.buttonActive2)
            public static let unactive = Color(.buttonUnactive)
            public static let verify = Color(.buttonVerify)
            public static let skip = Color(.buttonSkip)
            
            public enum Save {
                public static let active = Color(.buttonSaveActive)
                public static let unactive = Color(.buttonSaveUnactive)
            }
        }
        
        // MARK: - ButtonText
        public enum ButtonText {
            public static let verify = Color(.buttonTextVerify)
            public static let skip = Color(.buttonTextSkip)
        }
        
        // MARK: - ButtonClose
        public enum ButtonClose {
            public static let `default` = Color(.buttonCloseDefault)
        }
        
        // MARK: - ButtonBack
        public enum ButtonBack {
            public static let `default` = Color(.buttonBackDefault)
            public static let `else` = Color(.buttonBackElse)
        }
        
        // MARK: - MainText
        public enum MainText {
            public static let `default` = Color(.mainTextDefault)
            public static let `else` = Color(.mainTextElse)
        }
        
        // MARK: - SubText
        public enum SubText {
            public static let `default` = Color(.subTextDefault)
        }
        
        // MARK: - GuideText
        public enum GuideText {
            public static let `default` = Color(.guideTextDefault)
        }
        
        // MARK: - HandleBar
        public enum HandleBar {
            public static let `default` = Color(.handleBarDefault)
        }
        
        public enum Divider {
            public static let `default` = Color(.dividerDefault)
        }
        
        public enum Check {
            public static let active = Color(.checkActive)
            public static let unactive = Color(.checkUnactive)
        }
    }
    
    // 쉬운 접근을 위한 네임스페이스 프로퍼티
    static var common: Common.Type {
        return Common.self
    }
}
