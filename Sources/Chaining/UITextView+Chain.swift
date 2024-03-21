import UIKit

public extension UITextView {
  @discardableResult
  func delegate(_ value: UITextViewDelegate?) -> Self {
    delegate = value
    return self
  }

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
  func dataDetectorTypes(_ types: UIDataDetectorTypes) -> Self {
    dataDetectorTypes = types
    return self
  }

  @discardableResult
  func textAlignment(_ alignment: NSTextAlignment) -> Self {
    textAlignment = alignment
    return self
  }

  @discardableResult
  func typingAttributes(_ attributes: [NSAttributedString.Key: Any]) -> Self {
    typingAttributes = attributes
    return self
  }

  @discardableResult
  func linkTextAttributes(_ attributes: [NSAttributedString.Key: Any]) -> Self {
    linkTextAttributes = attributes
    return self
  }

  @discardableResult
  func textContainerInset(_ insets: UIEdgeInsets) -> Self {
    textContainerInset = insets
    return self
  }

  @available(iOS 13.0, *)
  @discardableResult
  func usesStandardTextScaling(_ uses: Bool) -> Self {
    usesStandardTextScaling = uses
    return self
  }

  @discardableResult
  func editable(_ editable: Bool) -> Self {
    isEditable = editable
    return self
  }

  @discardableResult
  func allowsEditingTextAttributes(_ allows: Bool) -> Self {
    allowsEditingTextAttributes = allows
    return self
  }

  @discardableResult
  func selectedRange(_ range: NSRange) -> Self {
    selectedRange = range
    return self
  }

  @discardableResult
  func clearsOnInsertion(_ clears: Bool) -> Self {
    clearsOnInsertion = clears
    return self
  }

  @discardableResult
  func selectable(_ selectable: Bool) -> Self {
    isSelectable = selectable
    return self
  }

  @discardableResult
  func inputView(_ view: UIView?) -> Self {
    inputView = view
    return self
  }

  @discardableResult
  func inputAccessoryView(_ view: UIView?) -> Self {
    inputAccessoryView = view
    return self
  }

  @discardableResult
  func keyboardType(_ value: UIKeyboardType) -> Self {
    keyboardType = value
    return self
  }

  @discardableResult
  func keyboardAppearance(_ value: UIKeyboardAppearance) -> Self {
    keyboardAppearance = value
    return self
  }

  @discardableResult
  func returnKeyType(_ value: UIReturnKeyType) -> Self {
    returnKeyType = value
    return self
  }

  @discardableResult
  func enablesReturnKeyAutomatically(_ value: Bool) -> Self {
    enablesReturnKeyAutomatically = value
    return self
  }

  @discardableResult
  func secureTextEntry(_ value: Bool) -> Self {
    isSecureTextEntry = value
    return self
  }
}
