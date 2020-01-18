public protocol BoundsExpandable {
    var boundsOffset: UIEdgeOffsets { get }
}

import UIKit
import CoreGraphics

extension BoundsExpandable where Self: UIView {
    public var overrideIntrinsicContentSize: CGSize {
        let size = sizeThatFits(CGSize(width: bounds.size.width, height: bounds.size.height))
        let width = size.width + boundsOffset.left + boundsOffset.right
        let height = size.height + boundsOffset.top + boundsOffset.bottom
        return CGSize(width: width, height: height)
    }

    public func overrideDrawRect(for rect: CGRect) -> CGRect {
        rect.inset(by: boundsOffset.insetValue)
    }
}

/// The following lines show you how you use this protocol in you own project.

open class BoundsExpandButton: UIButton, BoundsExpandable {
    @IBInspectable open var horizontalBoundsOffset: CGPoint = .zero
    @IBInspectable open var verticalBoundsOffset: CGPoint = .zero

    open var boundsOffset: UIEdgeOffsets {
        UIEdgeOffsets(horizontalOffset: horizontalBoundsOffset, verticalOffset: verticalBoundsOffset)
    }

    override open var intrinsicContentSize: CGSize {
        overrideIntrinsicContentSize
    }

    override open func draw(_ rect: CGRect) {
        super.draw(overrideDrawRect(for: rect))
    }
}

open class BoundsExpandLabel: UILabel, BoundsExpandable {
    @IBInspectable open var horizontalBoundsOffset: CGPoint = .zero
    @IBInspectable open var verticalBoundsOffset: CGPoint = .zero

    open var boundsOffset: UIEdgeOffsets {
        UIEdgeOffsets(horizontalOffset: horizontalBoundsOffset, verticalOffset: verticalBoundsOffset)
    }

    override open var intrinsicContentSize: CGSize {
        overrideIntrinsicContentSize
    }

    override open func drawText(in rect: CGRect) {
        super.drawText(in: overrideDrawRect(for: rect))
    }
}
