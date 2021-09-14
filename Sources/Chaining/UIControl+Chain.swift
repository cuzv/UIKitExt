import UIKit

extension UIControl {
  @discardableResult
  public func enabled(_ enabled: Bool) -> Self {
    isEnabled = enabled
    return self
  }

  @discardableResult
  public func selected(_ selected: Bool) -> Self {
    isSelected = selected
    return self
  }

  @discardableResult
  public func highlighted(_ highlighted: Bool) -> Self {
    isHighlighted = highlighted
    return self
  }

  @discardableResult
  public func contentVerticalAlignment(
    _ alignment: ContentVerticalAlignment
  ) -> Self {
    contentVerticalAlignment = alignment
    return self
  }

  @discardableResult
  public func contentHorizontalAlignment(
    _ alignment: ContentHorizontalAlignment
  ) -> Self {
    contentHorizontalAlignment = alignment
    return self
  }

  @discardableResult
  public func target(
    _ target: Any?, action: Selector, for events: Event
  ) -> Self {
    addTarget(target, action: action, for: events)
    return self
  }
}
