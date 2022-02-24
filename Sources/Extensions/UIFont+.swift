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
}

// MARK: - Fonts variables

extension UIFont {
  public static let size8: UIFont = .systemFont(ofSize: 8.0)
  public static let size9: UIFont = .systemFont(ofSize: 9.0)
  public static let size10: UIFont = .systemFont(ofSize: 10.0)
  public static let size11: UIFont = .systemFont(ofSize: 11.0)
  public static let size12: UIFont = .systemFont(ofSize: 12.0)
  public static let size13: UIFont = .systemFont(ofSize: 13.0)
  public static let size14: UIFont = .systemFont(ofSize: 14.0)
  public static let size15: UIFont = .systemFont(ofSize: 15.0)
  public static let size16: UIFont = .systemFont(ofSize: 16.0)
  public static let size17: UIFont = .systemFont(ofSize: 17.0)
  public static let size18: UIFont = .systemFont(ofSize: 18.0)
  public static let size19: UIFont = .systemFont(ofSize: 19.0)
  public static let size20: UIFont = .systemFont(ofSize: 20.0)
  public static let size21: UIFont = .systemFont(ofSize: 21.0)
  public static let size22: UIFont = .systemFont(ofSize: 22.0)
  public static let size23: UIFont = .systemFont(ofSize: 23.0)
  public static let size24: UIFont = .systemFont(ofSize: 24.0)
  public static let size26: UIFont = .systemFont(ofSize: 26.0)
  public static let size28: UIFont = .systemFont(ofSize: 28.0)
  public static let size30: UIFont = .systemFont(ofSize: 30.0)
  public static let size32: UIFont = .systemFont(ofSize: 32.0)
  public static let size34: UIFont = .systemFont(ofSize: 34.0)
  public static let size36: UIFont = .systemFont(ofSize: 36.0)
  public static let size38: UIFont = .systemFont(ofSize: 38.0)
  public static let size40: UIFont = .systemFont(ofSize: 40.0)

  public static let headline: UIFont = .preferredFont(forTextStyle: .headline)
  public static let subheadline: UIFont = .preferredFont(forTextStyle: .subheadline)
  public static let body: UIFont = .preferredFont(forTextStyle: .body)
  public static let caption2: UIFont = .preferredFont(forTextStyle: .caption2)
  public static let caption1: UIFont = .preferredFont(forTextStyle: .caption1)
  public static let footnote: UIFont = .preferredFont(forTextStyle: .footnote)
  public static let callout: UIFont = .preferredFont(forTextStyle: .callout)
  public static let title3: UIFont = .preferredFont(forTextStyle: .title3)
  public static let title2: UIFont = .preferredFont(forTextStyle: .title2)
  public static let title1: UIFont = .preferredFont(forTextStyle: .title1)
}
