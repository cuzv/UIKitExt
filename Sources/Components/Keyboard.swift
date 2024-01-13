import UIKit

// See https://github.com/ShengHuaWu/ObserveKeyboardNotifications

public extension NotificationCenter {
  struct KeyboardNotificationDescriptor<Payload> {
    public let name: Notification.Name
    public let convert: (Notification) -> Payload
  }

  struct KeyboardPayload {
    public let beginFrame: CGRect
    public let endFrame: CGRect
    public let curve: UIView.AnimationCurve
    public let duration: TimeInterval
    public let isLocal: Bool
  }
}

public extension NotificationCenter.KeyboardNotificationDescriptor
  where Payload == NotificationCenter.KeyboardPayload
{
  typealias KeyboardNotificationDescriptor = NotificationCenter.KeyboardNotificationDescriptor
  typealias KeyboardPayload = NotificationCenter.KeyboardPayload

  static let keyboardWillShow = KeyboardNotificationDescriptor(
    name: UIWindow.keyboardWillShowNotification,
    convert: KeyboardPayload.init
  )
  static let keyboardDidShow = KeyboardNotificationDescriptor(
    name: UIWindow.keyboardDidShowNotification,
    convert: KeyboardPayload.init
  )
  static let keyboardWillHide = KeyboardNotificationDescriptor(
    name: UIWindow.keyboardWillHideNotification,
    convert: KeyboardPayload.init
  )
  static let keyboardDidHide = KeyboardNotificationDescriptor(
    name: UIWindow.keyboardDidHideNotification,
    convert: KeyboardPayload.init
  )
}

public extension NotificationCenter.KeyboardPayload {
  init(note: Notification) {
    guard let userInfo = note.userInfo else {
      fatalError("Keyboard behavior related notification's userInfo can't be nil.")
    }
    beginFrame = userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! CGRect
    endFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
    curve = UIView.AnimationCurve(rawValue: userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as! Int)!
    duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval
    isLocal = userInfo[UIResponder.keyboardIsLocalUserInfoKey] as! Bool
  }
}

public extension NotificationCenter {
  func observe<Payload>(
    _ descriptor: KeyboardNotificationDescriptor<Payload>,
    object: Any? = nil,
    queue: OperationQueue? = nil,
    block: @escaping (Payload) -> Void
  ) -> NSObjectProtocol {
    addObserver(
      forName: descriptor.name,
      object: object,
      queue: queue
    ) { notification in
      block(descriptor.convert(notification))
    }
  }
}

public extension UIView {
  static func animateKeyboard(
    withDuration duration: TimeInterval,
    curve: UIView.AnimationCurve,
    animations: @escaping () -> Void
  ) {
    if #available(iOS 14, *) {
      UIView.animate(
        withDuration: duration,
        delay: 0,
        options: AnimationOptions(rawValue: UInt(curve.rawValue) << 16),
        animations: animations,
        completion: nil
      )
    } else {
      UIView.beginAnimations(nil, context: nil)
      UIView.setAnimationBeginsFromCurrentState(true)
      UIView.setAnimationDuration(duration)
      UIView.setAnimationCurve(curve)
      animations()
      UIView.commitAnimations()
    }
  }
}
