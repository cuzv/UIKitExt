public protocol HitTestSlop {
  var hitTestSlop: UIEdgeInsets { get }
}

import UIKit
import CoreGraphics

extension HitTestSlop where Self: UIView {
  /// Call when override `point(inside:with:)`
  public func judgeWhetherInclude(point: CGPoint, with event: UIEvent?) -> Bool {
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

open class HitTestSlopView: UIView, HitTestSlop {
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

  open override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
    judgeWhetherInclude(point: point, with: event)
  }
}

open class HitTestSlopButton: UIButton, HitTestSlop {
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

  open override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
    judgeWhetherInclude(point: point, with: event)
  }
}

open class HitTestSlopImageView: UIImageView, HitTestSlop {
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

  open override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
    judgeWhetherInclude(point: point, with: event)
  }
}
