import UIKit

extension UIImageView {
  @discardableResult
  public func image(_ value: UIImage?) -> Self {
    image = value
    return self
  }

  @discardableResult
  public func highlightedImage(_ value: UIImage?) -> Self {
    highlightedImage = value
    return self
  }

  @discardableResult
  public func animationImages(_ elements: [UIImage]?) -> Self {
    animationImages = elements
    return self
  }

  @discardableResult
  public func highlightedAnimationImages(_ elements: [UIImage]?) -> Self {
    highlightedAnimationImages = elements
    return self
  }

  @discardableResult
  public func animationDuration(_ duration: TimeInterval) -> Self {
    animationDuration = duration
    return self
  }

  @discardableResult
  public func animationRepeatCount(_ count: Int) -> Self {
    animationRepeatCount = count
    return self
  }

  @discardableResult
  public func highlighted(_ highlighted: Bool) -> Self {
    isHighlighted = highlighted
    return self
  }

  @discardableResult
  public func tintColor(_ color: UIColor) -> Self {
    tintColor = color
    return self
  }
}
