import UIKit

extension UIResponder {
  public func responder<T: UIResponder>(of any: T.Type) -> T? {
    var responder: UIResponder = self
    while let next = responder.next {
      if let result = next as? T {
        return result
      }
      responder = next
    }
    return nil
  }
}
