import UIKit

extension UITextField {
  @discardableResult
  public func delegate(_ value: UITextFieldDelegate?) -> Self {
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
  public func placeholder(_ value: String?) -> Self {
    placeholder = value
    return self
  }

  @discardableResult
  public func attributedPlaceholder(_ text: NSAttributedString?) -> Self {
    attributedPlaceholder = text
    return self
  }

  @discardableResult
  public func defaultTextAttributes(_ attributes: [NSAttributedString.Key: Any]) -> Self {
    defaultTextAttributes = attributes
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
  public func typingAttributes(_ attributes: [NSAttributedString.Key: Any]?) -> Self {
    typingAttributes = attributes
    return self
  }

  @discardableResult
  public func adjustsFontSizeToFitWidth(_ adjusts: Bool) -> Self {
    adjustsFontSizeToFitWidth = adjusts
    return self
  }

  @discardableResult
  public func minimumFontSize(_ size: CGFloat) -> Self {
    minimumFontSize = size
    return self
  }

  @discardableResult
  public func clearsOnBeginEditing(_ clears: Bool) -> Self {
    clearsOnBeginEditing = clears
    return self
  }

  @discardableResult
  public func clearsOnInsertion(_ clears: Bool) -> Self {
    clearsOnInsertion = clears
    return self
  }

  @discardableResult
  public func allowsEditingTextAttributes(_ allows: Bool) -> Self {
    allowsEditingTextAttributes = allows
    return self
  }

  @discardableResult
  public func borderStyle(_ style: BorderStyle) -> Self {
    borderStyle = style
    return self
  }

  @discardableResult
  public func background(_ image: UIImage?) -> Self {
    background = image
    return self
  }

  @discardableResult
  public func disabledBackground(_ image: UIImage?) -> Self {
    disabledBackground = image
    return self
  }

  @discardableResult
  public func clearButtonMode(_ mode: ViewMode) -> Self {
    clearButtonMode = mode
    return self
  }

  @discardableResult
  public func leftView(_ view: UIView?) -> Self {
    leftView = view
    return self
  }

  @discardableResult
  public func leftViewMode(_ mode: ViewMode) -> Self {
    leftViewMode = mode
    return self
  }

  @discardableResult
  public func rightView(_ view: UIView?) -> Self {
    rightView = view
    return self
  }

  @discardableResult
  public func rightViewMode(_ mode: ViewMode) -> Self {
    rightViewMode = mode
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
