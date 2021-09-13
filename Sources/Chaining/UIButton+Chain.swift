import UIKit

extension UIButton {
  @discardableResult
  public func title(
    _ value: String?,
    for state: UIControl.State = .normal
  ) -> Self {
    setTitle(value, for: state)
    return self
  }

  @discardableResult
  public func attributedTitle(
    _ text: NSAttributedString?,
    for state: UIControl.State = .normal
  ) -> Self {
    setAttributedTitle(text, for: state)
    return self
  }

  @discardableResult
  public func titleColor(
    _ color: UIColor,
    for state: UIControl.State = .normal
  ) -> Self {
    setTitleColor(color, for: state)
    return self
  }

  @discardableResult
  public func titleShadowColor(
    _ color: UIColor?,
    for state: UIControl.State = .normal
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
    for state: UIControl.State = .normal
  ) -> Self {
    setBackgroundImage(image, for: state)
    return self
  }

  @discardableResult
  public func image(
    _ image: UIImage?,
    for state: UIControl.State = .normal
  ) -> Self {
    setImage(image, for: state)
    return self
  }

  @available(iOS 13.0, *)
  @discardableResult
  public func preferredSymbolConfiguration(
    _ configuration: UIImage.SymbolConfiguration?,
    for state: UIControl.State = .normal
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
