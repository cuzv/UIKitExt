import UIKit
import CoreGraphics

// MARK: - Snapshot

extension UIView {
    @available(iOS 10.0, *)
    public func snapshot(cropping: CGRect? = nil) -> UIImage {
        let rect = cropping ?? bounds
        let renderer = UIGraphicsImageRenderer(bounds: rect)
        return renderer.image { context in
            layer.render(in: context.cgContext)
        }
    }

    /*
    /// AnySubclassOfUIView().snapshot
    /// UIScrollView().snapshot
    /// UITableView().snapshot
    public func snapshot() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(bounds.size, isOpaque, 0)
        defer { UIGraphicsEndImageContext() }
        if let context = UIGraphicsGetCurrentContext() {
            if let backgroundColor = backgroundColor {
                context.setFillColor(backgroundColor.cgColor)
                context.fill(bounds)
            }

            if let scrollView = self as? UIScrollView {
                let previousFrame = frame
                frame = CGRect(origin: frame.origin, size: scrollView.contentSize)
                layer.render(in: context)
                frame = previousFrame
                return UIGraphicsGetImageFromCurrentImageContext()
            } else {
                layer.render(in: context)
                return UIGraphicsGetImageFromCurrentImageContext()
            }
        }
        return nil
    }
 */
}

// MRARK: - Layer Property

extension UIView {
    @IBInspectable public var opacity: Float {
        get { return layer.opacity }
        set { layer.opacity = newValue }
    }

    @IBInspectable public var masksToBounds: Bool {
        get { return layer.masksToBounds }
        set { layer.masksToBounds = newValue }
    }

    @IBInspectable public var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set { layer.cornerRadius = newValue }
    }

    @available(iOS 11.0, *)
    public var maskedCorners: CACornerMask {
        get { return layer.maskedCorners }
        set { layer.maskedCorners = newValue }
    }

    /// CACornerMask.RawValue
    /// - layerMinXMinYCorner: 1
    /// - layerMaxXMinYCorner: 2
    /// - layerMinXMaxYCorner: 4
    /// - layerMaxXMaxYCorner: 8
    @available(iOS 11.0, *)
    @IBInspectable public var maskedCornersRawValue: UInt {
        get { return layer.maskedCorners.rawValue }
        set { layer.maskedCorners = CACornerMask(rawValue: newValue) }
    }

    @IBInspectable public var borderWidth: CGFloat {
        get { return layer.borderWidth }
        set { layer.borderWidth = newValue }
    }

    @IBInspectable public var borderColor: UIColor? {
        get { return layer.borderColor.map(UIColor.init) }
        set { layer.borderColor = newValue?.cgColor }
    }

    @IBInspectable public var shadowOpacity: Float {
        get { return layer.shadowOpacity }
        set { layer.shadowOpacity = newValue }
    }

    @IBInspectable public var shadowRadius: CGFloat {
        get { return layer.shadowRadius }
        set { layer.shadowRadius = newValue }
    }

    @IBInspectable public var shadowOffset: CGSize {
        get { return layer.shadowOffset }
        set { layer.shadowOffset = newValue }
    }

    @IBInspectable public var shadowColor: UIColor? {
        get { return layer.shadowColor.map(UIColor.init) }
        set { layer.shadowColor = newValue?.cgColor }
    }

    @IBInspectable public var isOpaqueEnabled: Bool {
        get { return layer.isOpaque }
        set { layer.isOpaque = newValue }
    }

    @IBInspectable public var shouldRasterize: Bool {
        get { return layer.shouldRasterize }
        set { layer.shouldRasterize = newValue }
    }
}
