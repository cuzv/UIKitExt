import UIKit

public struct UIEdgeOffsets {
    public var top: CGFloat
    public var left: CGFloat
    public var bottom: CGFloat
    public var right: CGFloat

    public init(top: CGFloat = 0, left: CGFloat = 0, bottom: CGFloat = 0, right: CGFloat = 0) {
        self.top = top
        self.left = left
        self.bottom = bottom
        self.right = right
    }

    public static let zero: UIEdgeOffsets = .init()
}

extension UIEdgeOffsets: Equatable {}
extension UIEdgeOffsets: Codable {}

extension UIEdgeOffsets {
    public var insetValue: UIEdgeInsets {
        UIEdgeInsets(top: -top, left: -left, bottom: -bottom, right: -right)
    }

    public init(horizontalOffset: CGPoint, verticalOffset: CGPoint) {
        self.init(top: verticalOffset.x, left: horizontalOffset.x, bottom: verticalOffset.y, right: horizontalOffset.y)
    }

    public init(rect: CGRect) {
        self.init(top: rect.origin.x, left: rect.origin.y, bottom: rect.size.width, right: rect.size.height)
    }

    public var rectValue: CGRect {
        CGRect(x: top, y: left, width: bottom, height: right)
    }
}

extension CGRect {
    public var offsetValue: UIEdgeOffsets {
        UIEdgeOffsets(rect: self)
    }
}
