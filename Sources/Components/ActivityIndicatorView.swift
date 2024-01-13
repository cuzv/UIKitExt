import UIKit

public final class ActivityIndicatorView: UIActivityIndicatorView {
  @IBOutlet public var connectedView: UIView?

  override public init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }

  public required init(coder: NSCoder) {
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

public extension UIActivityIndicatorView {
  var isActivating: Bool {
    get { isAnimating }
    set { newValue ? startAnimating() : stopAnimating() }
  }
}
