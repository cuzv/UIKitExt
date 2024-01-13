import UIKit

public extension UIControl {
  @discardableResult
  func enabled(_ enabled: Bool) -> Self {
    isEnabled = enabled
    return self
  }

  @discardableResult
  func selected(_ selected: Bool) -> Self {
    isSelected = selected
    return self
  }

  @discardableResult
  func highlighted(_ highlighted: Bool) -> Self {
    isHighlighted = highlighted
    return self
  }

  @discardableResult
  func contentVerticalAlignment(
    _ alignment: ContentVerticalAlignment
  ) -> Self {
    contentVerticalAlignment = alignment
    return self
  }

  @discardableResult
  func contentHorizontalAlignment(
    _ alignment: ContentHorizontalAlignment
  ) -> Self {
    contentHorizontalAlignment = alignment
    return self
  }

  @discardableResult
  func target(
    _ target: Any?, action: Selector, for events: Event
  ) -> Self {
    addTarget(target, action: action, for: events)
    return self
  }
}
