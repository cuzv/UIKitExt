import UIKit

public extension UIAccessibilityContentSizeCategoryImageAdjusting {
  @discardableResult
  func adjustsImageSizeForAccessibilityContentSizeCategory(_ adjusts: Bool) -> Self {
    adjustsImageSizeForAccessibilityContentSizeCategory = adjusts
    return self
  }
}
