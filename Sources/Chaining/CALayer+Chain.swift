import UIKit

extension CALayer {
  @discardableResult
  public func opacity(_ value: Float) -> Self {
    opacity = value
    return self
  }

  @discardableResult
  public func masksToBounds(_ masks: Bool) -> Self {
    masksToBounds = masks
    return self
  }

  @discardableResult
  public func cornerRadius(_ radius: CGFloat) -> Self {
    cornerRadius = radius
    return self
  }

  @available(iOS 11.0, *)
  @discardableResult
  public func maskedCorners(_ corners: CACornerMask) -> Self {
    maskedCorners = corners
    return self
  }

  @discardableResult
  public func borderWidth(_ width: CGFloat) -> Self {
    borderWidth = width
    return self
  }

  @discardableResult
  public func borderColor(_ color: UIColor?) -> Self {
    borderColor = color?.cgColor
    return self
  }

  @discardableResult
  public func shadowOpacity(_ opacity: Float) -> Self {
    shadowOpacity = opacity
    return self
  }

  @discardableResult
  public func shadowRadius(_ radius: CGFloat) -> Self {
    shadowRadius = radius
    return self
  }

  @discardableResult
  public func shadowOffset(_ offset: CGSize) -> Self {
    shadowOffset = offset
    return self
  }

  @discardableResult
  @objc public func shadowColor(_ color: UIColor?) -> Self {
    shadowColor = color?.cgColor
    return self
  }

  @discardableResult
  public func opaque(_ opaque: Bool) -> Self {
    isOpaque = opaque
    return self
  }

  @discardableResult
  public func shouldRasterize(_ should: Bool) -> Self {
    shouldRasterize = should
    return self
  }
}
