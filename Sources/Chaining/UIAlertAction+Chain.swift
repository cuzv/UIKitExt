import UIKit

public extension UIAlertAction {
  @discardableResult
  func titleTextColor(_ color: UIColor?) -> Self {
    titleTextColor = color
    return self
  }

  var titleTextColor: UIColor? {
    get {
      value(forKey: "titleTextColor") as? UIColor
    }
    set {
      setValue(newValue, forKey: "titleTextColor")
    }
  }
}
