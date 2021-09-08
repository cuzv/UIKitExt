import UIKit
import CoreGraphics

extension UIColor {
  public convenience init(r red: UInt, g green: UInt, b blue: UInt, a alpha: CGFloat = 1.0) {
    let red   = CGFloat(red) / 255.0
    let green = CGFloat(green) / 255.0
    let blue  = CGFloat(blue) / 255.0
    self.init(red: red, green: green, blue: blue, alpha: alpha)
  }

  /// 0x3300cc or 0x30c
  public convenience init(hex: UInt32, alpha: CGFloat = 1) {
    let short = hex <= 0xfff
    let divisor: CGFloat = short ? 15 : 255
    let red   = CGFloat(short  ? (hex & 0xF00) >> 8 : (hex & 0xFF0000) >> 16) / divisor
    let green = CGFloat(short  ? (hex & 0x0F0) >> 4 : (hex & 0xFF00)   >> 8)  / divisor
    let blue  = CGFloat(short  ? (hex & 0x00F)      : (hex & 0xFF))           / divisor
    self.init(red: red, green: green, blue: blue, alpha: alpha)
  }

  /// #3300cc or #30c
  public convenience init(hex: String, alpha: CGFloat = 1) {
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

// MARK: - iOS default color

extension UIColor {
  public static var random: UIColor {
    let red   = CGFloat.random(in: 0 ... 255) / 255.0
    let green = CGFloat.random(in: 0 ... 255) / 255.0
    let blue  = CGFloat.random(in: 0 ... 255) / 255.0
    return .init(red: red, green: green, blue: blue, alpha: 1)
  }

  /// - 3, 122, 255, 1
  /// - 0x037AFF
  public static let tint: UIColor = .init(hex: 0x037AFF)

  /// - 200, 199, 204, 1
  /// - 0xC8C7CC
  public static let separator: UIColor = .init(hex: 0xC8C7CC)

  /// - 69, 75, 65, 1
  /// - 0x454b41
  public static let separatorDark: UIColor = .init(hex: 0x454b41)

  /// Grouped table view background.
  /// - 239, 239, 244, 1
  /// - 0xEFEFF4
  public static let groupedBackground: UIColor = .init(hex: 0xEFEFF4)

  /// Activity background
  /// - 248, 248, 248, 0.6
  /// - 0xF8F8F8, 0.6
  public static let activityBackground: UIColor = .init(hex: 0xF8F8F8, alpha: 0.6)

  /// 0xC7C7CC
  public static let disclosureIndicator: UIColor = .init(hex: 0xC7C7CC)

  /// Navigation bar title.
  /// - 3, 3, 3, 100
  /// - 0x030303
  public static let naviTitle: UIColor = .init(hex: 0x030303)

  /// - 144, 144, 148, 100
  /// - 0x909094
  public static let subTitle: UIColor = .init(hex: 0x909094)

  /// - 200, 200, 205, 100
  /// - 0xC8C8CD
  public static let placeholder: UIColor = .init(hex: 0xC8C8CD)

  /// 0xD9D9D9
  public static let selected: UIColor = .init(hex: 0xD9D9D9)
}
