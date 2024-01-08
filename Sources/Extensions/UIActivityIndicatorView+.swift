import UIKit

public extension UIActivityIndicatorView {
  var isSpinning: Bool {
    get {
      isAnimating
    }
    set {
      if newValue {
        startAnimating()
      } else {
        stopAnimating()
      }
    }
  }
}
