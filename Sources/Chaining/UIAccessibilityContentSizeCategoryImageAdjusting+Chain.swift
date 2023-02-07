import UIKit

public extension UIAccessibilityContentSizeCategoryImageAdjusting {
  @discardableResult
  func adjustsImageSizeForAccessibilityContentSizeCategory(_ adjusts: Bool) -> Bool {
    adjustsImageSizeForAccessibilityContentSizeCategory = adjusts
    return self
  }
}
