import CoreGraphics
import UIKit

public extension UIColor {
  convenience init(
    r red: UInt,
    g green: UInt,
    b blue: UInt,
    a alpha: CGFloat = 1.0
  ) {
    let red = CGFloat(red) / 255.0
    let green = CGFloat(green) / 255.0
    let blue = CGFloat(blue) / 255.0
    self.init(red: red, green: green, blue: blue, alpha: alpha)
  }

  /// 0x3300cc or 0x30c
  convenience init(hex: UInt32, alpha: CGFloat = 1) {
    let short = hex <= 0xFFF
    let divisor: CGFloat = short ? 15 : 255
    let red = CGFloat(short ? (hex & 0xF00) >> 8 : (hex & 0xFF0000) >> 16) / divisor
    let green = CGFloat(short ? (hex & 0x0F0) >> 4 : (hex & 0xFF00) >> 8) / divisor
    let blue = CGFloat(short ? (hex & 0x00F) : (hex & 0xFF)) / divisor
    self.init(red: red, green: green, blue: blue, alpha: alpha)
  }

  /// #3300cc or #30c
  convenience init(hex: String, alpha: CGFloat = 1) {
    // Convert hex string to an integer
    var hexint: UInt32 = 0

    // Create scanner
    let scanner = Scanner(string: hex)

    // Tell scanner to skip the # character
    scanner.charactersToBeSkipped = CharacterSet(charactersIn: "#")
    scanner.scanHexInt32(&hexint)

    self.init(hex: hexint, alpha: alpha)
  }
}

public extension Int {
  func toHexColor(alpha: CGFloat = 1) -> UIColor {
    .init(hex: UInt32(self), alpha: alpha)
  }

  var hexColor: UIColor {
    toHexColor()
  }
}

public extension String {
  func toHexColor(alpha: CGFloat = 1) -> UIColor {
    .init(hex: self, alpha: alpha)
  }

  var hexColor: UIColor {
    toHexColor()
  }
}

// MARK: - iOS default color

public extension UIColor {
  static var random: UIColor {
    let red = CGFloat.random(in: 0 ... 255) / 255.0
    let green = CGFloat.random(in: 0 ... 255) / 255.0
    let blue = CGFloat.random(in: 0 ... 255) / 255.0
    return .init(red: red, green: green, blue: blue, alpha: 1)
  }

  /// - 3, 122, 255, 1
  /// - 0x037AFF
  static let tint: UIColor = .init(hex: 0x037AFF)

  /// - 200, 199, 204, 1
  /// - 0xC8C7CC
  static let separator: UIColor = .init(hex: 0xC8C7CC)

  /// - 69, 75, 65, 1
  /// - 0x454b41
  static let separatorDark: UIColor = .init(hex: 0x454B41)

  /// Grouped table view background.
  /// - 239, 239, 244, 1
  /// - 0xEFEFF4
  static let groupedBackground: UIColor = .init(hex: 0xEFEFF4)

  /// Activity background
  /// - 248, 248, 248, 0.6
  /// - 0xF8F8F8, 0.6
  static let activityBackground: UIColor = .init(hex: 0xF8F8F8, alpha: 0.6)

  /// 0xC7C7CC
  static let disclosureIndicator: UIColor = .init(hex: 0xC7C7CC)

  /// Navigation bar title.
  /// - 3, 3, 3, 100
  /// - 0x030303
  static let naviTitle: UIColor = .init(hex: 0x030303)

  /// - 144, 144, 148, 100
  /// - 0x909094
  static let subTitle: UIColor = .init(hex: 0x909094)

  /// - 200, 200, 205, 100
  /// - 0xC8C8CD
  static let placeholder: UIColor = .init(hex: 0xC8C8CD)

  /// 0xD9D9D9
  static let selected: UIColor = .init(hex: 0xD9D9D9)
}

public extension UIColor {
  static var background: UIColor {
    if #available(iOS 13.0, *) {
      .systemBackground
    } else {
      .white
    }
  }

  static var foreground: UIColor {
    if #available(iOS 13.0, *) {
      .label
    } else {
      .black
    }
  }
}

// MARK: - Dark mode

public extension UIColor {
  @available(iOS 13.0, *)
  var resolvedTraitColors: (light: UIColor, dark: UIColor) {
    let light = resolvedColor(with: .init(userInterfaceStyle: .light))
    let dark = resolvedColor(with: .init(userInterfaceStyle: .dark))
    return (light, dark)
  }
}
