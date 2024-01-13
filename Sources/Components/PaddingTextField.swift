import UIKit

/// https://gist.github.com/ksmandersen/e2d4d6bd60a685e94eb7e22b7670d2a8
open class PaddingTextField: UITextField {
  public var paddings = UIEdgeInsets.zero {
    didSet {
      setNeedsDisplay()
    }
  }

  override public init(frame: CGRect) {
    super.init(frame: frame)
  }

  convenience init() {
    self.init(frame: .zero)
  }

  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  override open func textRect(forBounds bounds: CGRect) -> CGRect {
    bounds.inset(by: paddings)
  }

  override open func editingRect(forBounds bounds: CGRect) -> CGRect {
    bounds.inset(by: paddings)
  }

  override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
    bounds.inset(by: paddings)
  }

  override open func drawText(in rect: CGRect) {
    super.drawText(in: rect.inset(by: paddings))
  }

  @discardableResult
  open func paddings(_ value: UIEdgeInsets) -> Self {
    paddings = value
    return self
  }
}
