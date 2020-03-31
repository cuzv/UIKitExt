import UIKit

private struct _UIButtonAssociatedKey {
    public static var layoutAxisAlignment: Void?
    public static var contentSpacing: Void?
    public static var contentOffset: Void?
}

/// FYI: https://noahgilmore.com/blog/uibutton-padding/
/// FYI: http://shinancao.cn/2016/12/15/iOS-UIButton-EdgeInsets/
extension UIButton {
    public enum LayoutAxisAlignment: Int {
        case horizontalConventional     = 1
        case horizontalUnconventional   = 2
        case verticalConventional       = 4
        case verticalUnconventional     = 8
    }

    public var layoutAxisAlignment: LayoutAxisAlignment {
        get {
            objc_getAssociatedObject(self, &_UIButtonAssociatedKey.layoutAxisAlignment) as? LayoutAxisAlignment ?? .horizontalConventional
        }
        set {
            objc_setAssociatedObject(self, &_UIButtonAssociatedKey.layoutAxisAlignment, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            layoutDidChange()
        }
    }

    /// - horizontalConventional     = 1
    /// - horizontalUnconventional   = 2
    /// - verticalConventional       = 4
    /// - verticalUnconventional     = 8
    @IBInspectable public var layoutAxisAlignmentRawValue: Int {
        get { layoutAxisAlignment.rawValue }
        set { layoutAxisAlignment = LayoutAxisAlignment(rawValue: newValue) ?? .horizontalConventional }
    }

    @IBInspectable public var contentSpacing: CGFloat {
        get {
            objc_getAssociatedObject(self, &_UIButtonAssociatedKey.contentSpacing) as? CGFloat ?? 0.0
        }
        set {
            objc_setAssociatedObject(self, &_UIButtonAssociatedKey.contentSpacing, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            layoutDidChange()
        }
    }

    public var contentOffset: UIEdgeOffsets {
        get {
            objc_getAssociatedObject(self, &_UIButtonAssociatedKey.contentOffset) as? UIEdgeOffsets ?? .zero
        }
        set {
            objc_setAssociatedObject(self, &_UIButtonAssociatedKey.contentOffset, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            layoutDidChange()
        }
    }

    @IBInspectable public var contentOffsetRectValue: CGRect {
        get { contentOffset.rectValue }
        set { contentOffset = newValue.offsetValue }
    }

    public func layoutDidChange() {
        guard let font = titleLabel?.font, let titleSize = currentTitle?.size(withAttributes: [.font: font]) else { return }
        let imageSize = imageView?.image?.size ?? .zero
        let halfSpacing = contentSpacing * 0.5
        var contentOffset = self.contentOffset

        let isR2LLayout: Bool
        if #available(iOS 10.0, *) {
            isR2LLayout = effectiveUserInterfaceLayoutDirection == .rightToLeft
        } else {
            isR2LLayout = UIApplication.shared.userInterfaceLayoutDirection == .rightToLeft
        }

        if isR2LLayout {
            let left = contentOffset.left
            contentOffset.left = contentOffset.right
            contentOffset.right = left
        }
        let factor: CGFloat = isR2LLayout ? -1 : 1

        switch layoutAxisAlignment {
        case .horizontalConventional:
            // H: |-(padding)-[image]-(spacing)-[title]-(padding)-|
            imageEdgeInsets = UIEdgeInsets(top: 0, left: -halfSpacing * factor, bottom: 0, right: halfSpacing * factor)
            titleEdgeInsets = UIEdgeInsets(top: 0, left: halfSpacing * factor, bottom: 0, right: -halfSpacing * factor)
            contentEdgeInsets = UIEdgeInsets(top: contentOffset.top, left: halfSpacing + contentOffset.left, bottom: contentOffset.bottom, right: halfSpacing + contentOffset.right)
        case .horizontalUnconventional:
            // H: |-(padding)-[title]-(spacing)-[image]-(padding)-|
            let imageWidth = imageSize.width
            let titleWidth = titleSize.width

            imageEdgeInsets = UIEdgeInsets(top: 0, left: (titleWidth + halfSpacing) * factor, bottom: 0, right: -(titleWidth + halfSpacing) * factor)
            titleEdgeInsets = UIEdgeInsets(top: 0, left: -(imageWidth + halfSpacing) * factor, bottom: 0, right: (imageWidth + halfSpacing) * factor)
            contentEdgeInsets = UIEdgeInsets(top: contentOffset.top, left: halfSpacing + contentOffset.left, bottom: contentOffset.bottom, right: halfSpacing + contentOffset.right)
        case .verticalConventional:
            // V: |-(padding)-[image]-(spacing)-[title]-(padding)-|
            let imageWidth = imageSize.width
            let titleWidth = titleSize.width
            let imageHeight = imageSize.height
            let titleHeight = titleSize.height

            imageEdgeInsets = UIEdgeInsets(top: -(titleHeight * 0.5 + halfSpacing), left: titleWidth * 0.5 * factor, bottom: titleHeight * 0.5 + halfSpacing, right: -(titleWidth * 0.5) * factor)
            titleEdgeInsets = UIEdgeInsets(top: imageHeight * 0.5 + halfSpacing, left: -(imageWidth * 0.5) * factor, bottom: -(imageHeight * 0.5 + halfSpacing), right: imageWidth * 0.5 * factor)

            let padding = min(imageWidth, titleWidth) * 0.5
            let margin = min(imageHeight, titleHeight) * 0.5
            contentEdgeInsets = UIEdgeInsets(top: contentOffset.top + margin + halfSpacing, left: contentOffset.left - padding, bottom: contentOffset.bottom + margin + halfSpacing, right: contentOffset.right - padding)
        case .verticalUnconventional:
            // V: |-(padding)-[title]-(spacing)-[image]-(padding)-|
            let imageWidth = imageSize.width
            let titleWidth = titleSize.width
            let imageHeight = imageSize.height
            let titleHeight = titleSize.height

            imageEdgeInsets = UIEdgeInsets(top: (titleHeight * 0.5 + halfSpacing), left: titleWidth * 0.5 * factor, bottom: -((titleHeight * 0.5 + halfSpacing)), right: -(titleWidth * 0.5) * factor)
            titleEdgeInsets = UIEdgeInsets(top: -(imageHeight * 0.5 + halfSpacing), left: -(imageWidth * 0.5) * factor, bottom: imageHeight * 0.5 + halfSpacing, right: imageWidth * 0.5 * factor)

            let padding = min(imageWidth, titleWidth) * 0.5
            let margin = min(imageHeight, titleHeight) * 0.5
            contentEdgeInsets = UIEdgeInsets(top: contentOffset.top + margin + halfSpacing, left: contentOffset.left - padding, bottom: contentOffset.bottom + margin + halfSpacing, right: contentOffset.right - padding)
        }
    }
}
