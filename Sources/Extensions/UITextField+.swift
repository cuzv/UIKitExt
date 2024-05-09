#if !(os(iOS) && (arch(i386) || arch(arm)))
import Combine
import UIKit

public extension UITextField {
  @available(iOS 13.0, *)
  func limitCharacter(count: Int, handler: @escaping (Int) -> Void) -> AnyCancellable {
    NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification).sink { notification in
      guard
        let textField = notification.object as? UITextField,
        let text = textField.text
      else {
        return
      }

      let currentCount = text.count
      if currentCount > count, textField.markedTextRange == nil {
        let lower = text.index(text.startIndex, offsetBy: 0)
        let upper = text.index(text.startIndex, offsetBy: count)
        textField.text = String(text[lower ..< upper])
      }
      handler(count - currentCount)
    }
  }
}

extension UITextField {
  public func fixRightViewAppearsWhileEditing() {
    addTarget(self, action: #selector(handleEditingChanged(_:)), for: .editingChanged)
  }

  @objc private func handleEditingChanged(_ sender: UITextField) {
    sender.rightViewMode = sender.text?.isEmpty == true ? .never : .always
  }

  public func fixWhitespacesIssue() {
    addTarget(
      self,
      action: #selector(replaceNormalSpacesWithNonBreakingSpaces(textField:)),
      for: .editingChanged
    )
    addTarget(
      self,
      action: #selector(replaceNonBreakingSpacesWithNormalSpaces(textField:)),
      for: .editingDidEnd
    )
  }

  @objc private func replaceNormalSpacesWithNonBreakingSpaces(textField: UITextField) {
    let cursor = selectedTextRange
    text = text?.replacingOccurrences(of: " ", with: "\u{00a0}")
    selectedTextRange = cursor
  }

  @objc private func replaceNonBreakingSpacesWithNormalSpaces(textField: UITextField) {
    let cursor = selectedTextRange
    text = textField.text?.replacingOccurrences(of: "\u{00a0}", with: " ")
    selectedTextRange = cursor
  }
}
#endif
