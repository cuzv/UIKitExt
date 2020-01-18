import UIKit

// MARK: - Gen Font

@available(iOS 8.2, *)
extension UIFont {
    /// Weight value is UIFontWeightLight, etc.
    private func remake(weight: UIFont.Weight) -> UIFont {
        let originalDescriptor = fontDescriptor
        var traits = originalDescriptor.object(forKey: .traits) as! [String: Any]
        traits[UIFontDescriptor.TraitKey.weight.rawValue] = weight.rawValue
        let artificalDescriptor = originalDescriptor.addingAttributes([.traits: traits])
        return UIFont(descriptor: artificalDescriptor, size: 0)
    }

    public func ultraLight() -> UIFont { remake(weight: .ultraLight) }
    public func thin() -> UIFont { remake(weight: .thin) }
    public func light() -> UIFont { remake(weight: .light) }
    public func regular() -> UIFont { remake(weight: .regular) }
    public func medium() -> UIFont { remake(weight: .medium) }
    public func semibold() -> UIFont { remake(weight: .semibold) }
    public func bold() -> UIFont { remake(weight: .bold) }
    public func heavy() -> UIFont { remake(weight: .heavy) }
    public func black() -> UIFont { remake(weight: .black) }
}

@available(iOS 7.0, *)
extension UIFont {
    private func remake(symbolicTraits: UIFontDescriptor.SymbolicTraits) -> UIFont {
        let descriptor = fontDescriptor.withSymbolicTraits(symbolicTraits)
        return .init(descriptor: descriptor!, size: 0)
    }

    public func traitItalic() -> UIFont { remake(symbolicTraits: .traitItalic) }
    public func traitBold() -> UIFont { remake(symbolicTraits: .traitBold) }
    // expanded and condensed traits are mutually exclusive
    public func traitExpanded() -> UIFont { remake(symbolicTraits: .traitExpanded) }
    public func traitCondensed() -> UIFont { remake(symbolicTraits: .traitCondensed) }
    // Use fixed-pitch glyphs if available. May have multiple glyph advances (most CJK glyphs may contain two spaces)
    public func traitMonoSpace() -> UIFont { remake(symbolicTraits: .traitMonoSpace) }
    // Use vertical glyph variants and metrics

    public func traitVertical() -> UIFont { remake(symbolicTraits: .traitVertical) }
    // Synthesize appropriate attributes for UI rendering such as control titles if necessary
    public func traitUIOptimized() -> UIFont { remake(symbolicTraits: .traitUIOptimized) }
    // Use tighter leading values
    public func traitTightLeading() -> UIFont { remake(symbolicTraits: .traitTightLeading) }
    // Use looser leading values
    public func traitLooseLeading() -> UIFont { remake(symbolicTraits: .traitLooseLeading) }

    public func classMask() -> UIFont { remake(symbolicTraits: .classMask) }
    public func classOldStyleSerifs() -> UIFont { remake(symbolicTraits: .classOldStyleSerifs) }
    public func classTransitionalSerifs() -> UIFont { remake(symbolicTraits: .classTransitionalSerifs) }
    public func classModernSerifs() -> UIFont { remake(symbolicTraits: .classModernSerifs) }
    public func classClarendonSerifs() -> UIFont { remake(symbolicTraits: .classClarendonSerifs) }
    public func classSlabSerifs() -> UIFont { remake(symbolicTraits: .classSlabSerifs) }
    public func classFreeformSerifs() -> UIFont { remake(symbolicTraits: .classFreeformSerifs) }
    public func classSansSerif() -> UIFont { remake(symbolicTraits: .classSansSerif) }
    public func classOrnamentals() -> UIFont { remake(symbolicTraits: .classOrnamentals) }
    public func classScripts() -> UIFont { remake(symbolicTraits: .classScripts) }
    public func classSymbolic() -> UIFont { remake(symbolicTraits: .classSymbolic) }
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

    public static let headline: UIFont = .preferredFont(forTextStyle: UIFont.TextStyle.headline)
    public static let subheadline: UIFont = .preferredFont(forTextStyle: UIFont.TextStyle.subheadline)
    public static let body: UIFont = .preferredFont(forTextStyle: UIFont.TextStyle.body)
    public static let caption2: UIFont = .preferredFont(forTextStyle: UIFont.TextStyle.caption2)
    public static let caption1: UIFont = .preferredFont(forTextStyle: UIFont.TextStyle.caption1)
    public static let footnote: UIFont = .preferredFont(forTextStyle: UIFont.TextStyle.footnote)

    @available(iOS 9.0, *)
    public static let callout: UIFont = .preferredFont(forTextStyle: .callout)

    @available(iOS 9.0, *)
    public static let title3: UIFont = .preferredFont(forTextStyle: .title3)

    @available(iOS 9.0, *)
    public static let title2: UIFont = .preferredFont(forTextStyle: .title2)

    @available(iOS 9.0, *)
    public static let title1: UIFont = .preferredFont(forTextStyle: .title1)
}
