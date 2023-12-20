//  Created by Shaw on 1/19/23.

import UIKit
import Infrastructure

extension UIFont {
  static var sizeIncrement: CGFloat = 0

  static func enableSizeAdjustment() {
    swizzleFontInitializersOnce
  }

  private static let swizzleFontInitializersOnce: Void = {
    swizzleClassMethod(ofClass: UIFont.self, original: #selector(UIFont.preferredFont(forTextStyle:)), override: #selector(UIFont._preferredFont(forTextStyle:)))
    swizzleClassMethod(ofClass: UIFont.self, original: #selector(UIFont.preferredFont(forTextStyle:compatibleWith:)), override: #selector(UIFont._preferredFont(forTextStyle:compatibleWith:)))
    swizzleClassMethod(ofClass: UIFont.self, original: #selector(UIFont.systemFont(ofSize:)), override: #selector(UIFont._systemFont(ofSize:)))
    swizzleClassMethod(ofClass: UIFont.self, original: #selector(UIFont.boldSystemFont(ofSize:)), override: #selector(UIFont._boldSystemFont(ofSize:)))
    swizzleClassMethod(ofClass: UIFont.self, original: #selector(UIFont.italicSystemFont(ofSize:)), override: #selector(UIFont._italicSystemFont(ofSize:)))
    swizzleClassMethod(ofClass: UIFont.self, original: #selector(UIFont.systemFont(ofSize:weight:)), override: #selector(UIFont._systemFont(ofSize:weight:)))
    if #available(iOS 16.0, *) {
      swizzleClassMethod(ofClass: UIFont.self, original: #selector(UIFont.systemFont(ofSize:weight:width:)), override: #selector(UIFont._systemFont(ofSize:weight:width:)))
    }
    swizzleClassMethod(ofClass: UIFont.self, original: #selector(UIFont.monospacedDigitSystemFont(ofSize:weight:)), override: #selector(UIFont._monospacedDigitSystemFont(ofSize:weight:)))
    swizzleClassMethod(ofClass: UIFont.self, original: #selector(UIFont.monospacedSystemFont(ofSize:weight:)), override: #selector(UIFont._monospacedSystemFont(ofSize:weight:)))
  }()

  @objc private class func _preferredFont(forTextStyle style: UIFont.TextStyle) -> UIFont {
    let font = _preferredFont(forTextStyle: style)
    return font.withSize(font.pointSize + sizeIncrement)
  }

  @objc private class func _preferredFont(forTextStyle style: UIFont.TextStyle, compatibleWith traitCollection: UITraitCollection?) -> UIFont {
    let font = _preferredFont(forTextStyle: style, compatibleWith: traitCollection)
    return font.withSize(font.pointSize + sizeIncrement)
  }

  @objc private class func _systemFont(ofSize size: CGFloat) -> UIFont {
    _systemFont(ofSize: size + sizeIncrement)
  }

  @objc private class func _boldSystemFont(ofSize fontSize: CGFloat) -> UIFont {
    _boldSystemFont(ofSize: fontSize + sizeIncrement)
  }

  @objc private class func _italicSystemFont(ofSize fontSize: CGFloat) -> UIFont {
    _italicSystemFont(ofSize: fontSize + sizeIncrement)
  }

  @objc private class func _systemFont(ofSize fontSize: CGFloat, weight: UIFont.Weight) -> UIFont {
    _systemFont(ofSize: fontSize + sizeIncrement, weight: weight)
  }

  @objc private class func _systemFont(ofSize fontSize: CGFloat, weight: UIFont.Weight, width: UIFont.Width) -> UIFont {
    _systemFont(ofSize: fontSize + sizeIncrement, weight: weight, width: width)
  }

  @objc private class func _monospacedDigitSystemFont(ofSize fontSize: CGFloat, weight: UIFont.Weight) -> UIFont {
    _monospacedDigitSystemFont(ofSize: fontSize + sizeIncrement, weight: weight)
  }

  @objc private class func _monospacedSystemFont(ofSize fontSize: CGFloat, weight: UIFont.Weight) -> UIFont {
    _monospacedSystemFont(ofSize: fontSize + sizeIncrement, weight: weight)
  }
}
