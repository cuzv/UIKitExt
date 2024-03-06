import UIKit

// MARK: - Gen Font

public extension UIFont {
  /// Only system fonts are in effect
  func with(weight: Weight) -> UIFont {
    let descriptor = fontDescriptor.addingAttributes([
      .traits: [
        UIFontDescriptor.TraitKey.weight: weight,
      ],
    ])
    return UIFont(descriptor: descriptor, size: 0)
  }

  /// Only system fonts are in effect
  func with(width: UIFont.Width) -> UIFont {
    let descriptor = fontDescriptor.addingAttributes([
      .traits: [
        UIFontDescriptor.TraitKey.width: width,
      ],
    ])
    return UIFont(descriptor: descriptor, size: 0)
  }

  /// Only system fonts are in effect
  func with(symbolicTraits: UIFontDescriptor.SymbolicTraits) -> UIFont {
    let descriptor = fontDescriptor.withSymbolicTraits(symbolicTraits) ?? fontDescriptor
    return .init(descriptor: descriptor, size: 0)
  }

  /// Only system fonts are in effect
  @available(iOS 13.0, *)
  func with(design: UIFontDescriptor.SystemDesign) -> UIFont {
    let descriptor = fontDescriptor.withDesign(design) ?? fontDescriptor
    return .init(descriptor: descriptor, size: 0)
  }

  func relative(to style: TextStyle) -> UIFont {
    UIFontMetrics(forTextStyle: style).scaledFont(for: self)
  }
}

// MARK: - Sizing

public extension UIFont {
  @available(iOS 7.0, *)
  class func system(_ style: UIFont.TextStyle) -> UIFont {
    preferredFont(forTextStyle: style)
  }

  @available(iOS 10.0, *)
  class func system(_ style: UIFont.TextStyle, compatibleWith traitCollection: UITraitCollection?) -> UIFont {
    preferredFont(forTextStyle: style, compatibleWith: traitCollection)
  }

  class func system(size: CGFloat) -> UIFont {
    systemFont(ofSize: size)
  }

  class func boldSystem(size: CGFloat) -> UIFont {
    boldSystemFont(ofSize: size)
  }

  class func italicSystem(size: CGFloat) -> UIFont {
    italicSystemFont(ofSize: size)
  }

  @available(iOS 8.2, *)
  class func system(size: CGFloat, weight: UIFont.Weight) -> UIFont {
    systemFont(ofSize: size, weight: weight)
  }

  @available(iOS 9.0, *)
  class func monospacedDigitSystem(size: CGFloat, weight: UIFont.Weight) -> UIFont {
    monospacedDigitSystemFont(ofSize: size, weight: weight)
  }

  @available(iOS 16.0, *)
  class func system(size: CGFloat, weight: UIFont.Weight, width: UIFont.Width) -> UIFont {
    systemFont(ofSize: size, weight: weight, width: width)
  }

  @available(iOS 13.0, *)
  class func monospacedSystem(size: CGFloat, weight: UIFont.Weight) -> UIFont {
    monospacedSystemFont(ofSize: size, weight: weight)
  }
}

// MARK: - Fonts variables

public extension UIFont {
  static var headline: UIFont { .system(.headline) }
  static var subheadline: UIFont { .system(.subheadline) }
  static var body: UIFont { .system(.body) }
  static var caption2: UIFont { .system(.caption2) }
  static var caption1: UIFont { .system(.caption1) }
  static var footnote: UIFont { .system(.footnote) }
  static var callout: UIFont { .system(.callout) }
  static var title3: UIFont { .system(.title3) }
  static var title2: UIFont { .system(.title2) }
  static var title1: UIFont { .system(.title1) }
}

// MARK: - Design

public extension UIFont {
  /// https://www.jianshu.com/p/a0390f70ea36
  ///
  /// ```swift
  ///   let style = NSMutableParagraphStyle()
  ///   style.lineSpacing = font.lineSpacing(`sizeOfDesignMark`)
  ///   label.attributedText = NSAttributedString(string: text, attributes: [.paragraphStyle: style])
  /// ```
  func lineSpacing(_ value: CGFloat) -> CGFloat {
    value - (lineHeight - pointSize)
  }

  /// https://www.shejidaren.com/ui-sheji-gao-huanyuan-fangfa.html
  ///
  /// x + 2 * ceil(x / 10)
  var singleLineHeight: CGFloat {
    pointSize + 2 * ceil(pointSize / 10.0)
  }
}
