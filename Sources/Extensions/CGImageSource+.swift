import Foundation
import ImageIO
import MobileCoreServices

public extension CGImageSource {
  enum FramePixelConstraint {
    case maxPixelSize(Double)
    case maxPixelAreaSize(Double) // mainstream iOS device texture limits: 4096 * 4096
  }

  func frames(
    constraint: FramePixelConstraint
  ) -> [(CGImage, CGImagePropertyOrientation, TimeInterval)] {
    let count = CGImageSourceGetCount(self)
    return (0 ..< count).compactMap { frame(at: $0, constraint: constraint) }
  }

  func frame(
    at index: Int,
    constraint: FramePixelConstraint
  ) -> (CGImage, CGImagePropertyOrientation, TimeInterval)? {
    let type = CGImageSourceGetType(self)
    let properties = CGImageSourceCopyPropertiesAtIndex(self, index, nil) as? [CFString: Any]

    func frameDuration() -> TimeInterval {
      if let type, let properties {
        if type == kUTTypePNG {
          if let apngInfo = properties[kCGImagePropertyPNGDictionary] as? [CFString: Any],
             let duration = apngInfo[kCGImagePropertyAPNGUnclampedDelayTime] as? TimeInterval ?? apngInfo[kCGImagePropertyAPNGDelayTime] as? TimeInterval
          {
            return duration
          }
        } else if type == kUTTypeGIF {
          if let gifInfo = properties[kCGImagePropertyGIFDictionary] as? [CFString: Any],
             let duration = gifInfo[kCGImagePropertyGIFUnclampedDelayTime] as? TimeInterval ?? gifInfo[kCGImagePropertyGIFDelayTime] as? TimeInterval
          {
            return duration
          }
        }
      }

      return 0.1
    }

    func frameOrientation() -> CGImagePropertyOrientation {
      if let value = properties?[kCGImagePropertyOrientation] as? CGImagePropertyOrientation.RawValue, let result = CGImagePropertyOrientation(rawValue: value) {
        return result
      }
      return .up
    }

    switch constraint {
    case let .maxPixelSize(size):
      let cfOptions: [CFString: Any] = [
        kCGImageSourceCreateThumbnailFromImageIfAbsent: true,
        kCGImageSourceCreateThumbnailWithTransform: true,
        kCGImageSourceThumbnailMaxPixelSize: size,
      ]
      if let cgImage = CGImageSourceCreateThumbnailAtIndex(self, index, cfOptions as CFDictionary) {
        return (cgImage, frameOrientation(), frameDuration())
      }
    case let .maxPixelAreaSize(size):
      if let properties,
         let pixelWidth = properties[kCGImagePropertyPixelWidth] as? Double,
         let pixelHeight = properties[kCGImagePropertyPixelHeight] as? Double
      {
        let pixels = pixelWidth * pixelHeight
        if pixels > size {
          let scale = pixels / size
          let ratio = sqrt(Double(scale))
          let maxPixelSize = floor(Double(max(pixelWidth, pixelHeight)) / ratio)
          let cfOptions: [CFString: Any] = [
            kCGImageSourceCreateThumbnailFromImageIfAbsent: true,
            kCGImageSourceCreateThumbnailWithTransform: true,
            kCGImageSourceThumbnailMaxPixelSize: maxPixelSize,
          ]
          if let cgImage = CGImageSourceCreateThumbnailAtIndex(self, index, cfOptions as CFDictionary) {
            return (cgImage, frameOrientation(), frameDuration())
          }
        }
      }

      if let cgImage = CGImageSourceCreateImageAtIndex(self, index, nil) {
        return (cgImage, frameOrientation(), frameDuration())
      }
    }

    return nil
  }
}
