import UIKit

extension UIProgressView {
  @discardableResult
  public func progress(_ value: Float, animated: Bool = false) -> Self {
    setProgress(value, animated: animated)
    return self
  }

  @discardableResult
  public func observedProgress(_ progress: Progress?) -> Self {
    observedProgress = progress
    return self
  }

  @discardableResult
  public func progressStyle(_ style: Style) -> Self {
    progressViewStyle = style
    return self
  }

  @discardableResult
  public func progressTintColor(_ color: UIColor?) -> Self {
    progressTintColor = color
    return self
  }

  @discardableResult
  public func progressImage(_ image: UIImage?) -> Self {
    progressImage = image
    return self
  }

  @discardableResult
  public func trackTintColor(_ color: UIColor?) -> Self {
    trackTintColor = color
    return self
  }

  @discardableResult
  public func trackImage(_ image: UIImage?) -> Self {
    trackImage = image
    return self
  }
}
