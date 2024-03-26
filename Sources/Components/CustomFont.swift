import CoreGraphics
import CoreText
import UIKit

public enum FontError: Error {
  case failedToRegisterFont
}

public struct CustomFont {
  public let name: String

  public init(named name: String, extension ext: String) {
    self.name = name
    do {
      try registerFont(named: name, extension: ext)
    } catch {
      let reason = error.localizedDescription
      fatalError("Failed to register font: \(reason)")
    }
  }

  private func registerFont(named name: String, extension ext: String) throws {
    guard let url = BundleToken.bundle.url(forResource: name, withExtension: ext),
          let provider = CGDataProvider(url: url as CFURL),
          let font = CGFont(provider),
          CTFontManagerRegisterGraphicsFont(font, nil)
    else {
      throw FontError.failedToRegisterFont
    }
  }
}

private final class BundleToken {
  static let bundle: Bundle = {
#if SWIFT_PACKAGE
    return Bundle.module
#else
    return Bundle(for: BundleToken.self)
#endif
  }()
}
