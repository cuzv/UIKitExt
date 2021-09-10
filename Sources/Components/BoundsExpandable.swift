public protocol BoundsExpandable {
  var boundsMargin: UIEdgeInsets { get }
}

import UIKit
import CoreGraphics

extension BoundsExpandable where Self: UIView {
  public var overrideIntrinsicContentSize: CGSize {
    let size = sizeThatFits(bounds.size)
    let width = size.width + boundsMargin.left + boundsMargin.right
    let height = size.height + boundsMargin.top + boundsMargin.bottom
    return CGSize(width: width, height: height)
  }

  public func overrideDrawRect(for rect: CGRect) -> CGRect {
    rect.inset(by: boundsMargin.reversed)
  }
}

/// The following lines show you how you use this protocol in you own project.

open class BoundsExpandButton: UIButton, BoundsExpandable {
  @IBInspectable open var horizontalBoundsMargin: CGPoint = .zero
  @IBInspectable open var verticalBoundsMargin: CGPoint = .zero

  open var boundsMargin: UIEdgeInsets {
    .init(
      top: verticalBoundsMargin.x,
      left: horizontalBoundsMargin.x,
      bottom: verticalBoundsMargin.y,
      right: horizontalBoundsMargin.y
    )
  }

  override open var intrinsicContentSize: CGSize {
    overrideIntrinsicContentSize
  }

  override open func draw(_ rect: CGRect) {
    super.draw(overrideDrawRect(for: rect))
  }
}

open class BoundsExpandLabel: UILabel, BoundsExpandable {
  @IBInspectable open var horizontalBoundsMargin: CGPoint = .zero
  @IBInspectable open var verticalBoundsMargin: CGPoint = .zero

  open var boundsMargin: UIEdgeInsets {
    .init(
      top: verticalBoundsMargin.x,
      left: horizontalBoundsMargin.x,
      bottom: verticalBoundsMargin.y,
      right: horizontalBoundsMargin.y
    )
  }

  override open var intrinsicContentSize: CGSize {
    overrideIntrinsicContentSize
  }

  override open func drawText(in rect: CGRect) {
    super.drawText(in: overrideDrawRect(for: rect))
  }
}
