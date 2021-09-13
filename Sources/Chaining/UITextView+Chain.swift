import UIKit

extension UITextView {
  @discardableResult
  public func delegate(_ value: UITextViewDelegate?) -> Self {
    delegate = value
    return self
  }

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
  public func dataDetectorTypes(_ types: UIDataDetectorTypes) -> Self {
    dataDetectorTypes = types
    return self
  }

  @discardableResult
  public func textAlignment(_ alignment: NSTextAlignment) -> Self {
    textAlignment = alignment
    return self
  }

  @discardableResult
  public func typingAttributes(_ attributes: [NSAttributedString.Key: Any]) -> Self {
    typingAttributes = attributes
    return self
  }

  @discardableResult
  public func linkTextAttributes(_ attributes: [NSAttributedString.Key: Any]) -> Self {
    linkTextAttributes = attributes
    return self
  }

  @discardableResult
  public func textContainerInset(_ insets: UIEdgeInsets) -> Self {
    textContainerInset = insets
    return self
  }

  @available(iOS 13.0, *)
  @discardableResult
  public func usesStandardTextScaling(_ uses: Bool) -> Self {
    usesStandardTextScaling = uses
    return self
  }

  @discardableResult
  public func editable(_ editable: Bool) -> Self {
    isEditable = editable
    return self
  }

  @discardableResult
  public func allowsEditingTextAttributes(_ allows: Bool) -> Self {
    allowsEditingTextAttributes = allows
    return self
  }

  @discardableResult
  public func selectedRange(_ range: NSRange) -> Self {
    selectedRange = range
    return self
  }

  @discardableResult
  public func clearsOnInsertion(_ clears: Bool) -> Self {
    clearsOnInsertion = clears
    return self
  }

  @discardableResult
  public func selectable(_ selectable: Bool) -> Self {
    isSelectable = selectable
    return self
  }

  @discardableResult
  public func inputView(_ view: UIView?) -> Self {
    inputView = view
    return self
  }

  @discardableResult
  public func inputAccessoryView(_ view: UIView?) -> Self {
    inputAccessoryView = view
    return self
  }
}
