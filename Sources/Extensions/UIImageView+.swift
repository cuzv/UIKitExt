import UIKit

extension UIImageView {
  public convenience init?(
    named name: String,
    contentMode: UIView.ContentMode = .scaleAspectFill
  ) {
    self.init(image: UIImage(named: name), contentMode: contentMode)
  }

  public convenience init(image: UIImage?, contentMode: UIView.ContentMode) {
    self.init()
    self.image = image
    self.contentMode = contentMode
    self.translatesAutoresizingMaskIntoConstraints = false
    self.adjustsImageSizeForAccessibilityContentSizeCategory = true
  }
}
