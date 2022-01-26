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

    public init(
      color: UIColor = .black,
      alpha: Float = 0.5,
      x: CGFloat = 0,
      y: CGFloat = 0,
      blur: CGFloat = 8,
      spread: CGFloat = 0
    ) {
      self.color = color
      self.alpha = alpha
      self.x = x
      self.y = y
      self.blur = blur
      self.spread = spread
    }
  }

  /// Invoke when the bounds is determined if `shadow.spread != 0`.
  public func applySketchShadow(_ shadow: SketchShadow) {
    shadowColor = shadow.color.cgColor
    shadowOpacity = shadow.alpha
    shadowOffset = CGSize(width: shadow.x, height: shadow.y)
    shadowRadius = shadow.blur / 2.0
    shadowPath = (0 == shadow.spread) ? nil : UIBezierPath(
      rect: bounds.insetBy(dx: -shadow.spread, dy: -shadow.spread)
    ).cgPath
  }
}
