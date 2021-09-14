import UIKit

public protocol LayoutAnchor {
  func constraint(
    equalTo anchor: Self,
    constant: CGFloat) -> NSLayoutConstraint
  func constraint(
    greaterThanOrEqualTo anchor: Self,
    constant: CGFloat) -> NSLayoutConstraint
  func constraint(
    lessThanOrEqualTo anchor: Self,
    constant: CGFloat) -> NSLayoutConstraint
}

public protocol LayoutDimension: LayoutAnchor {
  func constraint(equalToConstant c: CGFloat) -> NSLayoutConstraint
  func constraint(greaterThanOrEqualToConstant c: CGFloat) -> NSLayoutConstraint
  func constraint(lessThanOrEqualToConstant c: CGFloat) -> NSLayoutConstraint

  func constraint(
    equalTo anchor: Self,
    multiplier m: CGFloat,
    constant c: CGFloat) -> NSLayoutConstraint
  func constraint(
    greaterThanOrEqualTo anchor: Self,
    multiplier m: CGFloat,
    constant c: CGFloat) -> NSLayoutConstraint
  func constraint(
    lessThanOrEqualTo anchor: Self,
    multiplier m: CGFloat,
    constant c: CGFloat) -> NSLayoutConstraint
}

extension NSLayoutAnchor: LayoutAnchor {}
extension NSLayoutDimension: LayoutDimension {}

public struct LayoutAnchorBox<Anchor: LayoutAnchor> {
  let anchor: Anchor
}

public struct LayoutDimensionBox<Dimension: LayoutDimension> {
  let anchor: Dimension
}

public struct LayoutAnchorPack<Anchor: LayoutAnchor> {
  let anchor: Anchor
  let constant: CGFloat
}

public struct LayoutDimensionPack<Dimension: LayoutDimension> {
  let anchor: Dimension
  let multiplier: CGFloat
  let constant: CGFloat
}

extension LayoutAnchorBox {
  @discardableResult
  func equal(
    to otherAnchor: Anchor,
    offsetBy constant: CGFloat = 0
  ) -> NSLayoutConstraint {
    let result = anchor.constraint(
      equalTo: otherAnchor,
      constant: constant
    )
    result.isActive = true
    return result
  }

  @discardableResult
  func greaterThanOrEqual(
    to otherAnchor: Anchor,
    offsetBy constant: CGFloat = 0
  ) -> NSLayoutConstraint {
    let result = anchor.constraint(
      greaterThanOrEqualTo: otherAnchor,
      constant: constant
    )
    result.isActive = true
    return result
  }

  @discardableResult
  func lessThanOrEqual(
    to otherAnchor: Anchor,
    offsetBy constant: CGFloat = 0
  ) -> NSLayoutConstraint {
    let result = anchor.constraint(
      lessThanOrEqualTo: otherAnchor,
      constant: constant
    )
    result.isActive = true
    return result
  }
}

extension LayoutDimensionBox {
  @discardableResult
  func equalToConstant(_ c: CGFloat) -> NSLayoutConstraint {
    let result = anchor.constraint(equalToConstant: c)
    result.isActive = true
    return result
  }

  @discardableResult
  func greaterThanOrEqualToConstant(_ c: CGFloat) -> NSLayoutConstraint {
    let result = anchor.constraint(greaterThanOrEqualToConstant: c)
    result.isActive = true
    return result
  }

  @discardableResult
  func lessThanOrEqualToConstant(_ c: CGFloat) -> NSLayoutConstraint {
    let result = anchor.constraint(lessThanOrEqualToConstant: c)
    result.isActive = true
    return result
  }

  @discardableResult
  func equal(
    to otherAnchor: Dimension,
    multiplier m: CGFloat,
    constant c: CGFloat
  ) -> NSLayoutConstraint {
    let result = anchor.constraint(
      equalTo: otherAnchor,
      multiplier: m,
      constant: c
    )
    result.isActive = true
    return result
  }

  @discardableResult
  func greaterThanOrEqual(
    to otherAnchor: Dimension,
    multiplier m: CGFloat,
    constant c: CGFloat
  ) -> NSLayoutConstraint {
    let result = anchor.constraint(
      greaterThanOrEqualTo: otherAnchor,
      multiplier: m,
      constant: c
    )
    result.isActive = true
    return result
  }

  @discardableResult
  func lessThanOrEqual(
    to otherAnchor: Dimension,
    multiplier m: CGFloat,
    constant c: CGFloat
  ) -> NSLayoutConstraint {
    let result = anchor.constraint(
      lessThanOrEqualTo: otherAnchor,
      multiplier: m,
      constant: c
    )
    result.isActive = true
    return result
  }
}

public class LayoutProxy {
  public lazy var leading = LayoutAnchorBox(anchor: target.leadingAnchor)
  public lazy var trailing = LayoutAnchorBox(anchor: target.trailingAnchor)
  public lazy var top = LayoutAnchorBox(anchor: target.topAnchor)
  public lazy var bottom = LayoutAnchorBox(anchor: target.bottomAnchor)
  public lazy var centerX = LayoutAnchorBox(anchor: target.centerXAnchor)
  public lazy var centerY = LayoutAnchorBox(anchor: target.centerYAnchor)
  public lazy var firstBaseline = LayoutAnchorBox(anchor: target.firstBaselineAnchor)
  public lazy var lastBaseline = LayoutAnchorBox(anchor: target.lastBaselineAnchor)

  public lazy var width = LayoutDimensionBox(anchor: target.widthAnchor)
  public lazy var height = LayoutDimensionBox(anchor: target.heightAnchor)

  public lazy var size = SizePack(width: width, height: height)
  public lazy var center = CenterPack(centerX: centerX, centerY: centerY)
  public lazy var edges = EdgesPack(
    leading: leading, trailing: trailing,
    top: top, bottom: bottom
  )

  public let target: UIView

  init(target: UIView) {
    self.target = target
  }

  public struct SizePack {
    let width: LayoutDimensionBox<NSLayoutDimension>
    let height: LayoutDimensionBox<NSLayoutDimension>
  }

  public struct CenterPack {
    let centerX: LayoutAnchorBox<NSLayoutXAxisAnchor>
    let centerY: LayoutAnchorBox<NSLayoutYAxisAnchor>
  }

  public struct EdgesPack {
    let leading: LayoutAnchorBox<NSLayoutXAxisAnchor>
    let trailing: LayoutAnchorBox<NSLayoutXAxisAnchor>
    let top: LayoutAnchorBox<NSLayoutYAxisAnchor>
    let bottom: LayoutAnchorBox<NSLayoutYAxisAnchor>
  }
}

extension UIView {
  public struct SizeAnchorPack {
    let widthAnchor: NSLayoutDimension
    let heightAnchor: NSLayoutDimension
  }

  public var sizeAnchor: SizeAnchorPack {
    .init(widthAnchor: widthAnchor, heightAnchor: heightAnchor)
  }

  public struct CenterAnchorPack {
    let centerXAnchor: NSLayoutXAxisAnchor
    let centerYAnchor: NSLayoutYAxisAnchor
  }

  public var centerAnchor: CenterAnchorPack {
    .init(centerXAnchor: centerXAnchor, centerYAnchor: centerYAnchor)
  }

  public struct EdgesPack {
    let leading: NSLayoutXAxisAnchor
    let trailing: NSLayoutXAxisAnchor
    let top: NSLayoutYAxisAnchor
    let bottom: NSLayoutYAxisAnchor
  }

  public var edgesAnchor: EdgesPack {
    .init(
      leading: leadingAnchor,
      trailing: trailingAnchor,
      top: topAnchor,
      bottom: bottomAnchor
    )
  }

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macCatalyst 13.0, *)
  public var safeEdgesAnchor: EdgesPack {
    .init(
      leading: safeAreaLayoutGuide.leadingAnchor,
      trailing: safeAreaLayoutGuide.trailingAnchor,
      top: safeAreaLayoutGuide.topAnchor,
      bottom: safeAreaLayoutGuide.bottomAnchor
    )
  }

  public struct EdgesMarginPack {
    let edges: EdgesPack
    let margin: UIEdgeInsets
  }
}

extension UIView {
  @discardableResult
  public func addSubview(_ view: UIView, layout: (LayoutProxy) -> Void) -> Self {
    addSubview(view)
    view.layout(using: layout)
    return self
  }

  @discardableResult
  public func layout(using closure: (LayoutProxy) -> Void) -> Self {
    translatesAutoresizingMaskIntoConstraints = false
    closure(LayoutProxy(target: self))
    return self
  }

  @discardableResult
  public func relayout(using closure: (LayoutProxy) -> Void) -> Self  {
    NSLayoutConstraint.deactivate(constraints)
    closure(LayoutProxy(target: self))
    updateConstraintsIfNeeded()
    return self
  }


  @discardableResult
  public func addSubviews(
    _ pairs: (view: UIView, layout: (LayoutProxy) -> Void)...
  ) -> Self {
    for pair in pairs {
      addSubview(pair.view)
      pair.view.layout(using: pair.layout)
    }
    return self
  }

  @discardableResult
  public func addSubviews(
    _ pairs: [(view: UIView, layout: (LayoutProxy) -> Void)]
  ) -> Self {
    for pair in pairs {
      addSubview(pair.view)
      pair.view.layout(using: pair.layout)
    }
    return self
  }
}

extension UIStackView {
  @discardableResult
  public func addArrangedSubview(
    _ view: UIView,
    layout: (LayoutProxy) -> Void
  ) -> Self {
    addArrangedSubview(view)
    view.layout(using: layout)
    return self
  }

  @discardableResult
  public func addArrangedSubviews(
    _ pairs: (view: UIView, layout: (LayoutProxy) -> Void)...
  ) -> Self {
    for pair in pairs {
      addArrangedSubview(pair.view)
      pair.view.layout(using: pair.layout)
    }
    return self
  }

  @discardableResult
  public func addArrangedSubviews(
    _ pairs: [(view: UIView, layout: (LayoutProxy) -> Void)]
  ) -> Self {
    for pair in pairs {
      addArrangedSubview(pair.view)
      pair.view.layout(using: pair.layout)
    }
    return self
  }
}

public func +<Anchor: LayoutAnchor>(
  lhs: Anchor,
  rhs: CGFloat
) -> LayoutAnchorPack<Anchor> {
  .init(anchor: lhs, constant: rhs)
}

public func -<Anchor: LayoutAnchor>(
  lhs: Anchor,
  rhs: CGFloat
) -> LayoutAnchorPack<Anchor> {
  .init(anchor: lhs, constant: -rhs)
}

public func +<Anchor: LayoutDimension>(
  lhs: Anchor,
  rhs: CGFloat
) -> LayoutDimensionPack<Anchor> {
  .init(anchor: lhs, multiplier: 1, constant: rhs)
}

public func -<Anchor: LayoutDimension>(
  lhs: Anchor,
  rhs: CGFloat
) -> LayoutDimensionPack<Anchor> {
  .init(anchor: lhs, multiplier: 1, constant: -rhs)
}

public func *<Anchor: LayoutDimension>(
  lhs: Anchor,
  rhs: CGFloat)
-> LayoutDimensionPack<Anchor> {
  .init(anchor: lhs, multiplier: rhs, constant: 0)
}

public func /<Anchor: LayoutDimension>(
  lhs: Anchor,
  rhs: CGFloat
) -> LayoutDimensionPack<Anchor> {
  .init(anchor: lhs, multiplier: 1.0 / rhs, constant: 0)
}

public func +<Anchor: LayoutDimension>(
  lhs: LayoutDimensionPack<Anchor>,
  rhs: CGFloat
) -> LayoutDimensionPack<Anchor> {
  .init(
    anchor: lhs.anchor,
    multiplier: lhs.multiplier,
    constant: lhs.constant + rhs
  )
}

public func -<Anchor: LayoutDimension>(
  lhs: LayoutDimensionPack<Anchor>,
  rhs: CGFloat
) -> LayoutDimensionPack<Anchor> {
  .init(
    anchor: lhs.anchor,
    multiplier: lhs.multiplier,
    constant: lhs.constant - rhs
  )
}

public func *<Anchor: LayoutDimension>(
  lhs: LayoutDimensionBox<Anchor>,
  rhs: CGFloat
) -> LayoutDimensionPack<Anchor> {
  .init(anchor: lhs.anchor, multiplier: rhs, constant: 0)
}

public func /<Anchor: LayoutDimension>(
  lhs: LayoutDimensionBox<Anchor>,
  rhs: CGFloat
) -> LayoutDimensionPack<Anchor> {
  .init(anchor: lhs.anchor, multiplier: 1.0 / rhs, constant: 0)
}

public func -(
  lhs: UIView.EdgesPack,
  rhs: UIEdgeInsets
) -> UIView.EdgesMarginPack {
  .init(edges: lhs, margin: rhs)
}

@discardableResult
public func ==<Anchor: LayoutAnchor>(
  lhs: LayoutAnchorBox<Anchor>,
  rhs: LayoutAnchorPack<Anchor>
) -> NSLayoutConstraint {
  lhs.equal(to: rhs.anchor, offsetBy: rhs.constant)
}

@discardableResult
public func ==<Anchor: LayoutAnchor>(
  lhs: LayoutAnchorBox<Anchor>,
  rhs: Anchor
) -> NSLayoutConstraint {
  lhs.equal(to: rhs)
}

@discardableResult
public func >=<Anchor: LayoutAnchor>(
  lhs: LayoutAnchorBox<Anchor>,
  rhs: LayoutAnchorPack<Anchor>
) -> NSLayoutConstraint {
  lhs.greaterThanOrEqual(to: rhs.anchor, offsetBy: rhs.constant)
}

@discardableResult
public func >=<Anchor: LayoutAnchor>(
  lhs: LayoutAnchorBox<Anchor>,
  rhs: Anchor
) -> NSLayoutConstraint {
  lhs.greaterThanOrEqual(to: rhs)
}

@discardableResult
public func <=<Anchor: LayoutAnchor>(
  lhs: LayoutAnchorBox<Anchor>,
  rhs: LayoutAnchorPack<Anchor>
) -> NSLayoutConstraint {
  lhs.lessThanOrEqual(to: rhs.anchor, offsetBy: rhs.constant)
}

@discardableResult
public func <=<Anchor: LayoutAnchor>(
  lhs: LayoutAnchorBox<Anchor>,
  rhs: Anchor
) -> NSLayoutConstraint {
  lhs.lessThanOrEqual(to: rhs)
}

@discardableResult
public func ==<Anchor: LayoutDimension>(
  lhs: LayoutDimensionBox<Anchor>,
  rhs: CGFloat
) -> NSLayoutConstraint {
  lhs.equalToConstant(rhs)
}

@discardableResult
public func ==<Anchor: LayoutDimension>(
  lhs: LayoutDimensionBox<Anchor>,
  rhs: Anchor
) -> NSLayoutConstraint {
  lhs.equal(to: rhs, multiplier: 1, constant: 0)
}

@discardableResult
public func ==<Anchor: LayoutDimension>(
  lhs: LayoutDimensionBox<Anchor>,
  rhs: LayoutDimensionPack<Anchor>
) -> NSLayoutConstraint {
  lhs.equal(
    to: rhs.anchor,
    multiplier: rhs.multiplier,
    constant: rhs.constant
  )
}

@discardableResult
public func >=<Anchor: LayoutDimension>(
  lhs: LayoutDimensionBox<Anchor>,
  rhs: CGFloat
) -> NSLayoutConstraint {
  lhs.greaterThanOrEqualToConstant(rhs)
}

@discardableResult
public func >=<Anchor: LayoutDimension>(
  lhs: LayoutDimensionBox<Anchor>,
  rhs: Anchor
) -> NSLayoutConstraint {
  lhs.greaterThanOrEqual(
    to: rhs,
    multiplier: 1,
    constant: 0
  )
}

@discardableResult
public func >=<Anchor: LayoutDimension>(
  lhs: LayoutDimensionBox<Anchor>,
  rhs: LayoutDimensionPack<Anchor>
) -> NSLayoutConstraint {
  lhs.greaterThanOrEqual(
    to: rhs.anchor,
    multiplier: rhs.multiplier,
    constant: rhs.constant
  )
}

@discardableResult
public func <=<Anchor: LayoutDimension>(
  lhs: LayoutDimensionBox<Anchor>,
  rhs: CGFloat
) -> NSLayoutConstraint {
  lhs.lessThanOrEqualToConstant(rhs)
}

@discardableResult
public func <=<Anchor: LayoutDimension>(
  lhs: LayoutDimensionBox<Anchor>,
  rhs: Anchor
) -> NSLayoutConstraint {
  lhs.lessThanOrEqual(
    to: rhs,
    multiplier: 1,
    constant: 0
  )
}

@discardableResult
public func <=<Anchor: LayoutDimension>(
  lhs: LayoutDimensionBox<Anchor>,
  rhs: LayoutDimensionPack<Anchor>
) -> NSLayoutConstraint {
  lhs.lessThanOrEqual(
    to: rhs.anchor,
    multiplier: rhs.multiplier,
    constant: rhs.constant
  )
}

@discardableResult
public func ==(
  lhs: LayoutProxy.SizePack,
  rhs: UIView.SizeAnchorPack
) -> [NSLayoutConstraint] {
  return [
    lhs.width.equal(to: rhs.widthAnchor, multiplier: 1, constant: 0),
    lhs.height.equal(to: rhs.heightAnchor, multiplier: 1, constant: 0),
  ]
}

@discardableResult
public func ==(
  lhs: LayoutProxy.SizePack,
  rhs: CGSize
) -> [NSLayoutConstraint] {
  return [
    lhs.width.equalToConstant(rhs.width),
    lhs.height.equalToConstant(rhs.height),
  ]
}

@discardableResult
public func ==(
  lhs: LayoutProxy.CenterPack,
  rhs: UIView.CenterAnchorPack
) -> [NSLayoutConstraint] {
  return [
    lhs.centerX.equal(to: rhs.centerXAnchor),
    lhs.centerY.equal(to: rhs.centerYAnchor),
  ]
}

@discardableResult
public func ==(
  lhs: LayoutProxy.EdgesPack,
  rhs: UIView.EdgesPack
) -> [NSLayoutConstraint] {
  return [
    lhs.leading.equal(to: rhs.leading),
    lhs.trailing.equal(to: rhs.trailing),
    lhs.top.equal(to: rhs.top),
    lhs.bottom.equal(to: rhs.bottom),
  ]
}

@discardableResult
public func ==(
  lhs: LayoutProxy.EdgesPack,
  rhs: UIView.EdgesMarginPack
) -> [NSLayoutConstraint] {
  return [
    lhs.leading.equal(to: rhs.edges.leading, offsetBy: rhs.margin.left),
    lhs.trailing.equal(to: rhs.edges.trailing, offsetBy: -rhs.margin.right),
    lhs.top.equal(to: rhs.edges.top, offsetBy: rhs.margin.top),
    lhs.bottom.equal(to: rhs.edges.bottom, offsetBy: -rhs.margin.bottom),
  ]
}
