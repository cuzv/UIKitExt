import UIKit

public extension UIProgressView {
  @discardableResult
  func progress(_ value: Float, animated: Bool = false) -> Self {
    setProgress(value, animated: animated)
    return self
  }

  @discardableResult
  func observedProgress(_ progress: Progress?) -> Self {
    observedProgress = progress
    return self
  }

  @discardableResult
  func progressStyle(_ style: Style) -> Self {
    progressViewStyle = style
    return self
  }

  @discardableResult
  func progressTintColor(_ color: UIColor?) -> Self {
    progressTintColor = color
    return self
  }

  @discardableResult
  func progressImage(_ image: UIImage?) -> Self {
    progressImage = image
    return self
  }

  @discardableResult
  func trackTintColor(_ color: UIColor?) -> Self {
    trackTintColor = color
    return self
  }

  @discardableResult
  func trackImage(_ image: UIImage?) -> Self {
    trackImage = image
    return self
  }
}
