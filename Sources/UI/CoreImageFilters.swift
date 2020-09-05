import UIKit

public enum CoreImageFilter {
    public enum Blur: String {
        case box = "CIBoxBlur"
        case disc = "CIDiscBlur"
        case gaussian = "CIGaussianBlur"
        case maskedVariable = "CIMaskedVariableBlur"
        case median = "CIMedianFilter"
        case motion = "CIMotionBlur"
        case noiseReduction = "CINoiseReduction"
        case zoom = "CIZoomBlur"
    }

    case blur(Blur)

    var stringValue: String {
        switch self {
        case let .blur(value):
            return value.rawValue
        }
    }
}

/// https://developer.apple.com/library/archive/documentation/GraphicsImaging/Reference/CoreImageFilterReference
public enum CoreImageFilterKey: String {
    /// An NSNumber object whose attribute type is CIAttributeTypeDistance and whose display name is Radius.
    /// Default value: 10.00
    case inputRadius

    /// A CIImage object whose display name is Mask.
    case inputMask

    /// An NSNumber object whose attribute type is CIAttributeTypeAngle and whose display name is Angle.
    /// Default value: 0.00
    case inputAngle

    /// An NSNumber object whose attribute type is CIAttributeTypeScalar and whose display name is Noise Level.
    /// Default value: 0.02
    case inputNoiseLevel

    /// An NSNumber object whose attribute type is CIAttributeTypeScalar and whose display name is Sharpness.
    /// Default value: 0.40
    case inputSharpness

    /// A CIVector object whose attribute type is CIAttributeTypePosition and whose display name is Center.
    /// Default value: [150 150]
    case inputCenter

    /// An NSNumber object whose attribute type is CIAttributeTypeDistance and whose display name is Amount.
    /// Default value: 20.00
    case inputAmount
}

extension UIImage {
    public func applying(filter: CoreImageFilter, parameters: [CoreImageFilterKey: Any]) -> UIImage {
        if let filter = CIFilter(name: filter.stringValue), let ciImage = CIImage(image: self) {
            filter.setValue(ciImage, forKey: kCIInputImageKey)

            for (key, value) in parameters {
                filter.setValue(value, forKey: key.rawValue)
            }

            if let output = filter.outputImage {
                let context = CIContext()
                if let image = context.createCGImage(output, from: .init(origin: .zero, size: size)) {
                    return UIImage(cgImage: image)
                }
            }
        }
        return self
    }
}
