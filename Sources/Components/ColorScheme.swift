#if !(os(iOS) && (arch(i386) || arch(arm)))
import UIKit
import Combine

/// Stolen from https://github.com/Ranchero-Software/NetNewsWire
@objc public enum ColorScheme: Int {
  case automatic = 0
  case light = 1
  case dark = 2

  @available(iOS 12.0, *)
  public var userInterfaceStyle: UIUserInterfaceStyle {
    switch self {
    case .automatic:
      return .unspecified
    case .light:
      return .light
    case .dark:
      return .dark
    }
  }

  public var next: Self {
    switch self {
    case .light:
      return .dark
    default:
      return .light
    }
  }
}

extension ColorScheme: CaseIterable {}

extension ColorScheme: Identifiable {
  public var id: Int {
    rawValue
  }
}

extension ColorScheme: CustomStringConvertible {
  public var description: String {
    switch self {
    case .automatic:
      return NSLocalizedString("Automatic", comment: "")
    case .light:
      return NSLocalizedString("Light", comment: "")
    case .dark:
      return NSLocalizedString("Dark", comment: "")
    }
  }
}

// MARK: -

extension ColorScheme {
  public static var preferredColorScheme: ColorScheme {
    get { UserDefaults.standard.preferredColorScheme }
    set { UserDefaults.standard.preferredColorScheme = newValue }
  }

  @available(iOS 13.0, *)
  public static var preferredColorSchemePublisher: AnyPublisher<ColorScheme, Never> {
    UserDefaults.standard.publisher(for: \.preferredColorScheme)
      .removeDuplicates()
      .eraseToAnyPublisher()
  }
}

extension UserDefaults {
  @objc var preferredColorScheme: ColorScheme {
    get { ColorScheme(rawValue: integer(forKey: #function)) ?? .automatic  }
    set { set(newValue.rawValue, forKey: #function) }
  }
}

// MARK: -

@available(iOS 13.0, *)
extension UIWindow {
  public static func allowsPreferredColorScheme() {
    Self.swizzleInitFromWindowSceneOnce
    Self.swizzleInitFromFrameOnce
    Self.swizzleInitFromCoderOnce
  }

  private static let swizzleInitFromWindowSceneOnce: Void = {
    let cls = UIWindow.self
    let selector = #selector(UIWindow.init(windowScene:))
    guard let method = class_getInstanceMethod(cls, selector) else {
      assertionFailure("Method swizzling failed! Class: \(cls), Selector: \(selector)")
      return
    }
    let originalImpl = unsafeBitCast(
      method_getImplementation(method),
      to: (@convention(c) (UIWindow, Selector, UIWindowScene) -> UIWindow).self
    )

    class_replaceMethod(
      cls,
      selector,
      imp_implementationWithBlock({ (window: UIWindow, scene: UIWindowScene) -> UIWindow in
        defer {
          window.allowsPreferredColorScheme()
        }
        return originalImpl(window, selector, scene)
      } as @convention(block) (UIWindow, UIWindowScene) -> UIWindow),
      method_getTypeEncoding(method)
    )
  }()

  private static let swizzleInitFromFrameOnce: Void = {
    let cls = UIWindow.self
    let selector = #selector(UIWindow.init(frame:))
    guard let method = class_getInstanceMethod(cls, selector) else {
      assertionFailure("Method swizzling failed! Class: \(cls), Selector: \(selector)")
      return
    }
    let originalImpl = unsafeBitCast(
      method_getImplementation(method),
      to: (@convention(c) (UIWindow, Selector, CGRect) -> UIWindow).self
    )

    class_replaceMethod(
      cls,
      selector,
      imp_implementationWithBlock({ (window: UIWindow, frame: CGRect) -> UIWindow in
        defer {
          window.allowsPreferredColorScheme()
        }
        return originalImpl(window, selector, frame)
      } as @convention(block) (UIWindow, CGRect) -> UIWindow),
      method_getTypeEncoding(method)
    )
  }()

  private static let swizzleInitFromCoderOnce: Void = {
    let cls = UIWindow.self
    let selector = #selector(UIWindow.init(coder:))
    guard let method = class_getInstanceMethod(cls, selector) else {
      assertionFailure("Method swizzling failed! Class: \(cls), Selector: \(selector)")
      return
    }
    let originalImpl = unsafeBitCast(
      method_getImplementation(method),
      to: (@convention(c) (UIWindow, Selector, NSCoder) -> UIWindow?).self
    )

    class_replaceMethod(
      cls,
      selector,
      imp_implementationWithBlock({ (window: UIWindow, coder: NSCoder) -> UIWindow? in
        defer {
          window.allowsPreferredColorScheme()
        }
        return originalImpl(window, selector, coder)
      } as @convention(block) (UIWindow, NSCoder) -> UIWindow?),
      method_getTypeEncoding(method))
  }()
}

@available(iOS 13.0, *)
extension UIWindow {
  public func allowsPreferredColorScheme() {
    subscription = ColorScheme.preferredColorSchemePublisher
      .removeDuplicates()
      .map(\.userInterfaceStyle)
      .print("∆preferredColorScheme")
      .assign(to: \.overrideUserInterfaceStyle, on: self)

    let swipe = UISwipeGestureRecognizer(
      target: self,
      action: #selector(toggleColorScheme))
    swipe.numberOfTouchesRequired = 2
    swipe.direction = [.left, .right]
    addGestureRecognizer(swipe)
  }

  @objc private func toggleColorScheme() {
    let defaults = UserDefaults.standard
    defaults.preferredColorScheme = defaults.preferredColorScheme.next
  }

  @nonobjc private static var subscriptionKey: Void?
  private var subscription: AnyCancellable? {
    get { objc_getAssociatedObject(self, &Self.subscriptionKey) as? AnyCancellable }
    set { objc_setAssociatedObject(self, &Self.subscriptionKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
  }
}

// MARK: -

infix operator |: AdditionPrecedence

extension UIColor {
  public class func union(light: UIColor, dark: UIColor) -> UIColor {
    if #available(iOS 13.0, *) {
      return .init { _ in UserDefaults.standard.preferredColorScheme.userInterfaceStyle == .dark ? dark : light }
    } else {
      return light
    }
  }

  public static func | (light: UIColor, dark: UIColor) -> UIColor {
    union(light: light, dark: dark)
  }
}

extension UIImage {
  public class func union(light: UIImage, dark: UIImage) -> UIImage {
    if #available(iOS 13.0, *) {
      let imageAsset = UIImageAsset()
      imageAsset.register(
        light,
        with: .init(traitsFrom: [
          .init(userInterfaceStyle: .light),
          .init(displayScale: light.scale)
        ])
      )
      imageAsset.register(
        dark,
        with: .init(traitsFrom: [
          .init(userInterfaceStyle: .dark),
          .init(displayScale: dark.scale)
        ])
      )
      return imageAsset.image(with: .current)
    } else {
      return light
    }
  }

  public static func | (light: UIImage, dark: UIImage) -> UIImage {
    union(light: light, dark: dark)
  }
}
#endif