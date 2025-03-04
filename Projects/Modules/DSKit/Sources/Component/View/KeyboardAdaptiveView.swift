//
//  KeyboardAdaptiveView.swift
//  DSKit
//
//  Created by 류희재 on 3/4/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Combine
import SwiftUI
//
//struct KeyboardAdaptive: ViewModifier {
//  @State private var keyboardHeight: CGFloat = 0
//  
//  private let keyboardWillShow = NotificationCenter.default
//    .publisher(for: UIResponder.keyboardWillShowNotification)
//    .compactMap { notification in
//      notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
//    }
//    .map { rect in
//      rect.height
//    }
//  
//  private let keyboardWillHide = NotificationCenter.default
//    .publisher(for: UIResponder.keyboardWillHideNotification)
//    .map { _ in CGFloat(0) }
//  
//  func body(content: Content) -> some View {
//    content
//      .padding(.bottom, keyboardHeight)
//      .onReceive(
//        Publishers.Merge(keyboardWillShow, keyboardWillHide)
//      ) { height in
//        withAnimation(.easeInOut) {
//          self.keyboardHeight = height
//        }
//      }
//  }
//}
//
//extension View {
//  public func keyboardAdaptive() -> some View {
//    ModifiedContent(content: self, modifier: KeyboardAdaptive())
//  }
//}


public class KeyboardInfo: ObservableObject {
    public static var shared = KeyboardInfo()
    
    @Published public var height: CGFloat = 0
    
    private init() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardChanged), name: UIApplication.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardChanged), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardChanged), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @objc func keyboardChanged(notification: Notification) {
        if notification.name == UIApplication.keyboardWillHideNotification {
            self.height = 0
        } else {
            self.height = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height ?? 0
        }
    }
}

struct KeyboardAware: ViewModifier {
    var minDisntance: CGFloat
    @ObservedObject private var keyboard = KeyboardInfo.shared
    
    func body(content: Content) -> some View {
        content
            .padding(.bottom, keyboard.height > 0 ? minDisntance : 0)
    }
}

extension View {
    public func scrollToMinDistance(minDisntance: CGFloat) -> some View {
        ModifiedContent(content: self, modifier: KeyboardAware(minDisntance: minDisntance))
    }
}
