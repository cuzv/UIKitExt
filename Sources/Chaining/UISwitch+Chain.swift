import UIKit

extension UISwitch {
  @discardableResult
  public func on(_ on: Bool, animated: Bool) -> Self {
    setOn(on, animated: animated)
    return self
  }

  @available(iOS 14.0, *)
  @discardableResult
  public func preferredStyle(_ style: Style) -> Self {
    preferredStyle = style
    return self
  }

  @available(iOS 14.0, *)
  @discardableResult
  public func style(_ value: Style) -> Self {
    preferredStyle = value
    return self
  }

  @available(iOS 14.0, *)
  @discardableResult
  public func title(_ value: String?) -> Self {
    title = value
    return self
  }

  @discardableResult
  public func onTintColor(_ color: UIColor?) -> Self {
    onTintColor = color
    return self
  }

  @discardableResult
  public func thumbTintColor(_ color: UIColor?) -> Self {
    thumbTintColor = color
    return self
  }

  @discardableResult
  public func onImage(_ image: UIImage?) -> Self {
    onImage = image
    return self
  }

  @discardableResult
  public func offImage(_ image: UIImage?) -> Self {
    offImage = image
    return self
  }
}
