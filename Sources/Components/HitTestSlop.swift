public protocol HitTestSlop: AnyObject {
  var hitTestSlop: UIEdgeInsets { get }
}

public protocol HitTestSlopSetProvider: HitTestSlop {
  var horizontalHitTestSlop: CGPoint { get set }
  var verticalHitTestSlop: CGPoint { get set }
}

public extension HitTestSlopSetProvider {
  @discardableResult
  func hitTestSlop(_ slop: UIEdgeInsets) -> Self {
    horizontalHitTestSlop = .init(x: slop.left, y: slop.right)
    verticalHitTestSlop = .init(x: slop.top, y: slop.bottom)
    return self
  }
}

import CoreGraphics
import UIKit

public extension HitTestSlop where Self: UIView {
  /// Call when override `point(inside:with:)`
  func judgeWhetherInclude(point: CGPoint, with event: UIEvent?) -> Bool {
    if !isUserInteractionEnabled || alpha == 0 || isHidden {
      return false
    }

    var hitFrame = bounds.inset(by: hitTestSlop.reversed)
    hitFrame.size.width = max(hitFrame.size.width, 0)
    hitFrame.size.height = max(hitFrame.size.height, 0)
    return hitFrame.contains(point)
  }
}

/// The following lines show you how you use this protocol in you own project.

open class HitTestSlopView: UIView, HitTestSlopSetProvider {
  @IBInspectable open var horizontalHitTestSlop: CGPoint = .zero
  @IBInspectable open var verticalHitTestSlop: CGPoint = .zero

  open var hitTestSlop: UIEdgeInsets {
    .init(
      top: verticalHitTestSlop.x,
      left: horizontalHitTestSlop.x,
      bottom: verticalHitTestSlop.y,
      right: horizontalHitTestSlop.y
    )
  }

  override open func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
    judgeWhetherInclude(point: point, with: event)
  }
}

open class HitTestSlopButton: UIButton, HitTestSlopSetProvider {
  @IBInspectable open var horizontalHitTestSlop: CGPoint = .zero
  @IBInspectable open var verticalHitTestSlop: CGPoint = .zero

  open var hitTestSlop: UIEdgeInsets {
    .init(
      top: verticalHitTestSlop.x,
      left: horizontalHitTestSlop.x,
      bottom: verticalHitTestSlop.y,
      right: horizontalHitTestSlop.y
    )
  }

  override open func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
    judgeWhetherInclude(point: point, with: event)
  }
}

open class HitTestSlopImageView: UIImageView, HitTestSlopSetProvider {
  @IBInspectable open var horizontalHitTestSlop: CGPoint = .zero
  @IBInspectable open var verticalHitTestSlop: CGPoint = .zero

  open var hitTestSlop: UIEdgeInsets {
    .init(
      top: verticalHitTestSlop.x,
      left: horizontalHitTestSlop.x,
      bottom: verticalHitTestSlop.y,
      right: horizontalHitTestSlop.y
    )
  }

  override open func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
    judgeWhetherInclude(point: point, with: event)
  }
}
