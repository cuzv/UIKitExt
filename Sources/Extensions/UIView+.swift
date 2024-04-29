import CoreGraphics
import UIKit

// MARK: - Initialize

public extension UIView {
  convenience init(
    backgroundColor: UIColor,
    cornerRadius: CGFloat = 0,
    borderWidth: CGFloat = 0,
    borderColor: UIColor? = nil,
    clipsToBounds: Bool = false
  ) {
    self.init()
    self.backgroundColor = backgroundColor
    self.clipsToBounds = clipsToBounds
    layer.cornerRadius = cornerRadius
    layer.borderWidth = borderWidth
    layer.borderColor = borderColor?.cgColor
    translatesAutoresizingMaskIntoConstraints = false
  }

  convenience init(size: CGSize) {
    self.init(frame: .init(origin: .zero, size: size))
    translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      widthAnchor.constraint(equalToConstant: size.width),
      heightAnchor.constraint(equalToConstant: size.height),
    ])
  }

  convenience init(length: CGFloat) {
    self.init(size: .init(width: length, height: length))
  }

  convenience init(width: CGFloat) {
    self.init(frame: .zero)
    translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      widthAnchor.constraint(equalToConstant: width),
    ])
  }

  convenience init(height: CGFloat) {
    self.init(frame: .zero)
    translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      heightAnchor.constraint(equalToConstant: height),
    ])
  }
}

// MARK: - Layout

public extension UIView {
  @available(iOS 11.0, tvOS 11.0, macCatalyst 13.0, *)
  @discardableResult
  func filling(
    margin: UIEdgeInsets = .zero,
    useSafeLayoutGuides: Bool = true
  ) -> (
    top: NSLayoutConstraint,
    trailing: NSLayoutConstraint,
    bottom: NSLayoutConstraint,
    leading: NSLayoutConstraint
  ) {
    guard let superview else {
      fatalError("Superview required.")
    }

    let leading = useSafeLayoutGuides ? superview.safeAreaLayoutGuide.leadingAnchor : superview.leadingAnchor
    let trailing = useSafeLayoutGuides ? superview.safeAreaLayoutGuide.trailingAnchor : superview.trailingAnchor
    let top = useSafeLayoutGuides ? superview.safeAreaLayoutGuide.topAnchor : superview.topAnchor
    let bottom = useSafeLayoutGuides ? superview.safeAreaLayoutGuide.bottomAnchor : superview.bottomAnchor

    let constraints = [
      topAnchor.constraint(equalTo: top, constant: margin.top),
      trailingAnchor.constraint(equalTo: trailing, constant: -margin.right),
      bottomAnchor.constraint(equalTo: bottom, constant: -margin.bottom),
      leadingAnchor.constraint(equalTo: leading, constant: margin.left),
    ]
    NSLayoutConstraint.activate(constraints)

    return (constraints[0], constraints[1], constraints[2], constraints[3])
  }

  @discardableResult
  func centering(
    _ offset: CGPoint = .zero
  ) -> (
    centerX: NSLayoutConstraint,
    centerY: NSLayoutConstraint
  ) {
    guard let superview else {
      fatalError("Superview required.")
    }

    let constraints = [
      centerXAnchor.constraint(equalTo: superview.centerXAnchor, constant: offset.x),
      centerYAnchor.constraint(equalTo: superview.centerYAnchor, constant: offset.y),
    ]
    NSLayoutConstraint.activate(constraints)

    return (constraints[0], constraints[1])
  }

  @discardableResult
  func sizing(
    _ size: CGSize
  ) -> (
    width: NSLayoutConstraint,
    height: NSLayoutConstraint
  ) {
    let constraints = [
      widthAnchor.constraint(equalToConstant: size.width),
      heightAnchor.constraint(equalToConstant: size.height),
    ]
    NSLayoutConstraint.activate(constraints)

    return (constraints[0], constraints[1])
  }
}

// MARK: - Snapshot

public extension UIView {
  @available(iOS 10.0, *)
  func snapshot(cropping: CGRect? = nil) -> UIImage {
    let rect = cropping ?? bounds
    let renderer = UIGraphicsImageRenderer(bounds: rect)
    return renderer.image { context in
      layer.render(in: context.cgContext)
    }
  }

  /*
   /// AnySubclassOfUIView().snapshot
   /// UIScrollView().snapshot
   /// UITableView().snapshot
   public func snapshot() -> UIImage? {
   UIGraphicsBeginImageContextWithOptions(bounds.size, isOpaque, 0)
   defer { UIGraphicsEndImageContext() }
   if let context = UIGraphicsGetCurrentContext() {
   if let backgroundColor = backgroundColor {
   context.setFillColor(backgroundColor.cgColor)
   context.fill(bounds)
   }

   if let scrollView = self as? UIScrollView {
   let previousFrame = frame
   frame = CGRect(origin: frame.origin, size: scrollView.contentSize)
   layer.render(in: context)
   frame = previousFrame
   return UIGraphicsGetImageFromCurrentImageContext()
   } else {
   layer.render(in: context)
   return UIGraphicsGetImageFromCurrentImageContext()
   }
   }
   return nil
   }
   */
}

// MRARK: - Layer Property

#if !DISABLE_LAYER_PROPERTY_PROXY
public extension UIView {
  @IBInspectable var opacity: Float {
    get { layer.opacity }
    set { layer.opacity = newValue }
  }

  @IBInspectable var masksToBounds: Bool {
    get { layer.masksToBounds }
    set { layer.masksToBounds = newValue }
  }

  @IBInspectable var cornerRadius: CGFloat {
    get { layer.cornerRadius }
    set { layer.cornerRadius = newValue }
  }

  @available(iOS 11.0, *)
  var maskedCorners: CACornerMask {
    get { layer.maskedCorners }
    set { layer.maskedCorners = newValue }
  }

  /// CACornerMask.RawValue
  /// - layerMinXMinYCorner: 1
  /// - layerMaxXMinYCorner: 2
  /// - layerMinXMaxYCorner: 4
  /// - layerMaxXMaxYCorner: 8
  @available(iOS 11.0, *)
  @IBInspectable var maskedCornersRawValue: UInt {
    get { layer.maskedCorners.rawValue }
    set { layer.maskedCorners = CACornerMask(rawValue: newValue) }
  }

  @available(iOS 11.0, *)
  @IBInspectable var maskTopLeftCorner: Bool {
    get { layer.maskedCorners.contains(.layerMinXMinYCorner) }
    set { layer.maskedCorners.insert(.layerMinXMinYCorner) }
  }

  @available(iOS 11.0, *)
  @IBInspectable var maskTopRightCorner: Bool {
    get { layer.maskedCorners.contains(.layerMaxXMinYCorner) }
    set { layer.maskedCorners.insert(.layerMaxXMinYCorner) }
  }

  @available(iOS 11.0, *)
  @IBInspectable var maskBottomLeftCorner: Bool {
    get { layer.maskedCorners.contains(.layerMinXMaxYCorner) }
    set { layer.maskedCorners.insert(.layerMinXMaxYCorner) }
  }

  @available(iOS 11.0, *)
  @IBInspectable var maskBottomRightCorner: Bool {
    get { layer.maskedCorners.contains(.layerMaxXMaxYCorner) }
    set { layer.maskedCorners.insert(.layerMaxXMaxYCorner) }
  }

  @IBInspectable var borderWidth: CGFloat {
    get { layer.borderWidth }
    set { layer.borderWidth = newValue }
  }

  @IBInspectable var borderColor: UIColor? {
    get { layer.borderColor.map(UIColor.init) }
    set { layer.borderColor = newValue?.cgColor }
  }

  @IBInspectable var shadowOpacity: Float {
    get { layer.shadowOpacity }
    set { layer.shadowOpacity = newValue }
  }

  @IBInspectable var shadowRadius: CGFloat {
    get { layer.shadowRadius }
    set { layer.shadowRadius = newValue }
  }

  @IBInspectable var layerShadowOffset: CGSize {
    get { layer.shadowOffset }
    set { layer.shadowOffset = newValue }
  }

  @IBInspectable var layerShadowColor: UIColor? {
    get { layer.shadowColor.map(UIColor.init) }
    set { layer.shadowColor = newValue?.cgColor }
  }

  @IBInspectable var isOpaqueEnabled: Bool {
    get { layer.isOpaque }
    set { layer.isOpaque = newValue }
  }

  @IBInspectable var shouldRasterize: Bool {
    get { layer.shouldRasterize }
    set { layer.shouldRasterize = newValue }
  }
}
#endif

// MARK: - Border

public extension UIView {
  /// Add dash border line view using CAShapeLayer.
  /// **Note**: Before you invoke this method, ensure `self` already have correct frame.
  /// Because using CAShapeLayer, can not remove it, make sure add only once.
  func addDashBorder(
    edge: UIRectEdge = .all,
    width: CGFloat? = nil,
    color: UIColor = UIColor.separator,
    multiplier: CGFloat = 1,
    constant: CGFloat = 0,
    lineDashPattern: [CGFloat] = [5, 5]
  ) {
    func makeLineLayer(
      width: CGFloat,
      color: UIColor,
      lineDashPattern: [CGFloat],
      startPoint: CGPoint,
      endPoint: CGPoint
    ) -> CAShapeLayer {
      let lineLayer = CAShapeLayer()
      lineLayer.lineDashPattern = lineDashPattern as [NSNumber]?
      lineLayer.strokeColor = color.cgColor
      lineLayer.fillColor = UIColor.clear.cgColor
      lineLayer.lineJoin = .round
      lineLayer.lineWidth = width

      let path = CGMutablePath()
      path.move(to: CGPoint(x: startPoint.x, y: startPoint.y))
      path.addLine(to: CGPoint(x: endPoint.x, y: endPoint.y))
      lineLayer.path = path

      return lineLayer
    }

    let w = bounds.size.width
    let h = bounds.size.height
    let startX = 0.5 * w * (1.0 - multiplier) + 0.5 * constant
    let endX = 0.5 * w * (1.0 + multiplier) - 0.5 * constant
    let startY = 0.5 * h * (1.0 - multiplier) + 0.5 * constant
    let endY = 0.5 * h * (1.0 + multiplier) - 0.5 * constant
    let borderWidth = width ?? 1.0 / UIScreen.main.scale

    if edge.contains(.top) {
      let lineLayer = makeLineLayer(
        width: borderWidth,
        color: color,
        lineDashPattern: lineDashPattern,
        startPoint: CGPoint(x: startX, y: 0),
        endPoint: CGPoint(x: endX, y: 0)
      )
      layer.addSublayer(lineLayer)
    }

    if edge.contains(.left) {
      let lineLayer = makeLineLayer(
        width: borderWidth,
        color: color,
        lineDashPattern: lineDashPattern,
        startPoint: CGPoint(x: 0, y: startY),
        endPoint: CGPoint(x: 0, y: endY)
      )
      layer.addSublayer(lineLayer)
    }

    if edge.contains(.bottom) {
      let lineLayer = makeLineLayer(
        width: borderWidth,
        color: color,
        lineDashPattern: lineDashPattern,
        startPoint: CGPoint(x: startX, y: h),
        endPoint: CGPoint(x: endX, y: h)
      )
      layer.addSublayer(lineLayer)
    }

    if edge.contains(.right) {
      let lineLayer = makeLineLayer(
        width: borderWidth,
        color: color,
        lineDashPattern: lineDashPattern,
        startPoint: CGPoint(x: w, y: startY),
        endPoint: CGPoint(x: w, y: endY)
      )
      layer.addSublayer(lineLayer)
    }
  }

  private class _BorderLineView: UIView {
    fileprivate var edge: UIRectEdge
    fileprivate init(edge: UIRectEdge) {
      self.edge = edge
      super.init(frame: CGRect.zero)
    }

    @available(*, unavailable)
    fileprivate required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
  }

  /// Add border line view using Autolayout.
  func addBorder(
    edge: UIRectEdge = .all,
    width: CGFloat? = nil,
    color: UIColor = UIColor.separator,
    multiplier: CGFloat = 1.0,
    constant: CGFloat = 0
  ) {
    func addLineViewConstraints(
      edge: NSLayoutConstraint.Attribute,
      center: NSLayoutConstraint.Attribute,
      size: NSLayoutConstraint.Attribute,
      visualFormat: String,
      color: UIColor,
      multiplier: CGFloat,
      rectEdge: UIRectEdge
    ) {
      let lineView = _BorderLineView(edge: rectEdge)
      lineView.backgroundColor = color
      lineView.translatesAutoresizingMaskIntoConstraints = false
      addSubview(lineView)

      let edgeConstraint = NSLayoutConstraint(
        item: lineView,
        attribute: edge,
        relatedBy: .equal,
        toItem: self,
        attribute: edge,
        multiplier: 1,
        constant: 0
      )
      let centerConstraint = NSLayoutConstraint(
        item: lineView,
        attribute: center,
        relatedBy: .equal,
        toItem: self,
        attribute: center,
        multiplier: 1,
        constant: 0
      )
      let sizeConstraint = NSLayoutConstraint(
        item: lineView,
        attribute: size,
        relatedBy: .equal,
        toItem: self,
        attribute: size,
        multiplier: multiplier,
        constant: constant
      )
      addConstraints([edgeConstraint, centerConstraint, sizeConstraint])

      let constraints = NSLayoutConstraint.constraints(
        withVisualFormat: visualFormat,
        options: .directionLeadingToTrailing,
        metrics: nil,
        views: ["lineView": lineView]
      )
      addConstraints(constraints)
    }

    if edge == UIRectEdge() {
      return
    }

    for view in subviews {
      if let view = view as? _BorderLineView, edge.contains(view.edge) {
        return
      }
    }

    let borderWidth = width ?? 1.0 / UIScreen.main.scale

    if edge.contains(.top) {
      addLineViewConstraints(
        edge: .top,
        center: .centerX,
        size: .width,
        visualFormat: "V:[lineView(\(borderWidth))]",
        color: color,
        multiplier: multiplier,
        rectEdge: .top
      )
    }

    if edge.contains(.left) {
      addLineViewConstraints(
        edge: .left,
        center: .centerY,
        size: .height,
        visualFormat: "[lineView(\(borderWidth))]",
        color: color,
        multiplier: multiplier,
        rectEdge: .left
      )
    }

    if edge.contains(.bottom) {
      addLineViewConstraints(
        edge: .bottom,
        center: .centerX,
        size: .width,
        visualFormat: "V:[lineView(\(borderWidth))]",
        color: color,
        multiplier: multiplier,
        rectEdge: .bottom
      )
    }

    if edge.contains(.right) {
      addLineViewConstraints(
        edge: .right,
        center: .centerY,
        size: .height,
        visualFormat: "[lineView(\(borderWidth))]",
        color: color,
        multiplier: multiplier,
        rectEdge: .right
      )
    }
  }

  /// Remove added border line view.
  func removeBorderline(for rectEdge: UIRectEdge = .all) {
    if rectEdge == UIRectEdge() {
      return
    }

    for view in subviews {
      if let view = view as? _BorderLineView, rectEdge.contains(view.edge) {
        view.removeFromSuperview()
      }
    }
  }
}

public extension UIView {
  /// Different cornerRadius for each corner
  ///
  /// https://stackoverflow.com/questions/40498892/different-cornerradius-for-each-corner
  @discardableResult
  func roundCorners(
    topLeft: CGFloat = 0,
    topRight: CGFloat = 0,
    bottomLeft: CGFloat = 0,
    bottomRight: CGFloat = 0
  ) -> CAShapeLayer {
    let topLeftRadius = CGSize(width: topLeft, height: topLeft)
    let topRightRadius = CGSize(width: topRight, height: topRight)
    let bottomLeftRadius = CGSize(width: bottomLeft, height: bottomLeft)
    let bottomRightRadius = CGSize(width: bottomRight, height: bottomRight)

    let maskPath = UIBezierPath(
      shouldRoundRect: bounds,
      topLeftRadius: topLeftRadius,
      topRightRadius: topRightRadius,
      bottomLeftRadius: bottomLeftRadius,
      bottomRightRadius: bottomRightRadius
    )

    let shape = CAShapeLayer()
    shape.path = maskPath.cgPath
    layer.mask = shape

    return shape
  }
}
