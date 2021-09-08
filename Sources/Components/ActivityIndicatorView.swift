import UIKit

public final class ActivityIndicatorView: UIActivityIndicatorView {
  @IBOutlet public weak var connectedView: UIView?

  override public init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }

  required public init(coder: NSCoder) {
    super.init(coder: coder)
    setup()
  }

  private func setup() {
    alpha = 0
  }

  override public func startAnimating() {
    super.startAnimating()
    UIView.animate(withDuration: 0.25) {
      self.alpha = 1
      self.connectedView?.alpha = 0
    }
  }

  override public func stopAnimating() {
    super.stopAnimating()
    UIView.animate(withDuration: 0.25) {
      self.alpha = 0
      self.connectedView?.alpha = 1
    }
  }
}

extension UIActivityIndicatorView {
  public var isActivating: Bool {
    get { return isAnimating }
    set { newValue ? startAnimating() : stopAnimating() }
  }
}
