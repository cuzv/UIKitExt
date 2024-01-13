import UIKit

public struct CoreImageFilter {
  let name: Name
  let parameters: [ParameterKey: Any]

  public init(
    name: Name,
    parameters: [ParameterKey: Any]
  ) {
    self.name = name
    self.parameters = parameters
  }

  public var parametersDictionaryValue: [String: Any] {
    Dictionary(uniqueKeysWithValues: parameters.map {
      ($0.key.rawValue, $0.value)
    })
  }
}

public extension CoreImageFilter {
  enum Name {
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

    public enum TileEffect: String {
      case clamp = "CIAffineClamp"
    }

    public enum GeometryAdjustment: String {
      case crop = "CICrop"
    }

    case blur(Blur)
    case tileEffect(TileEffect)
    case geometryAdjustment(GeometryAdjustment)

    var stringValue: String {
      switch self {
      case let .blur(value):
        value.rawValue
      case let .tileEffect(value):
        value.rawValue
      case let .geometryAdjustment(value):
        value.rawValue
      }
    }
  }
}

public extension CoreImageFilter {
  /// https://developer.apple.com/library/archive/documentation/GraphicsImaging/Reference/CoreImageFilterReference
  enum ParameterKey: String {
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

    /// On iOS, an NSValue object whose attribute type is CIAttributeTypeTransform.
    case inputTransform

    /// A CIVector object whose attribute type is CIAttributeTypeRectangle and whose display name is Rectangle.
    /// Default value: [0 0 300 300]
    case inputRectangle
  }
}

// MARK: -

public extension UIImage {
  func applying(_ filters: CoreImageFilter) -> UIImage {
    applying(contentsOf: [filters])
  }

  func applying(contentsOf filters: [CoreImageFilter]) -> UIImage {
    if let input = CIImage(image: self) {
      let output = input.applying(contentsOf: filters)
      if let cgImage = CIContext().createCGImage(output, from: input.extent) {
        return UIImage(
          cgImage: cgImage,
          scale: scale,
          orientation: imageOrientation
        )
      }
    }
    return self
  }

  func blur(radius: CGFloat) -> UIImage {
    applying(contentsOf: [
      .init(
        name: .tileEffect(.clamp),
        parameters: [.inputTransform: CGAffineTransform.identity]
      ),
      .init(
        name: .blur(.gaussian),
        parameters: [.inputRadius: radius]
      ),
    ])
  }
}

public extension CIImage {
  func applying(contentsOf filters: [CoreImageFilter]) -> CIImage {
    var output = self
    filters.forEach {
      output = output.applyingFilter(
        $0.name.stringValue,
        parameters: $0.parametersDictionaryValue
      )
    }
    return output
  }
}
