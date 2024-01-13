import UIKit

public extension CALayer {
  @discardableResult
  func delegate(_ value: CALayerDelegate?) -> Self {
    delegate = value
    return self
  }

  @discardableResult
  func contents(_ value: Any?) -> Self {
    contents = value
    return self
  }

  @discardableResult
  func contentsRect(_ value: CGRect) -> Self {
    contentsRect = value
    return self
  }

  @discardableResult
  func contentsCenter(_ value: CGRect) -> Self {
    contentsCenter = value
    return self
  }

  @discardableResult
  func opacity(_ value: Float) -> Self {
    opacity = value
    return self
  }

  @discardableResult
  func hidden(_ hidden: Bool) -> Self {
    isHidden = hidden
    return self
  }

  @discardableResult
  func masksToBounds(_ masks: Bool) -> Self {
    masksToBounds = masks
    return self
  }

  @discardableResult
  func mask(_ value: CALayer?) -> Self {
    mask = value
    return self
  }

  @discardableResult
  func doubleSided(_ doubleSided: Bool) -> Self {
    isDoubleSided = doubleSided
    return self
  }

  @discardableResult
  func cornerRadius(_ radius: CGFloat) -> Self {
    cornerRadius = radius
    return self
  }

  @available(iOS 11.0, *)
  @discardableResult
  func maskedCorners(_ corners: CACornerMask) -> Self {
    maskedCorners = corners
    return self
  }

  @discardableResult
  func borderWidth(_ width: CGFloat) -> Self {
    borderWidth = width
    return self
  }

  @discardableResult
  func borderColor(_ color: UIColor?) -> Self {
    borderColor = color?.cgColor
    return self
  }

  @discardableResult
  func shadowOpacity(_ opacity: Float) -> Self {
    shadowOpacity = opacity
    return self
  }

  @discardableResult
  func shadowRadius(_ radius: CGFloat) -> Self {
    shadowRadius = radius
    return self
  }

  @discardableResult
  func shadowOffset(_ offset: CGSize) -> Self {
    shadowOffset = offset
    return self
  }

  @discardableResult
  @objc func shadowColor(_ color: UIColor?) -> Self {
    shadowColor = color?.cgColor
    return self
  }

  @discardableResult
  @objc func shadowPath(_ path: CGPath?) -> Self {
    shadowPath = path
    return self
  }

  @discardableResult
  @objc func style(_ value: [AnyHashable: Any]?) -> Self {
    style = value
    return self
  }

  @discardableResult
  func allowsEdgeAntialiasing(_ allows: Bool) -> Self {
    allowsEdgeAntialiasing = allows
    return self
  }

  @discardableResult
  func allowsGroupOpacity(_ allows: Bool) -> Self {
    allowsGroupOpacity = allows
    return self
  }

  @discardableResult
  @objc func filters(_ elements: [Any]?) -> Self {
    filters = elements
    return self
  }

  @discardableResult
  @objc func compositingFilter(_ filters: [Any]?) -> Self {
    compositingFilter = filters
    return self
  }

  @discardableResult
  @objc func backgroundFilters(_ filters: [Any]?) -> Self {
    backgroundFilters = filters
    return self
  }

  @discardableResult
  @objc func minificationFilter(_ filter: CALayerContentsFilter) -> Self {
    minificationFilter = filter
    return self
  }

  @discardableResult
  func minificationFilterBias(_ bias: Float) -> Self {
    minificationFilterBias = bias
    return self
  }

  @discardableResult
  @objc func magnificationFilter(_ filter: CALayerContentsFilter) -> Self {
    magnificationFilter = filter
    return self
  }

  @discardableResult
  func opaque(_ opaque: Bool) -> Self {
    isOpaque = opaque
    return self
  }

  @discardableResult
  @objc func edgeAntialiasingMask(_ mask: CAEdgeAntialiasingMask) -> Self {
    edgeAntialiasingMask = mask
    return self
  }

  @discardableResult
  func geometryFlipped(_ flipped: Bool) -> Self {
    isGeometryFlipped = flipped
    return self
  }

  @discardableResult
  func drawsAsynchronously(_ async: Bool) -> Self {
    drawsAsynchronously = async
    return self
  }

  @discardableResult
  func shouldRasterize(_ should: Bool) -> Self {
    shouldRasterize = should
    return self
  }

  @discardableResult
  func rasterizationScale(_ scale: CGFloat) -> Self {
    rasterizationScale = scale
    return self
  }

  @discardableResult
  func frame(_ value: CGRect) -> Self {
    frame = value
    return self
  }

  @discardableResult
  func bounds(_ value: CGRect) -> Self {
    bounds = value
    return self
  }

  @discardableResult
  func position(_ value: CGPoint) -> Self {
    position = value
    return self
  }

  @discardableResult
  func zPosition(_ value: CGFloat) -> Self {
    zPosition = value
    return self
  }

  @discardableResult
  func anchorPointZ(_ value: CGFloat) -> Self {
    anchorPointZ = value
    return self
  }

  @discardableResult
  func anchorPoint(_ value: CGPoint) -> Self {
    anchorPoint = value
    return self
  }

  @discardableResult
  func contentsScale(_ value: CGFloat) -> Self {
    contentsScale = value
    return self
  }

  @discardableResult
  func transform(_ value: CATransform3D) -> Self {
    transform = value
    return self
  }

  @discardableResult
  func sublayerTransform(_ value: CATransform3D) -> Self {
    sublayerTransform = value
    return self
  }

  @discardableResult
  func sublayers(_ layers: [CALayer]?) -> Self {
    sublayers = layers
    return self
  }

  @discardableResult
  func needsDisplayOnBoundsChange(_ needs: Bool) -> Self {
    needsDisplayOnBoundsChange = needs
    return self
  }

  @discardableResult
  func actions(_ elements: [String: CAAction]?) -> Self {
    actions = elements
    return self
  }

  @discardableResult
  func name(_ value: String?) -> Self {
    name = value
    return self
  }

  @available(iOS 13.0, *)
  @discardableResult
  func cornerCurve(_ curve: CALayerCornerCurve) -> Self {
    cornerCurve = curve
    return self
  }
}
