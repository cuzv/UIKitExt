import UIKit

extension UIButton {
  @discardableResult
  public func title(
    _ value: String?,
    for state: UIControl.State
  ) -> Self {
    setTitle(value, for: state)
    return self
  }

  @discardableResult
  public func attributedTitle(
    _ text: NSAttributedString?,
    for state: UIControl.State
  ) -> Self {
    setAttributedTitle(text, for: state)
    return self
  }

  @discardableResult
  public func titleColor(
    _ color: UIColor,
    for state: UIControl.State
  ) -> Self {
    setTitleColor(color, for: state)
    return self
  }

  @discardableResult
  public func titleShadowColor(
    _ color: UIColor?,
    for state: UIControl.State
  ) -> Self {
    setTitleShadowColor(color, for: state)
    return self
  }

  @discardableResult
  public func titleFont(_ font: UIFont) -> Self {
    titleLabel?.font = font
    return self
  }

  @discardableResult
  public func titleAlignment(_ alignment: NSTextAlignment) -> Self {
    titleLabel?.textAlignment = alignment
    return self
  }

  @discardableResult
  public func titleLineBreakMode(_ mode: NSLineBreakMode) -> Self {
    titleLabel?.lineBreakMode = mode
    return self
  }

  @discardableResult
  public func adjustsImageWhenHighlighted(_ adjusts: Bool) -> Self {
    adjustsImageWhenHighlighted = adjusts
    return self
  }

  @discardableResult
  public func adjustsImageWhenDisabled(_ adjusts: Bool) -> Self {
    adjustsImageWhenDisabled = adjusts
    return self
  }

  @discardableResult
  public func showsTouchWhenHighlighted(_ shows: Bool) -> Self {
    showsTouchWhenHighlighted = shows
    return self
  }

  @discardableResult
  public func backgroundImage(
    _ image: UIImage?,
    for state: UIControl.State
  ) -> Self {
    setBackgroundImage(image, for: state)
    return self
  }

  @discardableResult
  public func image(
    _ image: UIImage?,
    for state: UIControl.State
  ) -> Self {
    setImage(image, for: state)
    return self
  }

  @available(iOS 13.0, *)
  @discardableResult
  public func preferredSymbolConfiguration(
    _ configuration: UIImage.SymbolConfiguration?,
    for state: UIControl.State
  ) -> Self {
    setPreferredSymbolConfiguration(configuration, forImageIn: state)
    return self
  }

  @discardableResult
  public func tintColor(_ color: UIColor) -> Self {
    tintColor = color
    return self
  }

  @discardableResult
  public func contentEdgeInsets(_ insets: UIEdgeInsets) -> Self {
    contentEdgeInsets = insets
    return self
  }

  @discardableResult
  public func titleEdgeInsets(_ insets: UIEdgeInsets) -> Self {
    titleEdgeInsets = insets
    return self
  }

  @discardableResult
  public func imageEdgeInsets(_ insets: UIEdgeInsets) -> Self {
    imageEdgeInsets = insets
    return self
  }

  @available(iOS 13.4, *)
  @discardableResult
  public func pointerInteractionEnabled(_ enabled: Bool) -> Self {
    isPointerInteractionEnabled = enabled
    return self
  }

  @available(iOS 13.4, *)
  @discardableResult
  public func pointerStyleProvider(_ provider: PointerStyleProvider?) -> Self {
    pointerStyleProvider = provider
    return self
  }
}

extension UIButton {
  @discardableResult
  public func titles(
    _ pairs: (UIControl.State, String?)...
  ) -> Self {
    pairs.forEach { setTitle($1, for: $0) }
    return self
  }

  @discardableResult
  public func attributedTitles(
    _ pairs: (UIControl.State, NSAttributedString?)...
  ) -> Self {
    pairs.forEach { setAttributedTitle($1, for: $0) }
    return self
  }

  @discardableResult
  public func titleColors(
    _ pairs: (UIControl.State, UIColor)...
  ) -> Self {
    pairs.forEach { setTitleColor($1, for: $0) }
    return self
  }

  @discardableResult
  public func titleShadowColors(
    _ pairs: (UIControl.State, UIColor)...
  ) -> Self {
    pairs.forEach { setTitleShadowColor($1, for: $0) }
    return self
  }

  @discardableResult
  public func backgroundImages(
    _ pairs: (UIControl.State, UIImage?)...
  ) -> Self {
    pairs.forEach { setBackgroundImage($1, for: $0) }
    return self
  }

  @discardableResult
  public func images(
    _ pairs: (UIControl.State, UIImage?)...
  ) -> Self {
    pairs.forEach { setImage($1, for: $0) }
    return self
  }

  @available(iOS 13.0, *)
  @discardableResult
  public func preferredSymbolConfigurations(
    _ pairs: (UIControl.State, UIImage.SymbolConfiguration?)...
  ) -> Self {
    pairs.forEach { setPreferredSymbolConfiguration($1, forImageIn: $0) }
    return self
  }
}

@available(iOS 13.0, *)
public extension UIButton {
  private var stateAlphaMappings: Zip2Sequence<[UIControl.State], [CGFloat]> {
    zip([
      .normal,
      .highlighted,
      .disabled,
    ], [
      1,
      0.5,
      0.3,
    ])
  }

  @discardableResult
  func attributedTitle(_ text: NSAttributedString?) -> Self {
    if let text {
      stateAlphaMappings.forEach { state, alpha in
        let mutableText = NSMutableAttributedString(attributedString: text)
        mutableText.enumerateAttribute(.foregroundColor, in: NSRange(0..<mutableText.length)) { value, range, stop in
          if let color = value as? UIColor {
            let (light, dark) = color.resolvedTraitColors
            let color = light.withAlphaComponent(alpha) | dark.withAlphaComponent(alpha)
            mutableText.addAttribute(.foregroundColor, value: color, range: range)
          }
        }
        setAttributedTitle(mutableText, for: state)
      }
    } else {
      stateAlphaMappings.map(\.0).forEach { state in
        setAttributedTitle(nil, for: state)
      }
    }
    return self
  }

  @discardableResult
  func titleColor(_ color: UIColor?) -> Self {
    if let color {
      let (light, dark) = color.resolvedTraitColors
      stateAlphaMappings.forEach { state, alpha in
        let color = light.withAlphaComponent(alpha) | dark.withAlphaComponent(alpha)
        setTitleColor(color, for: state)
      }
    } else {
      stateAlphaMappings.map(\.0).forEach { state in
        setTitleColor(nil, for: state)
      }
    }
    return self
  }

  @discardableResult
  func titleShadowColor(_ color: UIColor?) -> Self {
    if let color {
      let (light, dark) = color.resolvedTraitColors
      stateAlphaMappings.forEach { state, alpha in
        let color = light.withAlphaComponent(alpha) | dark.withAlphaComponent(alpha)
        setTitleShadowColor(color, for: state)
      }
    } else {
      stateAlphaMappings.map(\.0).forEach { state in
        setTitleShadowColor(nil, for: state)
      }
    }
    return self
  }

  @discardableResult
  func backgroundImage(_ image: UIImage?) -> Self {
    if let image {
      if let (light, dark) = image.resolvedTraitImages {
        stateAlphaMappings.forEach { state, alpha in
          let resolvedImage = light.withAlpha(alpha) |  dark.withAlpha(alpha)
          setBackgroundImage(resolvedImage, for: state)
        }
      } else {
        stateAlphaMappings.forEach { state, alpha in
          setBackgroundImage(image.withAlpha(alpha), for: state)
        }
      }
    } else {
      stateAlphaMappings.map(\.0).forEach { state in
        setBackgroundImage(nil, for: state)
      }
    }
    return self
  }

  @discardableResult
  func backgroundImage(
    color: UIColor,
    size: CGSize = .init(width: 1, height: 1),
    cornerRadius: CGFloat = 0
  ) -> Self {
    stateAlphaMappings.forEach { state, alpha in
      backgroundImage(
        color: color.withAlphaComponent(alpha),
        size: size,
        cornerRadius: cornerRadius,
        for: state
      )
    }
    return self
  }

  @discardableResult
  func backgroundImage(
    color: UIColor,
    size: CGSize = .init(width: 1, height: 1),
    cornerRadius: CGFloat = 0,
    for state: UIControl.State
  ) -> Self {
    let (light, dark) = color.resolvedTraitColors
    let image = UIImage.create(
      light: light,
      dark: dark,
      size: size,
      cornerRadius: cornerRadius
    )
    return backgroundImage(image, for: state)
  }

  @discardableResult
  func image(_ image: UIImage?) -> Self {
    if let image {
      if let (light, dark) = image.resolvedTraitImages {
        stateAlphaMappings.forEach { state, alpha in
          let resolvedImage = light.withAlpha(alpha) |  dark.withAlpha(alpha)
          setImage(resolvedImage, for: state)
        }
      } else {
        stateAlphaMappings.forEach { state, alpha in
          setImage(image.withAlpha(alpha), for: state)
        }
      }
    } else {
      stateAlphaMappings.map(\.0).forEach { state in
        setImage(nil, for: state)
      }
    }
    return self
  }
}
