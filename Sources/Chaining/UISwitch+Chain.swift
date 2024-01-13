import UIKit

public extension UISwitch {
  @discardableResult
  func on(_ on: Bool, animated: Bool) -> Self {
    setOn(on, animated: animated)
    return self
  }

  @available(iOS 14.0, *)
  @discardableResult
  func preferredStyle(_ style: Style) -> Self {
    preferredStyle = style
    return self
  }

  @available(iOS 14.0, *)
  @discardableResult
  func style(_ value: Style) -> Self {
    preferredStyle = value
    return self
  }

  @available(iOS 14.0, *)
  @discardableResult
  func title(_ value: String?) -> Self {
    title = value
    return self
  }

  @discardableResult
  func onTintColor(_ color: UIColor?) -> Self {
    onTintColor = color
    return self
  }

  @discardableResult
  func thumbTintColor(_ color: UIColor?) -> Self {
    thumbTintColor = color
    return self
  }

  @discardableResult
  func onImage(_ image: UIImage?) -> Self {
    onImage = image
    return self
  }

  @discardableResult
  func offImage(_ image: UIImage?) -> Self {
    offImage = image
    return self
  }
}
