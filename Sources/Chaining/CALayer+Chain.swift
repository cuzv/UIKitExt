import UIKit

extension CALayer {
  @discardableResult
  public func delegate(_ value: CALayerDelegate?) -> Self {
    delegate = value
    return self
  }

  @discardableResult
  public func contents(_ value: Any?) -> Self {
    contents = value
    return self
  }

  @discardableResult
  public func contentsRect(_ value: CGRect) -> Self {
    contentsRect = value
    return self
  }

  @discardableResult
  public func contentsCenter(_ value: CGRect) -> Self {
    contentsCenter = value
    return self
  }

  @discardableResult
  public func opacity(_ value: Float) -> Self {
    opacity = value
    return self
  }

  @discardableResult
  public func hidden(_ hidden: Bool) -> Self {
    isHidden = hidden
    return self
  }

  @discardableResult
  public func masksToBounds(_ masks: Bool) -> Self {
    masksToBounds = masks
    return self
  }

  @discardableResult
  public func mask(_ value: CALayer?) -> Self {
    mask = value
    return self
  }

  @discardableResult
  public func doubleSided(_ doubleSided: Bool) -> Self {
    isDoubleSided = doubleSided
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
  @objc public func shadowPath(_ path: CGPath?) -> Self {
    shadowPath = path
    return self
  }

  @discardableResult
  @objc public func style(_ value: [AnyHashable: Any]?) -> Self {
    style = value
    return self
  }

  @discardableResult
  public func allowsEdgeAntialiasing(_ allows: Bool) -> Self {
    allowsEdgeAntialiasing = allows
    return self
  }

  @discardableResult
  public func allowsGroupOpacity(_ allows: Bool) -> Self {
    allowsGroupOpacity = allows
    return self
  }

  @discardableResult
  @objc public func filters(_ elements: [Any]?) -> Self {
    filters = elements
    return self
  }

  @discardableResult
  @objc public func compositingFilter(_ filters: [Any]?) -> Self {
    compositingFilter = filters
    return self
  }

  @discardableResult
  @objc public func backgroundFilters(_ filters: [Any]?) -> Self {
    backgroundFilters = filters
    return self
  }

  @discardableResult
  @objc public func minificationFilter(_ filter: CALayerContentsFilter) -> Self {
    minificationFilter = filter
    return self
  }

  @discardableResult
  public func minificationFilterBias(_ bias: Float) -> Self {
    minificationFilterBias = bias
    return self
  }

  @discardableResult
  @objc public func magnificationFilter(_ filter: CALayerContentsFilter) -> Self {
    magnificationFilter = filter
    return self
  }

  @discardableResult
  public func opaque(_ opaque: Bool) -> Self {
    isOpaque = opaque
    return self
  }

  @discardableResult
  @objc public func edgeAntialiasingMask(_ mask: CAEdgeAntialiasingMask) -> Self {
    edgeAntialiasingMask = mask
    return self
  }

  @discardableResult
  public func geometryFlipped(_ flipped: Bool) -> Self {
    isGeometryFlipped = flipped
    return self
  }

  @discardableResult
  public func drawsAsynchronously(_ async: Bool) -> Self {
    drawsAsynchronously = async
    return self
  }

  @discardableResult
  public func shouldRasterize(_ should: Bool) -> Self {
    shouldRasterize = should
    return self
  }

  @discardableResult
  public func rasterizationScale(_ scale: CGFloat) -> Self {
    rasterizationScale = scale
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
  public func position(_ value: CGPoint) -> Self {
    position = value
    return self
  }

  @discardableResult
  public func zPosition(_ value: CGFloat) -> Self {
    zPosition = value
    return self
  }

  @discardableResult
  public func anchorPointZ(_ value: CGFloat) -> Self {
    anchorPointZ = value
    return self
  }

  @discardableResult
  public func anchorPoint(_ value: CGPoint) -> Self {
    anchorPoint = value
    return self
  }

  @discardableResult
  public func contentsScale(_ value: CGFloat) -> Self {
    contentsScale = value
    return self
  }

  @discardableResult
  public func transform(_ value: CATransform3D) -> Self {
    transform = value
    return self
  }

  @discardableResult
  public func sublayerTransform(_ value: CATransform3D) -> Self {
    sublayerTransform = value
    return self
  }

  @discardableResult
  public func sublayers(_ layers: [CALayer]?) -> Self {
    sublayers = layers
    return self
  }

  @discardableResult
  public func needsDisplayOnBoundsChange(_ needs: Bool) -> Self {
    needsDisplayOnBoundsChange = needs
    return self
  }

  @discardableResult
  public func actions(_ elements: [String: CAAction]?) -> Self {
    actions = elements
    return self
  }

  @discardableResult
  public func name(_ value: String?) -> Self {
    name = value
    return self
  }

  @available(iOS 13.0, *)
  @discardableResult
  public func cornerCurve(_ curve: CALayerCornerCurve) -> Self {
    cornerCurve = curve
    return self
  }
}
