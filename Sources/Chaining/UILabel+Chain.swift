import UIKit

public extension UILabel {
  @discardableResult
  func text(_ value: String?) -> Self {
    text = value
    return self
  }

  @discardableResult
  func attributedText(_ text: NSAttributedString?) -> Self {
    attributedText = text
    return self
  }

  @discardableResult
  func font(_ value: UIFont) -> Self {
    font = value
    return self
  }

  @discardableResult
  func textColor(_ color: UIColor) -> Self {
    textColor = color
    return self
  }

  @discardableResult
  func textAlignment(_ alignment: NSTextAlignment) -> Self {
    textAlignment = alignment
    return self
  }

  @discardableResult
  func lineBreakMode(_ mode: NSLineBreakMode) -> Self {
    lineBreakMode = mode
    return self
  }

  @discardableResult
  func enabled(_ enabled: Bool) -> Self {
    isEnabled = enabled
    return self
  }

  @discardableResult
  func adjustsFontSizeToFitWidth(_ adjusts: Bool) -> Self {
    adjustsFontSizeToFitWidth = adjusts
    return self
  }

  @discardableResult
  func allowsDefaultTighteningForTruncation(_ allows: Bool) -> Self {
    allowsDefaultTighteningForTruncation = allows
    return self
  }

  @discardableResult
  func baselineAdjustment(_ adjustment: UIBaselineAdjustment) -> Self {
    baselineAdjustment = adjustment
    return self
  }

  @discardableResult
  func minimumScaleFactor(_ factor: CGFloat) -> Self {
    minimumScaleFactor = factor
    return self
  }

  @discardableResult
  func numberOfLines(_ lines: Int) -> Self {
    numberOfLines = lines
    return self
  }

  @discardableResult
  func highlightedTextColor(_ color: UIColor?) -> Self {
    highlightedTextColor = color
    return self
  }

  @discardableResult
  func highlighted(_ highlighted: Bool) -> Self {
    isHighlighted = highlighted
    return self
  }

  @discardableResult
  override func shadowColor(_ color: UIColor?) -> Self {
    shadowColor = color
    return self
  }

  @discardableResult
  override func shadowOffset(_ offset: CGSize) -> Self {
    shadowOffset = offset
    return self
  }

  @discardableResult
  func preferredMaxLayoutWidth(_ width: CGFloat) -> Self {
    preferredMaxLayoutWidth = width
    return self
  }
}

public extension UILabel {
  @discardableResult
  func textColor(_ hex: String, alpha: CGFloat = 1) -> Self {
    textColor(.init(hex: hex, alpha: alpha))
  }

  @discardableResult
  func textColor(_ hex: UInt64, alpha: CGFloat = 1) -> Self {
    textColor(.init(hex: hex, alpha: alpha))
  }
}
