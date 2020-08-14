import UIKit
#if canImport(Infrastructure)
import Infrastructure
#else
extension CGRect {
    public init(center: CGPoint, size: CGSize) {
        let translation = size.applying(.init(scaleX: -0.5, y: -0.5))
        let origin = center.applying(.init(translationX: translation.width, y: translation.height))
        self.init(origin: origin, size: size)
    }

    @inline(__always)
    public var center: CGPoint {
        .init(x: midX, y: midY)
    }

    public func scaleAspectFit(to boundingRect: CGRect) -> CGRect {
        let scale = min(boundingRect.width / width, boundingRect.height / height)
        let targetSize = size.applying(.init(scaleX: scale, y: scale))
        return .init(center: boundingRect.center, size: targetSize)
    }

    public func scaleAspectFill(to boundingRect: CGRect) -> CGRect {
        let scale = max(boundingRect.width / width, boundingRect.height / height)
        let targetSize = size.applying(.init(scaleX: scale, y: scale))
        return .init(center: boundingRect.center, size: targetSize)
    }
}

#endif

extension UIImage {
    public func scaleAspectFit(to boundingSize: CGSize) -> UIImage {
        guard boundingSize.width < size.width || boundingSize.height < size.height else { return self }

        let scaledRect = CGRect(origin: .zero, size: size).scaleAspectFit(to: .init(origin: .zero, size: boundingSize))
        let result: UIImage

        if #available(iOS 10.0, *) {
            let format = UIGraphicsImageRendererFormat.default()
            format.opaque = false
            let renderer = UIGraphicsImageRenderer(size: boundingSize, format: format)
            result = renderer.image { _ in
                draw(in: scaledRect)
            }
        } else {
            UIGraphicsBeginImageContextWithOptions(boundingSize, false, 0)
            draw(in: scaledRect)
            result = UIGraphicsGetImageFromCurrentImageContext() ?? self
            UIGraphicsEndImageContext()
        }

        return result
    }

    public func scaleAspectFill(to boundingSize: CGSize) -> UIImage {
        guard boundingSize.width < size.width || boundingSize.height < size.height else { return self }

        let scaledRect = CGRect(origin: .zero, size: size).scaleAspectFill(to: .init(origin: .zero, size: boundingSize))
        let result: UIImage

        if #available(iOS 10.0, *) {
            let format = UIGraphicsImageRendererFormat.default()
            format.opaque = false
            let renderer = UIGraphicsImageRenderer(size: boundingSize, format: format)
            result = renderer.image { _ in
                draw(in: scaledRect)
            }
        } else {
            UIGraphicsBeginImageContextWithOptions(boundingSize, false, 0)
            draw(in: scaledRect)
            result = UIGraphicsGetImageFromCurrentImageContext() ?? self
            UIGraphicsEndImageContext()
        }

        return result
    }
}
