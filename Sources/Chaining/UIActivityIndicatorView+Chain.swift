import UIKit

public extension UIActivityIndicatorView {
  @discardableResult
  func hidesWhenStopped(_ hides: Bool) -> Self {
    hidesWhenStopped = hides
    return self
  }

  @discardableResult
  func style(_ value: UIActivityIndicatorView.Style) -> Self {
    style = value
    return self
  }

  @discardableResult
  func color(_ value: UIColor) -> Self {
    color = value
    return self
  }
}
