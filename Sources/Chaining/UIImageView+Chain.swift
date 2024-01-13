import UIKit

public extension UIImageView {
  @discardableResult
  func image(_ value: UIImage?) -> Self {
    image = value
    return self
  }

  @discardableResult
  func highlightedImage(_ value: UIImage?) -> Self {
    highlightedImage = value
    return self
  }

  @discardableResult
  func animationImages(_ elements: [UIImage]?) -> Self {
    animationImages = elements
    return self
  }

  @discardableResult
  func highlightedAnimationImages(_ elements: [UIImage]?) -> Self {
    highlightedAnimationImages = elements
    return self
  }

  @discardableResult
  func animationDuration(_ duration: TimeInterval) -> Self {
    animationDuration = duration
    return self
  }

  @discardableResult
  func animationRepeatCount(_ count: Int) -> Self {
    animationRepeatCount = count
    return self
  }

  @discardableResult
  func highlighted(_ highlighted: Bool) -> Self {
    isHighlighted = highlighted
    return self
  }

  @discardableResult
  func tintColor(_ color: UIColor) -> Self {
    tintColor = color
    return self
  }
}
