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
}

// MARK: - UITextInputTraits

public extension UITextView {
  @discardableResult
  func autocapitalizationType(_ value: UITextAutocapitalizationType) -> Self {
    autocapitalizationType = value
    return self
  }

  @discardableResult
  func autocorrectionType(_ value: UITextAutocorrectionType) -> Self {
    autocorrectionType = value
    return self
  }

  @available(iOS 5.0, *)
  @discardableResult
  func spellCheckingType(_ value: UITextSpellCheckingType) -> Self {
    spellCheckingType = value
    return self
  }

  @available(iOS 11.0, *)
  @discardableResult
  func smartQuotesType(_ value: UITextSmartQuotesType) -> Self {
    smartQuotesType = value
    return self
  }

  @available(iOS 11.0, *)
  @discardableResult
  func smartDashesType(_ value: UITextSmartDashesType) -> Self {
    smartDashesType = value
    return self
  }

  @available(iOS 11.0, *)
  @discardableResult
  func smartInsertDeleteType(_ value: UITextSmartInsertDeleteType) -> Self {
    smartInsertDeleteType = value
    return self
  }

  @available(iOS 17.0, *)
  @discardableResult
  func inlinePredictionType(_ value: UITextInlinePredictionType) -> Self {
    inlinePredictionType = value
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

  @available(iOS 10.0, *)
  @discardableResult
  func textContentType(_ value: UITextContentType?) -> Self {
    textContentType = value
    return self
  }

  @available(iOS 10.0, *)
  @discardableResult
  func passwordRules(_ value: UITextInputPasswordRules?) -> Self {
    passwordRules = value
    return self
  }
}

// MARK: - Hex Color

public extension UITextView {
  func textColor(_ hex: String, alpha: CGFloat = 1) -> Self {
    textColor(.init(hex: hex, alpha: alpha))
  }

  func textColor(_ hex: UInt64, alpha: CGFloat = 1) -> Self {
    textColor(.init(hex: hex, alpha: alpha))
  }
}
