import UIKit

// MARK: - Gradable

public enum GradientMode {
  case linear
  case radial
}

public enum GradientOrigin: Int {
  case topCenter      // -> bottomCenter
  case leftCenter     // -> rightCenter
  case topLeft        // -> bottomRight
  case topRight       // -> bottomLeft
}

public protocol Gradable {
  var mode: GradientMode { get }
  var start: GradientOrigin { get }
  var colors: [UIColor] { get }
  var dimmedColors: [UIColor] { get }
  var automaticallyDims: Bool { get }
  var locations: [CGFloat] { get }
}

public extension Gradable where Self: UIView {
  var mode: GradientMode { .linear }

  var start: GradientOrigin { .topCenter }

  var dimmedColors: [UIColor] { [] }

  var automaticallyDims: Bool { true }

  var locations: [CGFloat] { [0, 1] }

  fileprivate var drawingLocations: (start: CGPoint, end: CGPoint) {
    switch start {
    case .topCenter: return (
      start: CGPoint(x: bounds.midX, y: 0),
      end: CGPoint(x: bounds.midX, y: bounds.height))
    case .leftCenter: return (
      start: CGPoint(x: 0, y: bounds.midY),
      end: CGPoint(x: bounds.width, y: bounds.midY))
    case .topLeft: return (
      start: .zero,
      end: CGPoint(x: bounds.width, y: bounds.height))
    case .topRight: return (
      start: CGPoint(x: bounds.width, y: 0),
      end: CGPoint(x: 0, y: bounds.height))
    }
  }

  fileprivate var gradient: CGGradient? {
    precondition(locations.count >= 2)

    let colorSpace = CGColorSpaceCreateDeviceRGB()
    let colorSpaceModel = colorSpace.model

    let colors = gradientColors.map { color -> CGColor in
      let cgColor = color.cgColor
      let cgColorSpace = cgColor.colorSpace ?? colorSpace

      if cgColorSpace.model == colorSpaceModel {
        return cgColor
      }

      var red: CGFloat = 0
      var blue: CGFloat = 0
      var green: CGFloat = 0
      var alpha: CGFloat = 0
      color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
      return UIColor(red: red, green: green, blue: blue, alpha: alpha).cgColor
    }

    return CGGradient(
      colorsSpace: colorSpace,
      colors: colors as CFArray,
      locations: locations
    )
  }

  private var gradientColors: [UIColor] {
    precondition(colors.count >= 2)

    if tintAdjustmentMode == .dimmed {
      if !dimmedColors.isEmpty {
        precondition(dimmedColors.count >= 2)
        return dimmedColors
      }

      if automaticallyDims {
        return colors.map { color in
          var hue: CGFloat = 0
          var brightness: CGFloat = 0
          var alpha: CGFloat = 0

          color.getHue(
            &hue,
            saturation: nil,
            brightness: &brightness,
            alpha: &alpha
          )

          return UIColor(
            hue: hue,
            saturation: 0,
            brightness: brightness,
            alpha: alpha
          )
        }
      }
    }

    return colors
  }

  fileprivate func draw(_ gradient: CGGradient, context: CGContext) {
    let options: CGGradientDrawingOptions = [
      .drawsAfterEndLocation,
      .drawsBeforeStartLocation
    ]
    if mode == .linear {
      let loc = drawingLocations
      context.drawLinearGradient(
        gradient,
        start: loc.start,
        end: loc.end,
        options: options
      )
    } else {
      let center = CGPoint(x: bounds.midX, y: bounds.midY)
      context.drawRadialGradient(
        gradient,
        startCenter: center,
        startRadius: 0,
        endCenter: center,
        endRadius: min(bounds.width, bounds.height) / 2,
        options: options
      )
    }
  }
}

// MARK: - GradientView

public class GradientView: UIView, Gradable {
  public var colors: [UIColor] = [.clear, .clear] {
    didSet {
      setNeedsUpdateGradient()
    }
  }

  public var start: GradientOrigin = .topCenter {
    didSet {
      setNeedsDisplay()
    }
  }

  public var locations: [CGFloat] = [0, 1] {
    didSet {
      setNeedsUpdateGradient()
    }
  }

  private var currentGradient: CGGradient?

  private func setNeedsUpdateGradient() {
    currentGradient = nil
    setNeedsDisplay()
  }

  override public func draw(_ rect: CGRect) {
    if let context = UIGraphicsGetCurrentContext(),
       let currentGradient = currentGradient ?? gradient {
      draw(currentGradient, context: context)
    } else {
      super.draw(rect)
    }
  }

  override public func tintColorDidChange() {
    super.tintColorDidChange()

    if automaticallyDims {
      setNeedsUpdateGradient()
    }
  }

  override public func didMoveToWindow() {
    super.didMoveToWindow()
    contentMode = .redraw
  }
}

// MARK: - IBGradientView

public final class IBGradientView: GradientView {
  public override var colors: [UIColor] {
    get {
      [startColor, endColor]
    }
    set {
      if newValue.count >= 2 {
        super.colors = Array(newValue.prefix(2))
        startColor = newValue[0]
        endColor = newValue[1]
      }
    }
  }

  @IBInspectable public var startColor: UIColor = .clear
  @IBInspectable public var endColor: UIColor = .clear

  public override var start: GradientOrigin {
    get {
      GradientOrigin(rawValue: startPosition) ?? super.start
    }
    set {
      super.start = newValue
      startPosition = newValue.rawValue
    }
  }

  @IBInspectable public var startPosition: Int = GradientOrigin.topCenter.rawValue

  public override var locations: [CGFloat] {
    get {
      [startLocation, endLocation]
    }
    set {
      if newValue.count >= 2 {
        super.locations = Array(newValue.prefix(2))
        startLocation = newValue[0]
        endLocation = newValue[1]
      }
    }
  }

  @IBInspectable public var startLocation: CGFloat = 0
  @IBInspectable public var endLocation: CGFloat = 1
}

// MARK: - GradientButton

public class GradientButton: UIButton, Gradable {
  public var colors: [UIColor] = [.clear, .clear] {
    didSet {
      setNeedsUpdateGradient()
    }
  }

  public var start: GradientOrigin = .topCenter {
    didSet {
      setNeedsDisplay()
    }
  }

  public var locations: [CGFloat] = [0, 1] {
    didSet {
      setNeedsUpdateGradient()
    }
  }

  private var currentGradient: CGGradient?

  private func setNeedsUpdateGradient() {
    currentGradient = nil
    setNeedsDisplay()
  }

  override public func draw(_ rect: CGRect) {
    if let context = UIGraphicsGetCurrentContext(),
       let currentGradient = currentGradient ?? gradient {
      draw(currentGradient, context: context)
    } else {
      super.draw(rect)
    }
  }

  override public func tintColorDidChange() {
    super.tintColorDidChange()

    if automaticallyDims {
      setNeedsUpdateGradient()
    }
  }

  override public func didMoveToWindow() {
    super.didMoveToWindow()
    contentMode = .redraw
  }
}

// MARK: - IBGradientButton

public final class IBGradientButton: GradientButton {
  public override var colors: [UIColor] {
    get {
      [startColor, endColor]
    }
    set {
      if newValue.count >= 2 {
        super.colors = Array(newValue.prefix(2))
        startColor = newValue[0]
        endColor = newValue[1]
      }
    }
  }

  @IBInspectable public var startColor: UIColor = .clear
  @IBInspectable public var endColor: UIColor = .clear

  public override var start: GradientOrigin {
    get {
      GradientOrigin(rawValue: startPosition) ?? super.start
    }
    set {
      super.start = newValue
      startPosition = newValue.rawValue
    }
  }

  @IBInspectable public var startPosition: Int = GradientOrigin.topCenter.rawValue

  public override var locations: [CGFloat] {
    get {
      [startLocation, endLocation]
    }
    set {
      if newValue.count >= 2 {
        super.locations = Array(newValue.prefix(2))
        startLocation = newValue[0]
        endLocation = newValue[1]
      }
    }
  }

  @IBInspectable public var startLocation: CGFloat = 0
  @IBInspectable public var endLocation: CGFloat = 1
}
