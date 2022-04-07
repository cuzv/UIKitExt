import UIKit

/// https://johncodeos.com/how-to-add-padding-in-uilabel-in-ios-using-swift/
@IBDesignable
final public class PaddingLabel: UILabel {
  public var padding = UIEdgeInsets.zero {
    didSet { invalidateIntrinsicContentSize() }
  }

  override public func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
    let insetRect = bounds.inset(by: padding)
    let textRect = super.textRect(forBounds: insetRect, limitedToNumberOfLines: numberOfLines)
    let invertedInsets = UIEdgeInsets(top: -padding.top, left: -padding.left, bottom: -padding.bottom, right: -padding.right)
    return textRect.inset(by: invertedInsets)
  }

  override public func drawText(in rect: CGRect) {
    super.drawText(in: rect.inset(by: padding))
  }

  @IBInspectable
  public var paddingLeft: CGFloat {
    set { padding.left = newValue }
    get { return padding.left }
  }

  @IBInspectable
  public var paddingRight: CGFloat {
    set { padding.right = newValue }
    get { return padding.right }
  }

  @IBInspectable
  public var paddingTop: CGFloat {
    set { padding.top = newValue }
    get { return padding.top }
  }

  @IBInspectable
  public var paddingBottom: CGFloat {
    set { padding.bottom = newValue }
    get { return padding.bottom }
  }
}
