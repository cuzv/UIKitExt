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

  static var random: UIColor {
    let red = CGFloat.random(in: 0 ... 255) / 255.0
    let green = CGFloat.random(in: 0 ... 255) / 255.0
    let blue = CGFloat.random(in: 0 ... 255) / 255.0
    return .init(red: red, green: green, blue: blue, alpha: 1)
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

/*
 public extension UIColor {
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
 */

// MARK: - Dark mode

public extension UIColor {
  @available(iOS 13.0, *)
  var resolvedTraitColors: (light: UIColor, dark: UIColor) {
    let light = resolvedColor(with: .init(userInterfaceStyle: .light))
    let dark = resolvedColor(with: .init(userInterfaceStyle: .dark))
    return (light, dark)
  }
}

public extension UIColor {
  // MARK: - Fill Colors

  /// An overlay fill color for thin and small shapes.
  ///
  /// Use system fill colors for items situated on top of an existing background color.
  /// System fill colors incorporate transparency to allow the background color to show through.
  ///
  /// Use this color to fill thin or small shapes, such as the track of a slider.
  static let fill: UIColor = .systemFill

  /// An overlay fill color for medium-size shapes.
  ///
  /// Use system fill colors for items situated on top of an existing background color.
  /// System fill colors incorporate transparency to allow the background color to show through.
  ///
  /// Use this color to fill medium-size shapes, such as the background of a switch.
  static let secondaryFill: UIColor = .secondarySystemFill

  /// An overlay fill color for large shapes.
  ///
  /// Use system fill colors for items situated on top of an existing background color.
  /// System fill colors incorporate transparency to allow the background color to show through.
  ///
  /// Use this color to fill large shapes, such as input fields, search bars, or buttons.
  static let tertiaryFill: UIColor = .tertiarySystemFill

  /// An overlay fill color for large areas that contain complex content.
  ///
  /// Use system fill colors for items situated on top of an existing background color.
  /// System fill colors incorporate transparency to allow the background color to show through.
  ///
  /// Use this color to fill large areas that contain complex content, such as an expanded table cell.
  static let quaternaryFill: UIColor = .quaternarySystemFill

  // MARK: - Background Colors

  /// The color for the main background of your interface.
  static let background: UIColor = .systemBackground

  /// The color for content layered on top of the main background.
  static let secondaryBackground: UIColor = .secondarySystemBackground

  /// The color for content layered on top of secondary backgrounds.
  static var tertiaryBackground: UIColor = .tertiarySystemBackground

  // MARK: - Grouped Background Colors

  /// The color for the main background of your grouped interface.
  static var groupedBackground: UIColor = .systemGroupedBackground

  /// The color for content layered on top of the main background of your grouped interface.
  static var secondaryGroupedBackground: UIColor = .secondarySystemGroupedBackground

  /// The color for content layered on top of secondary backgrounds of your grouped interface.
  static var tertiaryGroupedBackground: UIColor = .tertiarySystemGroupedBackground
}
