import UIKit

/// https://gist.github.com/ksmandersen/e2d4d6bd60a685e94eb7e22b7670d2a8
open class PaddingTextField: UITextField {
  public var paddings = UIEdgeInsets.zero {
    didSet {
      setNeedsDisplay()
    }
  }
  
  public override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  convenience init() {
    self.init(frame: .zero)
  }
  
  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  open override func textRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.inset(by: paddings)
  }
  
  open override func editingRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.inset(by: paddings)
  }
  
  open override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.inset(by: paddings)
  }
  
  open override func drawText(in rect: CGRect) {
    super.drawText(in: rect.inset(by: paddings))
  }
  
  @discardableResult
  open func paddings(_ value: UIEdgeInsets) -> Self {
    paddings = value
    return self
  }
}
