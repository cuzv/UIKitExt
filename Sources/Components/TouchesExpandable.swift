public protocol TouchesExpandable {
  var touchesMargin: UIEdgeInsets { get }
}

import UIKit
import CoreGraphics

extension TouchesExpandable where Self: UIView {
  /// Call when override `point(inside:with:)`
  public func judgeWhetherInsideInclude(point: CGPoint, with event: UIEvent?) -> Bool {
    if !isUserInteractionEnabled || alpha == 0 || isHidden {
      return false
    }

    var hitFrame = bounds.inset(by: touchesMargin.reversed)
    hitFrame.size.width = max(hitFrame.size.width, 0)
    hitFrame.size.height = max(hitFrame.size.height, 0)
    return hitFrame.contains(point)
  }
}

/// The following lines show you how you use this protocol in you own project.

open class TouchesExpandView: UIView, TouchesExpandable {
  @IBInspectable open var horizontalTouchesMargin: CGPoint = .zero
  @IBInspectable open var verticalTouchesMargin: CGPoint = .zero

  open var touchesMargin: UIEdgeInsets {
    .init(
      top: verticalTouchesMargin.x,
      left: horizontalTouchesMargin.x,
      bottom: verticalTouchesMargin.y,
      right: horizontalTouchesMargin.y
    )
  }

  open override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
    judgeWhetherInsideInclude(point: point, with: event)
  }
}

open class TouchesExpandButton: UIButton, TouchesExpandable {
  @IBInspectable open var horizontalTouchesMargin: CGPoint = .zero
  @IBInspectable open var verticalTouchesMargin: CGPoint = .zero

  open var touchesMargin: UIEdgeInsets {
    .init(
      top: verticalTouchesMargin.x,
      left: horizontalTouchesMargin.x,
      bottom: verticalTouchesMargin.y,
      right: horizontalTouchesMargin.y
    )
  }

  open override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
    judgeWhetherInsideInclude(point: point, with: event)
  }
}

open class TouchesExpandImageView: UIImageView, TouchesExpandable {
  @IBInspectable open var horizontalTouchesMargin: CGPoint = .zero
  @IBInspectable open var verticalTouchesMargin: CGPoint = .zero

  open var touchesMargin: UIEdgeInsets {
    .init(
      top: verticalTouchesMargin.x,
      left: horizontalTouchesMargin.x,
      bottom: verticalTouchesMargin.y,
      right: horizontalTouchesMargin.y
    )
  }

  open override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
    judgeWhetherInsideInclude(point: point, with: event)
  }
}
