import CoreGraphics
import QuartzCore
import UIKit

// MARK: - SketchShadow
// https://stackoverflow.com/questions/34269399/how-to-control-shadow-spread-and-blur

extension CALayer {
  public struct SketchShadow {
    public let color: UIColor
    public let alpha: Float
    public let x: CGFloat
    public let y: CGFloat
    public let blur: CGFloat
    public let spread: CGFloat
  }

  /// Invoke when the bounds is determined.
  public func apply(_ shadow: SketchShadow) {
    shadowColor = shadow.color.cgColor
    shadowOpacity = shadow.alpha
    shadowOffset = CGSize(width: shadow.x, height: shadow.y)
    shadowRadius = shadow.blur / 2.0
    shadowPath = UIBezierPath(rect: bounds.insetBy(dx: -shadow.spread, dy: -shadow.spread)).cgPath
  }
}
