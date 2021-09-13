import UIKit

extension UIActivityIndicatorView {
  @discardableResult
  public func hidesWhenStopped(_ hides: Bool) -> Self {
    hidesWhenStopped = hides
    return self
  }

  @discardableResult
  public func style(_ value: UIActivityIndicatorView.Style) -> Self {
    style = value
    return self
  }

  @discardableResult
  public func color(_ value: UIColor ) -> Self {
    color = value
    return self
  }
}
