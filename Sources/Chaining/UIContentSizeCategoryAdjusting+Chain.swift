import UIKit

public extension UIContentSizeCategoryAdjusting {
  @discardableResult
  func adjustsFontForContentSizeCategory(_ adjusts: Bool) -> Self {
    adjustsFontForContentSizeCategory = adjusts
    return self
  }
}
