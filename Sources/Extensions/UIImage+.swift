import UIKit
import AVFoundation

extension UIImage {
  public static func create(
    color: UIColor,
    size: CGSize = .init(width: 1, height: 1),
    cornerRadius: CGFloat = 0
  ) -> UIImage {
    UIGraphicsImageRenderer(canvasSize: size).image { context in
      context.cgContext.setFillColor(color.cgColor)
      UIBezierPath(roundedRect: .init(origin: .zero, size: size), cornerRadius: cornerRadius).fill()
    }
  }

  public static func create(
    light: UIColor,
    dark: UIColor,
    size: CGSize = .init(width: 1, height: 1),
    cornerRadius: CGFloat = 0
  ) -> UIImage {
    .create(color: light, size: size, cornerRadius: cornerRadius) | .create(color: dark, size: size, cornerRadius: cornerRadius)
  }

  public func withAlpha(_ alpha: CGFloat) -> UIImage {
    UIGraphicsImageRenderer(canvasSize: size).image { context in
      draw(at: .zero, blendMode: .normal, alpha: alpha)
    }
  }

  @available(iOS 12.0, *)
  public var resolvedTraitImages: (light: UIImage, dark: UIImage)? {
    if let imageAsset = imageAsset {
      let light = imageAsset.image(with: .init(userInterfaceStyle: .light))
      let dark = imageAsset.image(with: .init(userInterfaceStyle: .dark))
      return (light, dark)
    }
    return nil
  }

  public var isQRCode: Bool {
    if let CIImage = CIImage(image: self) {
      let detector = CIDetector(
        ofType: CIDetectorTypeQRCode, context: nil,
        options: [CIDetectorAccuracy: CIDetectorAccuracyHigh]
      )
      let features = detector!.features(in: CIImage)
      if let first = features.first as? CIQRCodeFeature {
        return !(first.messageString?.isEmpty ?? true)
      }
    }
    return false
  }

  public var original: UIImage {
    withRenderingMode(.alwaysOriginal)
  }

  public var template: UIImage {
    withRenderingMode(.alwaysTemplate)
  }

  public var decompressed: UIImage {
    UIGraphicsImageRenderer(canvasSize: size).image { _ in
      draw(at: .zero)
    }
  }

  public func invertingColors() -> UIImage? {
    guard let ciImage = CIImage(image: self) ?? ciImage, let filter = CIFilter(name: "CIColorInvert") else { return nil }
    filter.setValue(ciImage, forKey: kCIInputImageKey)
    guard let outputImage = filter.outputImage else { return nil }
    return UIImage(ciImage: outputImage)
  }

  public func scaled(aspectFit boundingSize: CGSize) -> UIImage {
    guard size.width != 0 && size.height != 0 else { return self }
    guard boundingSize.width < size.width || boundingSize.height < size.height else { return self }
    let scaledRect = AVMakeRect(
      aspectRatio: size,
      insideRect: .init(origin: .zero, size: boundingSize)
    )
    return UIGraphicsImageRenderer(canvasSize: boundingSize).image { _ in
      draw(in: scaledRect)
    }
  }

  public func scaled(aspectFill boundingSize: CGSize) -> UIImage {
    guard size.width != 0 && size.height != 0 else { return self }
    guard boundingSize.width < size.width || boundingSize.height < size.height else { return self }
    let scale = max(boundingSize.width / size.width, boundingSize.height / size.height)
    let scaledRect = CGRect(
      origin: .zero,
      size: size.applying(.init(scaleX: scale, y: scale))
    )
    return UIGraphicsImageRenderer(canvasSize: boundingSize).image { _ in
      draw(in: scaledRect)
    }
  }

  public func cropped(to rect: CGRect) -> UIImage? {
    cgImage?.cropping(to: rect.applying(.init(scaleX: scale, y: scale)))
      .flatMap(UIImage.init(cgImage:))
  }

  public func rotated(byRadians radians: CGFloat) -> UIImage? {
    guard let cgImage = cgImage else { return nil }
    var rotatedSize = CGRect(origin: .zero, size: size)
      .applying(.init(rotationAngle: radians)).size
    // Trim off the extremely small float value to prevent core graphics from rounding it up
    rotatedSize = .init(
      width: floor(rotatedSize.width),
      height: floor(rotatedSize.height)
    )
    return UIGraphicsImageRenderer(canvasSize: rotatedSize).image { context in
      let cgContext = context.cgContext
      // Move origin to middle
      cgContext.translateBy(
        x: rotatedSize.width * 0.5,
        y: rotatedSize.height * 0.5
      )
      // Rotate around middle
      cgContext.rotate(by: radians)
      // Draw the image at its center
      cgContext.scaleBy(x: 1.0, y: -1.0)
      cgContext.draw(
        cgImage,
        in: .init(
          origin: .init(x: -size.width * 0.5, y: -size.height * 0.5),
          size: size
        )
      )
    }
  }

  public func oriented(to orientation: Orientation = .up) -> UIImage? {
    let rect = CGRect(origin: .zero, size: size)
    var bounds = rect
    var transform = CGAffineTransform.identity

    switch orientation {
    case .up:
      return oriented()
    case .upMirrored:
      transform = transform.translatedBy(x: rect.width, y: 0)
      transform = transform.scaledBy(x: -1, y: 1)
    case .down:
      transform = transform.translatedBy(x: rect.width, y: rect.height)
      transform = transform.rotated(by: .pi)
    case .downMirrored:
      transform = transform.translatedBy(x: 0, y: rect.height)
      transform = transform.scaledBy(x: 1, y: -1)
    case .left:
      bounds = .init(
        origin: bounds.origin,
        size: .init(width: bounds.height, height: bounds.width))
      transform = transform.translatedBy(x: 0, y: rect.width)
      transform = transform.rotated(by: .pi * 3 / 2)
    case .leftMirrored:
      bounds = .init(
        origin: bounds.origin,
        size: .init(width: bounds.height, height: bounds.width))
      transform = transform.translatedBy(x: rect.height, y: rect.width)
      transform = transform.scaledBy(x: -1, y: 1)
      transform = transform.rotated(by: .pi * 3 / 2)
    case .right:
      bounds = .init(
        origin: bounds.origin,
        size: .init(width: bounds.height, height: bounds.width))
      transform = transform.translatedBy(x: rect.height, y: 0)
      transform = transform.rotated(by: .pi / 2)
    case .rightMirrored:
      bounds = .init(
        origin: bounds.origin,
        size: .init(width: bounds.height, height: bounds.width))
      transform = transform.scaledBy(x: -1, y: 1)
      transform = transform.rotated(by: .pi / 2)
    @unknown default:
      return self
    }

    guard let cgImage = cgImage else { return nil }

    return UIGraphicsImageRenderer(canvasSize: bounds.size).image { context in
      let cgContext = context.cgContext

      switch orientation {
      case .left, .leftMirrored, .right, .rightMirrored:
        cgContext.scaleBy(x: -1, y: 1)
        cgContext.translateBy(x: -rect.height, y: 0)
      default:
        cgContext.scaleBy(x: 1, y: -1)
        cgContext.translateBy(x: 0, y: -rect.height)
      }

      cgContext.concatenate(transform)
      cgContext.draw(cgImage, in: rect)
    }
  }

  private func oriented() -> UIImage? {
    if imageOrientation == .up { return self }
    guard let cgImage = cgImage else { return nil }

    var transform: CGAffineTransform = .identity

    switch imageOrientation {
    case .down, .downMirrored:
      transform = transform.translatedBy(x: size.width, y: size.height)
      transform = transform.rotated(by: .pi)
    case .left, .leftMirrored:
      transform = transform.translatedBy(x: size.width, y: 0)
      transform = transform.rotated(by: .pi / 2)
    case .right, .rightMirrored:
      transform = transform.translatedBy(x: 0, y: size.height)
      transform = transform.rotated(by: .pi / -2)
    case .up, .upMirrored:
      break
    @unknown default:
      break
    }

    // Flip image one more time if needed to, this is to prevent flipped image
    switch imageOrientation {
    case .upMirrored, .downMirrored:
      transform = transform.translatedBy(x: size.width, y: 0)
      transform = transform.scaledBy(x: -1, y: 1)
    case .leftMirrored, .rightMirrored:
      transform = transform.translatedBy(x: size.height, y: 0)
      transform = transform.scaledBy(x: -1, y: 1)
    case .up, .down, .left, .right:
      break
    @unknown default:
      break
    }

    return UIGraphicsImageRenderer(canvasSize: size).image { context in
      let cgContext = context.cgContext
      cgContext.concatenate(transform)

      switch imageOrientation {
      case .left, .leftMirrored, .right, .rightMirrored:
        cgContext.draw(
          cgImage,
          in: CGRect(x: 0, y: 0, width: size.height, height: size.width)
        )
      default:
        cgContext.draw(cgImage, in: .init(origin: .zero, size: size))
      }
    }
  }
}

extension UIGraphicsImageRenderer {
  public convenience init(canvasSize size: CGSize) {
    let format: UIGraphicsImageRendererFormat
    if #available(iOS 11.0, *) {
      format = .preferred()
    } else {
      format = .default()
    }
    self.init(size: size, format: format)
  }
}

extension UIImage.Orientation {
  public init(_ cgOrientation: CGImagePropertyOrientation) {
    switch cgOrientation {
    case .up: self = .up
    case .upMirrored: self = .upMirrored
    case .down: self = .down
    case .downMirrored: self = .downMirrored
    case .left: self = .left
    case .leftMirrored: self = .leftMirrored
    case .right: self = .right
    case .rightMirrored: self = .rightMirrored
    }
  }
}
