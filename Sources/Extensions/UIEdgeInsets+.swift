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

  init(top: CGFloat = 0, bottom: CGFloat = 0, left: CGFloat = 0, right: CGFloat = 0) {
    self.init(top: top, left: left, bottom: bottom, right: right)
  }
}

extension UIEdgeInsets: ExpressibleByIntegerLiteral {
  public init(integerLiteral value: IntegerLiteralType) {
    self = .init(value: CGFloat(value))
  }
}

extension UIEdgeInsets: ExpressibleByFloatLiteral {
  public init(floatLiteral value: FloatLiteralType) {
    self = .init(value: value)
  }
}

extension UIEdgeInsets: ExpressibleByArrayLiteral {
  public init(arrayLiteral elements: CGFloat...) {
    self = .init(
      top: elements[0, default: 0],
      left: elements[1, default: 0],
      bottom: elements[2, default: 0],
      right: elements[3, default: 0]
    )
  }
}

extension Collection {
  subscript(_ offset: Int, default defaultValue: @autoclosure () -> Element) -> Element {
    var index: Index = startIndex
    formIndex(&index, offsetBy: offset)
    return count > offset ? self[index] : defaultValue()
  }
}
