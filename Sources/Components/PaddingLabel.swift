import UIKit

/// https://johncodeos.com/how-to-add-padding-in-uilabel-in-ios-using-swift/
@IBDesignable
final public class PaddingLabel: UILabel {
  public var paddings = UIEdgeInsets.zero {
    didSet { invalidateIntrinsicContentSize() }
  }

  override public func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
    let insetRect = bounds.inset(by: paddings)
    let textRect = super.textRect(forBounds: insetRect, limitedToNumberOfLines: numberOfLines)
    let invertedInsets = UIEdgeInsets(top: -paddings.top, left: -paddings.left, bottom: -paddings.bottom, right: -paddings.right)
    return textRect.inset(by: invertedInsets)
  }

  override public func drawText(in rect: CGRect) {
    super.drawText(in: rect.inset(by: paddings))
  }

  @IBInspectable
  public var paddingLeft: CGFloat {
    set { paddings.left = newValue }
    get { return paddings.left }
  }

  @IBInspectable
  public var paddingRight: CGFloat {
    set { paddings.right = newValue }
    get { return paddings.right }
  }

  @IBInspectable
  public var paddingTop: CGFloat {
    set { paddings.top = newValue }
    get { return paddings.top }
  }

  @IBInspectable
  public var paddingBottom: CGFloat {
    set { paddings.bottom = newValue }
    get { return paddings.bottom }
  }
}
