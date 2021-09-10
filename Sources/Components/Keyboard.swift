import UIKit

// See https://github.com/ShengHuaWu/ObserveKeyboardNotifications

extension NotificationCenter {
  public struct KeyboardNotificationDescriptor<Payload> {
    public let name: Notification.Name
    public let convert: (Notification) -> Payload
  }

  public struct KeyboardPayload {
    let beginFrame: CGRect
    let endFrame: CGRect
    let curve: UIView.AnimationCurve
    let duration: TimeInterval
    let isLocal: Bool
  }
}

extension NotificationCenter.KeyboardNotificationDescriptor
where Payload == NotificationCenter.KeyboardPayload {
  public typealias KeyboardNotificationDescriptor = NotificationCenter.KeyboardNotificationDescriptor
  public typealias KeyboardPayload = NotificationCenter.KeyboardPayload

  public static let keyboardWillShow = KeyboardNotificationDescriptor(
    name: UIWindow.keyboardWillShowNotification,
    convert: KeyboardPayload.init)
  public static let keyboardDidShow = KeyboardNotificationDescriptor(
    name: UIWindow.keyboardDidShowNotification,
    convert: KeyboardPayload.init)
  public static let keyboardWillHide = KeyboardNotificationDescriptor(
    name: UIWindow.keyboardWillHideNotification,
    convert: KeyboardPayload.init)
  public static let keyboardDidHide = KeyboardNotificationDescriptor(
    name: UIWindow.keyboardDidHideNotification,
    convert: KeyboardPayload.init)
}

extension NotificationCenter.KeyboardPayload {
  public init(note: Notification) {
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

extension NotificationCenter {
  public func observe<Payload>(
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

extension UIView {
  public static func animateKeyboard(
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
