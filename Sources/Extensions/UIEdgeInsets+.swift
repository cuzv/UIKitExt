import UIKit

extension UIEdgeInsets {
  public var reversed: UIEdgeInsets {
    .init(top: -top, left: -left, bottom: -bottom, right: -right)
  }

  public init(vertical: CGFloat, horizontal: CGFloat) {
    self.init(top: vertical, left: horizontal, bottom: vertical, right: horizontal)
  }
}
