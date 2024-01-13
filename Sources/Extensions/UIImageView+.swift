import UIKit

public extension UIImageView {
  convenience init?(
    named name: String,
    contentMode: UIView.ContentMode = .scaleAspectFill
  ) {
    self.init(image: UIImage(named: name), contentMode: contentMode)
  }

  convenience init(image: UIImage?, contentMode: UIView.ContentMode) {
    self.init()
    self.image = image
    self.contentMode = contentMode
    translatesAutoresizingMaskIntoConstraints = false
    adjustsImageSizeForAccessibilityContentSizeCategory = true
  }
}
