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

  /// Call lastly while arrange subviews
  @discardableResult
  public func distributionCenter() -> Self {
    insertArrangedSubview(UIView().useConstraints(), at: 0)
    addArrangedSubview(UIView().useConstraints())
    return distributeHeadEqualTail()
  }

  @discardableResult
  public func distributeHeadEqualTail() -> Self {
    if
      let head = arrangedSubviews.first,
      let tail = arrangedSubviews.last,
      head !== tail
    {
      switch axis {
      case .horizontal:
        head.width(equalTo: tail)
      case .vertical:
        head.height(equalTo: tail)
      @unknown default:
        print("Unknown default distribution: do nothing")
      }
    }
    return self
  }
}
