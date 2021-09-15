import UIKit

@available(iOS 11.0, *)
extension NSDirectionalEdgeInsets {
  public var reversed: NSDirectionalEdgeInsets {
    .init(top: -top, leading: -leading, bottom: -bottom, trailing: -trailing)
  }

  public init(vertical: CGFloat, horizontal: CGFloat) {
    self.init(
      top: vertical, leading: horizontal,
      bottom: vertical, trailing: horizontal
    )
  }

  public init(vertical: CGFloat) {
    self.init(vertical: vertical, horizontal: 0)
  }

  public init(horizontal: CGFloat) {
    self.init(vertical: 0, horizontal: horizontal)
  }

  public init(value: CGFloat) {
    self.init(top: value, leading: value, bottom: value, trailing: value)
  }
}
