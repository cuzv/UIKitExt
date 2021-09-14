import UIKit

extension UIStackView {
  @discardableResult
  public func alignment(_ value: Alignment) -> Self {
    alignment = value
    return self
  }

  @discardableResult
  public func axis(_ value: NSLayoutConstraint.Axis) -> Self {
    axis = value
    return self
  }

  @discardableResult
  public func baselineRelativeArrangement(_ flag: Bool) -> Self {
    isBaselineRelativeArrangement = flag
    return self
  }

  @discardableResult
  public func distribution(_ value: Distribution) -> Self {
    distribution = value
    return self
  }

  @discardableResult
  public func layoutMarginsRelativeArrangement(_ flag: Bool) -> Self {
    isLayoutMarginsRelativeArrangement = flag
    return self
  }

  @discardableResult
  public func spacing(_ value: CGFloat) -> Self {
    spacing = value
    return self
  }
}

extension UIStackView {
  @discardableResult
  public func addArrangedSubviews(_ views: UIView...) -> Self {
    views.forEach(addArrangedSubview(_:))
    return self
  }

  @discardableResult
  public func addArrangedSubviews(_ views: [UIView]) -> Self {
    views.forEach(addArrangedSubview(_:))
    return self
  }

  @discardableResult
  public func removeArrangedSubviews(_ views: UIView...) -> Self {
    views.forEach(removeArrangedSubview(_:))
    return self
  }

  @discardableResult
  public func removeArrangedSubviews(_ views: [UIView]) -> Self {
    views.forEach(removeArrangedSubview(_:))
    return self
  }
}
