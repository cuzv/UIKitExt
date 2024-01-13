import UIKit

public extension UIEdgeInsets {
  var reversed: UIEdgeInsets {
    .init(top: -top, left: -left, bottom: -bottom, right: -right)
  }

  init(vertical: CGFloat, horizontal: CGFloat) {
    self.init(
      top: vertical, left: horizontal,
      bottom: vertical, right: horizontal
    )
  }

  init(vertical: CGFloat) {
    self.init(vertical: vertical, horizontal: 0)
  }

  init(horizontal: CGFloat) {
    self.init(vertical: 0, horizontal: horizontal)
  }

  init(value: CGFloat) {
    self.init(top: value, left: value, bottom: value, right: value)
  }
}
