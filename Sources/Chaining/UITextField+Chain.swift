import UIKit

public extension UITextField {
  @discardableResult
  func delegate(_ value: UITextFieldDelegate?) -> Self {
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
  func placeholder(_ value: String?) -> Self {
    placeholder = value
    return self
  }

  @discardableResult
  func attributedPlaceholder(_ text: NSAttributedString?) -> Self {
    attributedPlaceholder = text
    return self
  }

  @discardableResult
  func defaultTextAttributes(_ attributes: [NSAttributedString.Key: Any]) -> Self {
    defaultTextAttributes = attributes
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
  func typingAttributes(_ attributes: [NSAttributedString.Key: Any]?) -> Self {
    typingAttributes = attributes
    return self
  }

  @discardableResult
  func adjustsFontSizeToFitWidth(_ adjusts: Bool) -> Self {
    adjustsFontSizeToFitWidth = adjusts
    return self
  }

  @discardableResult
  func minimumFontSize(_ size: CGFloat) -> Self {
    minimumFontSize = size
    return self
  }

  @discardableResult
  func clearsOnBeginEditing(_ clears: Bool) -> Self {
    clearsOnBeginEditing = clears
    return self
  }

  @discardableResult
  func clearsOnInsertion(_ clears: Bool) -> Self {
    clearsOnInsertion = clears
    return self
  }

  @discardableResult
  func allowsEditingTextAttributes(_ allows: Bool) -> Self {
    allowsEditingTextAttributes = allows
    return self
  }

  @discardableResult
  func borderStyle(_ style: BorderStyle) -> Self {
    borderStyle = style
    return self
  }

  @discardableResult
  func background(_ image: UIImage?) -> Self {
    background = image
    return self
  }

  @discardableResult
  func disabledBackground(_ image: UIImage?) -> Self {
    disabledBackground = image
    return self
  }

  @discardableResult
  func clearButtonMode(_ mode: ViewMode) -> Self {
    clearButtonMode = mode
    return self
  }

  @discardableResult
  func leftView(_ view: UIView?) -> Self {
    leftView = view
    return self
  }

  @discardableResult
  func leftViewMode(_ mode: ViewMode) -> Self {
    leftViewMode = mode
    return self
  }

  @discardableResult
  func rightView(_ view: UIView?) -> Self {
    rightView = view
    return self
  }

  @discardableResult
  func rightViewMode(_ mode: ViewMode) -> Self {
    rightViewMode = mode
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
}
