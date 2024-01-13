import UIKit

public extension NSLayoutConstraint {
  class func activate(_ constraints: NSLayoutConstraint...) {
    activate(constraints)
  }

  class func deactivate(_ constraints: NSLayoutConstraint...) {
    deactivate(constraints)
  }
}
