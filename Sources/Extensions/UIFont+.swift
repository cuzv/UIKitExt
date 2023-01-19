import UIKit

// MARK: - Gen Font

extension UIFont {
  public func withWeight(_ weight: Weight) -> UIFont {
    let originalDescriptor = fontDescriptor
    var traits = originalDescriptor.object(forKey: .traits) as! [String: Any]
    traits[UIFontDescriptor.TraitKey.weight.rawValue] = weight.rawValue
    let artificalDescriptor = originalDescriptor.addingAttributes([.traits: traits])
    return .init(descriptor: artificalDescriptor, size: 0)
  }

  public func withSymbolicTraits(_ symbolicTraits: UIFontDescriptor.SymbolicTraits) -> UIFont {
    let descriptor = fontDescriptor.withSymbolicTraits(symbolicTraits) ?? fontDescriptor
    return .init(descriptor: descriptor, size: 0)
  }

  @available(iOS 13.0, *)
  public func withDesign(_ design: UIFontDescriptor.SystemDesign) -> UIFont {
    let descriptor = fontDescriptor.withDesign(design) ?? fontDescriptor
    return .init(descriptor: descriptor, size: 0)
  }

  public func relative(to style: TextStyle) -> UIFont {
    UIFontMetrics(forTextStyle: style).scaledFont(for: self)
  }
}

// MARK: - Sizing

public extension UIFont {
  static var sizeScale: CGFloat = 1.0

  @available(iOS 7.0, *)
  class func system(_ style: UIFont.TextStyle) -> UIFont {
    let font = preferredFont(forTextStyle: style)
    let scaled = font.withSize(font.pointSize * sizeScale)
    return scaled
  }

  @available(iOS 10.0, *)
  class func system(_ style: UIFont.TextStyle, compatibleWith traitCollection: UITraitCollection?) -> UIFont {
    let font = preferredFont(forTextStyle: style, compatibleWith: traitCollection)
    let scaled = font.withSize(font.pointSize * sizeScale)
    return scaled
  }

  class func system(size: CGFloat) -> UIFont {
    systemFont(ofSize: size * sizeScale)
  }

  class func boldSystem(size: CGFloat) -> UIFont {
    boldSystemFont(ofSize: size * sizeScale)
  }

  class func italicSystem(size: CGFloat) -> UIFont {
    italicSystemFont(ofSize: size * sizeScale)
  }

  @available(iOS 8.2, *)
  class func system(size: CGFloat, weight: UIFont.Weight) -> UIFont {
    systemFont(ofSize: size * sizeScale, weight: weight)
  }

  @available(iOS 9.0, *)
  class func monospacedDigitSystem(size: CGFloat, weight: UIFont.Weight) -> UIFont {
    monospacedDigitSystemFont(ofSize: size * sizeScale, weight: weight)
  }

  @available(iOS 16.0, *)
  class func system(size: CGFloat, weight: UIFont.Weight, width: UIFont.Width) -> UIFont {
    systemFont(ofSize: size * sizeScale, weight: weight, width: width)
  }

  @available(iOS 13.0, *)
  class func monospacedSystem(size: CGFloat, weight: UIFont.Weight) -> UIFont {
    monospacedSystemFont(ofSize: size * sizeScale, weight: weight)
  }
}

// MARK: - Fonts variables

extension UIFont {
  public static var headline: UIFont = .system(.headline)
  public static var subheadline: UIFont = .system(.subheadline)
  public static var body: UIFont = .system(.body)
  public static var caption2: UIFont = .system(.caption2)
  public static var caption1: UIFont = .system(.caption1)
  public static var footnote: UIFont = .system(.footnote)
  public static var callout: UIFont = .system(.callout)
  public static var title3: UIFont = .system(.title3)
  public static var title2: UIFont = .system(.title2)
  public static var title1: UIFont = .system(.title1)
}
