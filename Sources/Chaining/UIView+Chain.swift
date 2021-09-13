import UIKit

extension UIView {
  @discardableResult
  public func useConstraints(_ flag: Bool = true) -> Self {
    translatesAutoresizingMaskIntoConstraints = !flag
    return self
  }

  @discardableResult
  public func backgroundColor(_ color: UIColor?) -> Self {
    backgroundColor = color
    return self
  }

  @discardableResult
  public func hidden(_ hidden: Bool) -> Self {
    isHidden = hidden
    return self
  }

  @discardableResult
  public func alpha(_ value: CGFloat) -> Self {
    alpha = value
    return self
  }

  @discardableResult
  public func opaque(_ opaque: Bool) -> Self {
    isOpaque = opaque
    return self
  }

  @discardableResult
  public func tintColor(_ color: UIColor?) -> Self {
    tintColor = color
    return self
  }

  @discardableResult
  public func tintAdjustmentMode(_ mode: TintAdjustmentMode) -> Self {
    tintAdjustmentMode = mode
    return self
  }

  @discardableResult
  public func clipsToBounds(_ clips: Bool) -> Self {
    clipsToBounds = clips
    return self
  }

  @discardableResult
  public func clearsContextBeforeDrawing(_ clears: Bool) -> Self {
    clearsContextBeforeDrawing = clears
    return self
  }

  @discardableResult
  public func mask(_ view: UIView?) -> Self {
    mask = view
    return self
  }

  @discardableResult
  public func userInteractionEnabled(_ enabled: Bool) -> Self {
    isUserInteractionEnabled = enabled
    return self
  }

  @discardableResult
  public func multipleTouchEnabled(_ enabled: Bool) -> Self {
    isMultipleTouchEnabled = enabled
    return self
  }

  @discardableResult
  public func exclusiveTouch(_ enabled: Bool) -> Self {
    isExclusiveTouch = enabled
    return self
  }

  @discardableResult
  public func frame(_ value: CGRect) -> Self {
    frame = value
    return self
  }

  @discardableResult
  public func bounds(_ value: CGRect) -> Self {
    bounds = value
    return self
  }

  @discardableResult
  public func center(_ value: CGPoint) -> Self {
    center = value
    return self
  }

  @discardableResult
  public func transform(_ value: CGAffineTransform) -> Self {
    transform = value
    return self
  }

  @available(iOS 11.0, *)
  @discardableResult
  public func directionalLayoutMargins(_ margins: NSDirectionalEdgeInsets) -> Self {
    directionalLayoutMargins = margins
    return self
  }

  @discardableResult
  public func layoutMargins(_ margins: UIEdgeInsets) -> Self {
    layoutMargins = margins
    return self
  }

  @discardableResult
  public func preservesSuperviewLayoutMargins(_ preserves: Bool) -> Self {
    preservesSuperviewLayoutMargins = preserves
    return self
  }

  @available(iOS 11.0, *)
  @discardableResult
  public func insetsLayoutMarginsFromSafeArea(_ insets: Bool) -> Self {
    insetsLayoutMarginsFromSafeArea = insets
    return self
  }

  @available(iOS 13.0, *)
  @discardableResult
  public func overrideUserInterfaceStyle(_ style: UIUserInterfaceStyle) -> Self {
    overrideUserInterfaceStyle = style
    return self
  }

  @discardableResult
  public func semanticContentAttribute(_ attribute: UISemanticContentAttribute) -> Self {
    semanticContentAttribute = attribute
    return self
  }

  @available(iOS 11.0, *)
  @discardableResult
  public func interactions(_ elements: [UIInteraction]) -> Self {
    interactions = elements
    return self
  }

  @discardableResult
  public func contentScaleFactor(_ factor: CGFloat) -> Self {
    contentScaleFactor = factor
    return self
  }

  @discardableResult
  public func gestureRecognizers(_ elements: [UIGestureRecognizer]?) -> Self {
    gestureRecognizers = elements
    return self
  }

  @discardableResult
  public func motionEffects(_ elements: [UIMotionEffect]) -> Self {
    motionEffects = elements
    return self
  }

  @discardableResult
  public func restorationIdentifier(_ identifier: String?) -> Self {
    restorationIdentifier = identifier
    return self
  }

  @discardableResult
  public func tag(_ value: Int) -> Self {
    tag = value
    return self
  }

  @available(iOS 11.0, *)
  @discardableResult
  public func accessibilityIgnoresInvertColors(_ ignores: Bool) -> Self {
    accessibilityIgnoresInvertColors = ignores
    return self
  }
}

extension UIView {
  @discardableResult
  public func opacity(_ opacity: Float) -> Self {
    layer.opacity = opacity
    return self
  }

  @discardableResult
  public func masksToBounds(_ masks: Bool) -> Self {
    layer.masksToBounds = masks
    return self
  }

  @discardableResult
  public func cornerRadius(_ radius: CGFloat) -> Self {
    layer.cornerRadius = radius
    return self
  }

  @available(iOS 11.0, *)
  @discardableResult
  public func maskedCorners(_ corners: CACornerMask) -> Self {
    layer.maskedCorners = corners
    return self
  }

  @discardableResult
  public func borderWidth(_ width: CGFloat) -> Self {
    layer.borderWidth = width
    return self
  }

  @discardableResult
  public func borderColor(_ color: UIColor?) -> Self {
    layer.borderColor = color?.cgColor
    return self
  }

  @discardableResult
  public func shadowOpacity(_ opacity: Float) -> Self {
    layer.shadowOpacity = opacity
    return self
  }

  @discardableResult
  public func shadowRadius(_ radius: CGFloat) -> Self {
    layer.shadowRadius = radius
    return self
  }

  @discardableResult
  @objc public func shadowOffset(_ offset: CGSize) -> Self {
    layer.shadowOffset = offset
    return self
  }

  @discardableResult
  @objc public func shadowColor(_ color: UIColor?) -> Self {
    layer.shadowColor = color?.cgColor
    return self
  }

  @discardableResult
  public func shouldRasterize(_ should: Bool) -> Self {
    layer.shouldRasterize = should
    return self
  }
}

extension UIView {
  @discardableResult
  public func width(_ width: CGFloat) -> Self {
    widthAnchor.constraint(equalToConstant: width).isActive = true
    frame.size.width = width
    return self
  }

  @discardableResult
  public func height(_ height: CGFloat) -> Self {
    heightAnchor.constraint(equalToConstant: height).isActive = true
    frame.size.height = height
    return self
  }

  @discardableResult
  public func size(_ size: CGSize) -> Self {
    widthAnchor.constraint(equalToConstant: size.width).isActive = true
    heightAnchor.constraint(equalToConstant: size.height).isActive = true
    frame.size = size
    return self
  }

  @discardableResult
  public func width(
    equalTo other: UIView, multiplier: CGFloat = 1, constant: CGFloat = 0
  ) -> Self {
    widthAnchor.constraint(
      equalTo: other.widthAnchor,
      multiplier: multiplier,
      constant: constant
    ).isActive = true
    frame.size.width = other.frame.size.width
    return self
  }

  @discardableResult
  public func height(
    equalTo other: UIView, multiplier: CGFloat = 1, constant: CGFloat = 0
  ) -> Self {
    heightAnchor.constraint(
      equalTo: other.heightAnchor,
      multiplier: multiplier,
      constant: constant
    ).isActive = true
    frame.size.height = other.frame.size.height
    return self
  }

  @discardableResult
  public func size(equalTo other: UIView) -> Self {
    widthAnchor.constraint(equalTo: other.widthAnchor).isActive = true
    heightAnchor.constraint(equalTo: other.heightAnchor).isActive = true
    frame.size = other.frame.size
    return self
  }
}
