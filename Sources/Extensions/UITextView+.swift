#if !(os(iOS) && (arch(i386) || arch(arm)))
import Combine
import UIKit

public extension UITextView {
  @available(iOS 13.0, *)
  func limitCharacter(count: Int, handler: @escaping (Int) -> Void) -> AnyCancellable {
    NotificationCenter.default.publisher(for: UITextView.textDidChangeNotification).sink { notification in
      guard
        let textView = notification.object as? UITextView,
        let text = textView.text
      else {
        return
      }

      let currentCount = text.count
      if currentCount > count, textView.markedTextRange == nil {
        let lower = text.index(text.startIndex, offsetBy: 0)
        let upper = text.index(text.startIndex, offsetBy: count)
        textView.text = String(text[lower ..< upper])
      }
      handler(count - currentCount)

      let cursorLocation = textView.selectedRange.location
      let range = NSRange(location: 0, length: cursorLocation)
      textView.scrollRangeToVisible(range)
    }
  }
}
#endif
