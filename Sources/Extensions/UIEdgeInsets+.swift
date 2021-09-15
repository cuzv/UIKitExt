import UIKit

extension UIEdgeInsets {
  public var reversed: UIEdgeInsets {
    .init(top: -top, left: -left, bottom: -bottom, right: -right)
  }

  public init(vertical: CGFloat, horizontal: CGFloat) {
    self.init(
      top: vertical, left: horizontal,
      bottom: vertical, right: horizontal
    )
  }

  public init(vertical: CGFloat) {
    self.init(vertical: vertical, horizontal: 0)
  }

  public init(horizontal: CGFloat) {
    self.init(vertical: 0, horizontal: horizontal)
  }

  public init(value: CGFloat) {
    self.init(top: value, left: value, bottom: value, right: value)
  }
}
