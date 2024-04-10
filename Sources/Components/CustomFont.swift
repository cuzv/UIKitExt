import CoreGraphics
import CoreText
import UIKit

public enum FontError: Error {
  case failedToRegisterFont
}

public struct CustomFont {
  public let name: String

  public init(
    bundle: Bundle,
    named name: String,
    extension ext: String
  ) {
    self.name = name
    do {
      try registerFont(
        bundle: bundle,
        named: name,
        extension: ext
      )
    } catch {
      let reason = error.localizedDescription
      fatalError("Failed to register font: \(reason)")
    }
  }

  private func registerFont(
    bundle: Bundle,
    named name: String,
    extension ext: String
  ) throws {
    guard
      let url = bundle.url(forResource: name, withExtension: ext),
      let provider = CGDataProvider(url: url as CFURL),
      let font = CGFont(provider),
      CTFontManagerRegisterGraphicsFont(font, nil)
    else {
      throw FontError.failedToRegisterFont
    }
  }
}
