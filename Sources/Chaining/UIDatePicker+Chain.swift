import UIKit

public extension UIDatePicker {
  @discardableResult
  func calendar(_ value: Calendar?) -> Self {
    calendar = value
    return self
  }

  @discardableResult
  func date(_ value: Date) -> Self {
    date = value
    return self
  }

  @discardableResult
  func locale(_ value: Locale?) -> Self {
    locale = value
    return self
  }

  @discardableResult
  func timeZone(_ value: TimeZone?) -> Self {
    timeZone = value
    return self
  }

  @discardableResult
  func datePickerMode(_ value: Mode) -> Self {
    datePickerMode = value
    return self
  }

  @available(iOS 13.4, macCatalyst 13.4, *)
  @discardableResult
  func preferredDatePickerStyle(_ value: UIDatePickerStyle) -> Self {
    preferredDatePickerStyle = value
    return self
  }

  @discardableResult
  func maximumDate(_ value: Date?) -> Self {
    maximumDate = value
    return self
  }

  @discardableResult
  func minimumDate(_ value: Date?) -> Self {
    minimumDate = value
    return self
  }

  @discardableResult
  func minuteInterval(_ value: Int) -> Self {
    minuteInterval = value
    return self
  }

  @discardableResult
  func countDownDuration(_ value: TimeInterval) -> Self {
    countDownDuration = value
    return self
  }

  @available(iOS 15.0, macCatalyst 15.0, *)
  @discardableResult
  func roundsToMinuteInterval(_ value: Bool) -> Self {
    roundsToMinuteInterval = value
    return self
  }
}
