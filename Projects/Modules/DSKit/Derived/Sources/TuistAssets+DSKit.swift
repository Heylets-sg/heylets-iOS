// swiftlint:disable all
// swift-format-ignore-file
// swiftformat:disable all
// Generated using tuist — https://github.com/tuist/tuist

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif
#if canImport(SwiftUI)
  import SwiftUI
#endif

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
public enum DSKitAsset {
  public static let accentColor = DSKitColors(name: "AccentColor")
  public static let graphicsColor = DSKitImages(name: "Graphics_color")
  public static let graphicsTimeTable = DSKitImages(name: "Graphics_timeTable")
  public static let icAdd = DSKitImages(name: "ic_add")
  public static let icBack = DSKitImages(name: "ic_back")
  public static let icCamera = DSKitImages(name: "ic_camera")
  public static let icClose = DSKitImages(name: "ic_close")
  public static let icCopy = DSKitImages(name: "ic_copy")
  public static let icDown = DSKitImages(name: "ic_down")
  public static let icError = DSKitImages(name: "ic_error")
  public static let icHide = DSKitImages(name: "ic_hide")
  public static let icMagic = DSKitImages(name: "ic_magic")
  public static let icNext = DSKitImages(name: "ic_next")
  public static let icPencil = DSKitImages(name: "ic_pencil")
  public static let icPlus = DSKitImages(name: "ic_plus")
  public static let icRepeat = DSKitImages(name: "ic_repeat")
  public static let icSchool = DSKitImages(name: "ic_school")
  public static let icSetting = DSKitImages(name: "ic_setting")
  public static let icShow = DSKitImages(name: "ic_show")
  public static let icSuccess = DSKitImages(name: "ic_success")
  public static let theme1 = DSKitImages(name: "theme1")
  public static let theme2 = DSKitImages(name: "theme2")
  public static let theme3 = DSKitImages(name: "theme3")
  public static let theme4 = DSKitImages(name: "theme4")
  public static let theme5 = DSKitImages(name: "theme5")
  public static let heyBlack = DSKitColors(name: "heyBlack")
  public static let heyDarkBlue = DSKitColors(name: "heyDarkBlue")
  public static let heyError = DSKitColors(name: "heyError")
  public static let heyGray1 = DSKitColors(name: "heyGray1")
  public static let heyGray2 = DSKitColors(name: "heyGray2")
  public static let heyGray3 = DSKitColors(name: "heyGray3")
  public static let heyGray4 = DSKitColors(name: "heyGray4")
  public static let heyGray5 = DSKitColors(name: "heyGray5")
  public static let heyGray6 = DSKitColors(name: "heyGray6")
  public static let heyGray7 = DSKitColors(name: "heyGray7")
  public static let heyGreen = DSKitColors(name: "heyGreen")
  public static let heyMain = DSKitColors(name: "heyMain")
  public static let heySubError = DSKitColors(name: "heySubError")
  public static let heySubMain = DSKitColors(name: "heySubMain")
  public static let heySubMain2 = DSKitColors(name: "heySubMain2")
  public static let heyWhite = DSKitColors(name: "heyWhite")
  public static let logo = DSKitImages(name: "logo")
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

public final class DSKitColors {
  public fileprivate(set) var name: String

  #if os(macOS)
  public typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  public typealias Color = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  public private(set) lazy var color: Color = {
    guard let color = Color(asset: self) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }()

  #if canImport(SwiftUI)
  private var _swiftUIColor: Any? = nil
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
  public private(set) var swiftUIColor: SwiftUI.Color {
    get {
      if self._swiftUIColor == nil {
        self._swiftUIColor = SwiftUI.Color(asset: self)
      }

      return self._swiftUIColor as! SwiftUI.Color
    }
    set {
      self._swiftUIColor = newValue
    }
  }
  #endif

  fileprivate init(name: String) {
    self.name = name
  }
}

public extension DSKitColors.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  convenience init?(asset: DSKitColors) {
    let bundle = DSKitResources.bundle
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
public extension SwiftUI.Color {
  init(asset: DSKitColors) {
    let bundle = DSKitResources.bundle
    self.init(asset.name, bundle: bundle)
  }
}
#endif

public struct DSKitImages {
  public fileprivate(set) var name: String

  #if os(macOS)
  public typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  public typealias Image = UIImage
  #endif

  public var image: Image {
    let bundle = DSKitResources.bundle
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let image = bundle.image(forResource: NSImage.Name(name))
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }

  #if canImport(SwiftUI)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
  public var swiftUIImage: SwiftUI.Image {
    SwiftUI.Image(asset: self)
  }
  #endif
}

public extension DSKitImages.Image {
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the DSKitImages.image property")
  convenience init?(asset: DSKitImages) {
    #if os(iOS) || os(tvOS)
    let bundle = DSKitResources.bundle
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
public extension SwiftUI.Image {
  init(asset: DSKitImages) {
    let bundle = DSKitResources.bundle
    self.init(asset.name, bundle: bundle)
  }

  init(asset: DSKitImages, label: Text) {
    let bundle = DSKitResources.bundle
    self.init(asset.name, bundle: bundle, label: label)
  }

  init(decorative asset: DSKitImages) {
    let bundle = DSKitResources.bundle
    self.init(decorative: asset.name, bundle: bundle)
  }
}
#endif

// swiftlint:enable all
// swiftformat:enable all
