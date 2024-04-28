import UIKit

@available(iOS 11.0, *)
public extension NSDirectionalEdgeInsets {
  var reversed: NSDirectionalEdgeInsets {
    .init(top: -top, leading: -leading, bottom: -bottom, trailing: -trailing)
  }

  init(vertical: CGFloat, horizontal: CGFloat) {
    self.init(
      top: vertical, leading: horizontal,
      bottom: vertical, trailing: horizontal
    )
  }

  init(vertical: CGFloat) {
    self.init(vertical: vertical, horizontal: 0)
  }

  init(horizontal: CGFloat) {
    self.init(vertical: 0, horizontal: horizontal)
  }

  init(value: CGFloat) {
    self.init(top: value, leading: value, bottom: value, trailing: value)
  }

  init(top: CGFloat = 0, bottom: CGFloat = 0, leading: CGFloat = 0, trailing: CGFloat = 0) {
    self.init(top: top, leading: leading, bottom: bottom, trailing: trailing)
  }
}

extension NSDirectionalEdgeInsets: ExpressibleByIntegerLiteral {
  public init(integerLiteral value: IntegerLiteralType) {
    self = .init(value: CGFloat(value))
  }
}

extension NSDirectionalEdgeInsets: ExpressibleByFloatLiteral {
  public init(floatLiteral value: FloatLiteralType) {
    self = .init(value: value)
  }
}

extension NSDirectionalEdgeInsets: ExpressibleByArrayLiteral {
  public init(arrayLiteral elements: CGFloat...) {
    self = .init(
      top: elements[0, default: 0],
      leading: elements[1, default: 0],
      bottom: elements[2, default: 0],
      trailing: elements[3, default: 0]
    )
  }
}
