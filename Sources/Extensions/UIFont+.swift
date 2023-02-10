import UIKit

// MARK: - Gen Font

public extension UIFont {
  /// Only system fonts are in effect
  func with(weight: Weight) -> UIFont {
    let descriptor = fontDescriptor.addingAttributes([
      .traits : [
        UIFontDescriptor.TraitKey.weight: weight,
      ]
    ])
    return UIFont(descriptor: descriptor, size: 0)
  }

  /// Only system fonts are in effect
  func with(width: UIFont.Width) -> UIFont {
    let descriptor = fontDescriptor.addingAttributes([
      .traits : [
        UIFontDescriptor.TraitKey.width: width,
      ]
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

extension UIFont {
  public static var headline: UIFont { .system(.headline) }
  public static var subheadline: UIFont { .system(.subheadline) }
  public static var body: UIFont { .system(.body) }
  public static var caption2: UIFont { .system(.caption2) }
  public static var caption1: UIFont { .system(.caption1) }
  public static var footnote: UIFont { .system(.footnote) }
  public static var callout: UIFont { .system(.callout) }
  public static var title3: UIFont { .system(.title3) }
  public static var title2: UIFont { .system(.title2) }
  public static var title1: UIFont { .system(.title1) }
}

// MARK: - TextFontDescriptor

@available(iOS 13.0, *)
public struct TextFontDescriptor {
  let family: String?
  let size: CGFloat
  let style: UIFont.TextStyle
  let weight: UIFont.Weight
  let width: UIFont.Width
  let design: UIFontDescriptor.SystemDesign

  public init(family: String? = nil, size: CGFloat = 0, style: UIFont.TextStyle = .body, weight: UIFont.Weight = .regular, width: UIFont.Width = .init(rawValue: 0), design: UIFontDescriptor.SystemDesign = .default) {
    self.family = family
    self.size = size
    self.style = style
    self.weight = weight
    self.width = width
    self.design = design
  }

  public var uiFont: UIFont {
    let descriptor: UIFontDescriptor

    if let family = family {
      // Custom font
      descriptor = UIFontDescriptor(fontAttributes: [
        .family: family,
        .size : size,
        .traits: [
          UIFontDescriptor.TraitKey.weight: weight,
          UIFontDescriptor.TraitKey.width: width,
        ],
      ])
    } else {
      // System font
      let styles: [UIFont.TextStyle] = [
        .largeTitle, .title1, .title2, .title3,
        .headline, .subheadline, .body,
        .callout, .footnote, .caption1, .caption2,
      ]

      if styles.contains(style) {
        descriptor = UIFont.preferredFont(forTextStyle: style)
          .fontDescriptor
          .addingAttributes([
            .traits : [
              UIFontDescriptor.TraitKey.weight: weight,
              UIFontDescriptor.TraitKey.width: width,
            ]
          ])
      } else {
        if #available(iOS 16.0, *) {
          descriptor = UIFont.systemFont(ofSize: size, weight: weight, width: width)
            .fontDescriptor
        } else {
          descriptor = UIFont.systemFont(ofSize: size, weight: weight)
            .fontDescriptor
            .addingAttributes([.traits : [UIFontDescriptor.TraitKey.width: width]])
        }
      }
    }

    let font = UIFont(descriptor: (descriptor.withDesign(design) ?? descriptor), size: 0)
    return UIFontMetrics(forTextStyle: style).scaledFont(for: font)
  }

  public func with(family: String?, design: UIFontDescriptor.SystemDesign, scale: CGFloat) -> Self {
    .init(
      family: family,
      size: size * scale,
      style: style,
      weight: weight,
      width: width,
      design: design
    )
  }
}

@available(iOS 13.0, *)
extension UIFont {
  public static func new(_ descriptor: TextFontDescriptor) -> UIFont {
    descriptor.uiFont
  }
}
