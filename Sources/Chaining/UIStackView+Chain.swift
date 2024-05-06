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
}

public extension UIStackView {
  @discardableResult
  func arrange(_ view: UIView?) -> Self {
    addArrangedSubview(view)
  }

  @discardableResult
  func arrange(_ views: UIView?...) -> Self {
    addArrangedSubviews(views)
  }

  @discardableResult
  func arrange(_ views: [UIView?]) -> Self {
    addArrangedSubviews(views)
  }

  @discardableResult
  func arrange(_ views: UIView...) -> Self {
    addArrangedSubviews(views)
  }

  @discardableResult
  func arrange(_ views: [UIView]) -> Self {
    addArrangedSubviews(views)
  }

  @discardableResult
  func arrange(
    @ChildrenViewBuilder content: () -> [UIView]
  ) -> Self {
    addArrangedSubviews(content())
  }

  /// Compose of `removeArrangedSubview(_:)` & `removeFromSuperview`
  @discardableResult
  func disarrange(_ view: UIView) -> Self {
    removeArrangedSubview(view)
    view.removeFromSuperview()
    return self
  }

  @discardableResult
  func disarrange(_ views: UIView...) -> Self {
    for view in views {
      disarrange(view)
    }
    return self
  }

  @discardableResult
  func disarrange(_ views: [UIView]) -> Self {
    for view in views {
      disarrange(view)
    }
    return self
  }

  @discardableResult
  func disarrange() -> Self {
    disarrange(arrangedSubviews)
  }
}

public extension UIStackView {
  @discardableResult
  func centering() -> Self {
    insertArrangedSubview(UIView().useConstraints(), at: 0)
    addArrangedSubview(UIView().useConstraints())
    return applyCentering()
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
