import UIKit

extension UILabel {
  @discardableResult
  public func text(_ value: String?) -> Self {
    text = value
    return self
  }

  @discardableResult
  public func attributedText(_ text: NSAttributedString?) -> Self {
    attributedText = text
    return self
  }

  @discardableResult
  public func font(_ value: UIFont) -> Self {
    font = value
    return self
  }

  @discardableResult
  public func textColor(_ color: UIColor) -> Self {
    textColor = color
    return self
  }

  @discardableResult
  public func textAlignment(_ alignment: NSTextAlignment) -> Self {
    textAlignment = alignment
    return self
  }

  @discardableResult
  public func lineBreakMode(_ mode: NSLineBreakMode) -> Self {
    lineBreakMode = mode
    return self
  }

  @discardableResult
  public func enabled(_ enabled: Bool) -> Self {
    isEnabled = enabled
    return self
  }

  @discardableResult
  public func adjustsFontSizeToFitWidth(_ adjusts: Bool) -> Self {
    adjustsFontSizeToFitWidth = adjusts
    return self
  }

  @discardableResult
  public func allowsDefaultTighteningForTruncation(_ allows: Bool) -> Self {
    allowsDefaultTighteningForTruncation = allows
    return self
  }

  @discardableResult
  public func baselineAdjustment(_ adjustment: UIBaselineAdjustment) -> Self {
    baselineAdjustment = adjustment
    return self
  }

  @discardableResult
  public func minimumScaleFactor(_ factor: CGFloat) -> Self {
    minimumScaleFactor = factor
    return self
  }

  @discardableResult
  public func numberOfLines(_ lines: Int) -> Self {
    numberOfLines = lines
    return self
  }

  @discardableResult
  public func highlightedTextColor(_ color: UIColor?) -> Self {
    highlightedTextColor = color
    return self
  }

  @discardableResult
  public func highlighted(_ highlighted: Bool) -> Self {
    isHighlighted = highlighted
    return self
  }

  @discardableResult
  public override func shadowColor(_ color: UIColor?) -> Self {
    shadowColor = color
    return self
  }

  @discardableResult
  public override func shadowOffset(_ offset: CGSize) -> Self {
    shadowOffset = offset
    return self
  }

  @discardableResult
  public func preferredMaxLayoutWidth(_ width: CGFloat) -> Self {
    preferredMaxLayoutWidth = width
    return self
  }
}
