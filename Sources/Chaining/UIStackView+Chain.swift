import UIKit

public extension UIStackView {
  @discardableResult
  func alignment(_ value: Alignment) -> Self {
    alignment = value
    return self
  }

  @discardableResult
  func axis(_ value: NSLayoutConstraint.Axis) -> Self {
    axis = value
    return self
  }

  @discardableResult
  func baselineRelativeArrangement(_ flag: Bool) -> Self {
    isBaselineRelativeArrangement = flag
    return self
  }

  @discardableResult
  func distribution(_ value: Distribution) -> Self {
    distribution = value
    return self
  }

  @discardableResult
  func layoutMarginsRelativeArrangement(_ flag: Bool) -> Self {
    isLayoutMarginsRelativeArrangement = flag
    return self
  }

  @discardableResult
  func spacing(_ value: CGFloat) -> Self {
    spacing = value
    return self
  }
}

public extension UIStackView {
  @discardableResult
  func addArrangedSubview(_ view: UIView?) -> Self {
    if let view {
      addArrangedSubview(view)
    }
    return self
  }

  @discardableResult
  func addArrangedSubviews(_ views: UIView...) -> Self {
    views.forEach(addArrangedSubview(_:))
    return self
  }

  @discardableResult
  func addArrangedSubviews(_ views: UIView?...) -> Self {
    views.compactMap { $0 }.forEach(addArrangedSubview(_:))
    return self
  }

  @discardableResult
  func addArrangedSubviews(_ views: [UIView]) -> Self {
    views.forEach(addArrangedSubview(_:))
    return self
  }

  @discardableResult
  func addArrangedSubviews(_ views: [UIView?]) -> Self {
    views.compactMap { $0 }.forEach(addArrangedSubview(_:))
    return self
  }

  @discardableResult
  func removeArrangedSubviews(_ views: UIView...) -> Self {
    views.forEach(removeArrangedSubview(_:))
    return self
  }

  @discardableResult
  func removeArrangedSubviews(_ views: [UIView]) -> Self {
    views.forEach(removeArrangedSubview(_:))
    return self
  }

  /// Compose of `removeArrangedSubview(_:)` & `removeFromSuperview`
  func detachArrangedSubview(_ view: UIView) {
    removeArrangedSubview(view)
    view.removeFromSuperview()
  }

  func detachArrangedSubviews(_ views: UIView...) {
    views.forEach(detachArrangedSubview(_:))
  }

  func detachArrangedSubviews(_ views: [UIView]) {
    views.forEach(detachArrangedSubview(_:))
  }

  /// Call lastly while arrange subviews
  @discardableResult
  func distributionCenter() -> Self {
    insertArrangedSubview(UIView().useConstraints(), at: 0)
    addArrangedSubview(UIView().useConstraints())
    return distributeHeadEqualTail()
  }

  @discardableResult
  func distributeHeadEqualTail() -> Self {
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

public extension UIStackView {
  @discardableResult
  func centering() -> Self {
    let header = UIView().useConstraints()
    let footer = UIView().useConstraints()

    insertArrangedSubview(header, at: 0)
    addArrangedSubview(footer)

    switch axis {
    case .horizontal:
      header.widthAnchor.constraint(equalTo: footer.widthAnchor).isActive = true
    case .vertical:
      header.heightAnchor.constraint(equalTo: footer.heightAnchor).isActive = true
    @unknown default:
      header.heightAnchor.constraint(equalTo: footer.heightAnchor).isActive = true
      header.widthAnchor.constraint(equalTo: footer.widthAnchor).isActive = true
    }

    return self
  }

  @discardableResult
  func applyCentering() -> Self {
    let header = arrangedSubviews[0]
    let footer = arrangedSubviews.last!

    switch axis {
    case .horizontal:
      header.widthAnchor.constraint(equalTo: footer.widthAnchor).isActive = true
    case .vertical:
      header.heightAnchor.constraint(equalTo: footer.heightAnchor).isActive = true
    @unknown default:
      header.heightAnchor.constraint(equalTo: footer.heightAnchor).isActive = true
      header.widthAnchor.constraint(equalTo: footer.widthAnchor).isActive = true
    }

    return self
  }
}
