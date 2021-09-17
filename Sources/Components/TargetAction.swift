import UIKit

extension UIControlTargetActionClosureSupport where Self: UIControl {
  /// Associates a target object and action method with the control.
  /// - Parameters:
  ///   - target: The target object—that is, the object whose action method is called. If you specify nil, UIKit searches the responder chain for an object that responds to the specified action message and delivers the message to that object.
  ///   - events: A bitmask specifying the control-specific events for which the action method is called. Always specify at least one constant. For a list of possible constants, see UIControlEvents.
  ///   - action: A closure identifying the action method to be called.
  ///   - sender: The object that initiated the request.
  @available(iOS 9.0, *)
  public func action(
    on events: UIControl.Event = .touchUpInside,
    perform: @escaping (_ sender: Self) -> Void
  ) -> Self {
    let trampoline = ActionTrampoline(action: perform)
    addTarget(trampoline, action: #selector(trampoline.action(sender:)), for: events)

    switch events {
    case .touchDown:
      objc_setAssociatedObject(self, &UIControlEventAssociatedKey.touchDown, trampoline, .OBJC_ASSOCIATION_RETAIN)
    case .touchDownRepeat:
      objc_setAssociatedObject(self, &UIControlEventAssociatedKey.touchDownRepeat, trampoline, .OBJC_ASSOCIATION_RETAIN)
    case .touchDragInside:
      objc_setAssociatedObject(self, &UIControlEventAssociatedKey.touchDragInside, trampoline, .OBJC_ASSOCIATION_RETAIN)
    case .touchDragOutside:
      objc_setAssociatedObject(self, &UIControlEventAssociatedKey.touchDragOutside, trampoline, .OBJC_ASSOCIATION_RETAIN)
    case .touchDragEnter:
      objc_setAssociatedObject(self, &UIControlEventAssociatedKey.touchDragEnter, trampoline, .OBJC_ASSOCIATION_RETAIN)
    case .touchDragExit:
      objc_setAssociatedObject(self, &UIControlEventAssociatedKey.touchDragExit, trampoline, .OBJC_ASSOCIATION_RETAIN)
    case .touchUpInside:
      objc_setAssociatedObject(self, &UIControlEventAssociatedKey.touchUpInside, trampoline, .OBJC_ASSOCIATION_RETAIN)
    case .touchUpOutside:
      objc_setAssociatedObject(self, &UIControlEventAssociatedKey.touchUpOutside, trampoline, .OBJC_ASSOCIATION_RETAIN)
    case .touchCancel:
      objc_setAssociatedObject(self, &UIControlEventAssociatedKey.touchCancel, trampoline, .OBJC_ASSOCIATION_RETAIN)
    case .valueChanged:
      objc_setAssociatedObject(self, &UIControlEventAssociatedKey.valueChanged, trampoline, .OBJC_ASSOCIATION_RETAIN)
    case .primaryActionTriggered:
      objc_setAssociatedObject(self, &UIControlEventAssociatedKey.primaryActionTriggered, trampoline, .OBJC_ASSOCIATION_RETAIN)
    case .editingDidBegin:
      objc_setAssociatedObject(self, &UIControlEventAssociatedKey.editingDidBegin, trampoline, .OBJC_ASSOCIATION_RETAIN)
    case .editingChanged:
      objc_setAssociatedObject(self, &UIControlEventAssociatedKey.editingChanged, trampoline, .OBJC_ASSOCIATION_RETAIN)
    case .editingDidEnd:
      objc_setAssociatedObject(self, &UIControlEventAssociatedKey.editingDidEnd, trampoline, .OBJC_ASSOCIATION_RETAIN)
    case .editingDidEndOnExit:
      objc_setAssociatedObject(self, &UIControlEventAssociatedKey.editingDidEndOnExit, trampoline, .OBJC_ASSOCIATION_RETAIN)
    case .allTouchEvents:
      objc_setAssociatedObject(self, &UIControlEventAssociatedKey.allTouchEvents, trampoline, .OBJC_ASSOCIATION_RETAIN)
    case .allEditingEvents:
      objc_setAssociatedObject(self, &UIControlEventAssociatedKey.allEditingEvents, trampoline, .OBJC_ASSOCIATION_RETAIN)
    case .applicationReserved:
      objc_setAssociatedObject(self, &UIControlEventAssociatedKey.applicationReserved, trampoline, .OBJC_ASSOCIATION_RETAIN)
    case .systemReserved:
      objc_setAssociatedObject(self, &UIControlEventAssociatedKey.systemReserved, trampoline, .OBJC_ASSOCIATION_RETAIN)
    case .allEvents:
      objc_setAssociatedObject(self, &UIControlEventAssociatedKey.allEvents, trampoline, .OBJC_ASSOCIATION_RETAIN)
    default:
      fatalError("*** Add target for events: \(events) not supported yet.")
    }
    return self
  }
}

// MARK: - Tap Gesture

extension GestureTargetActionClosureSupport where Self: UIView {
  /// Add a tap gesture to receiver.
  ///
  /// - Parameters:
  ///   - count: The number of taps for the gesture to be recognized. The default value is 1.
  ///   - perform: A closure identifying the action method to be called.
  ///   - sender: The object that initiated the request.
  @discardableResult
  public func tapAction(
    count: Int = 1, perform: @escaping (_ sender: Self) -> Void
  ) -> Self {
    isUserInteractionEnabled = true

    let trampoline = ActionTrampoline(action: perform)
    let tap = UITapGestureRecognizer(target: trampoline, action: #selector(trampoline.action(sender:)))
    tap.numberOfTapsRequired = count
    addGestureRecognizer(tap)

    switch count {
    case 1:
      objc_setAssociatedObject(self, &TapGestureAssociatedKey.one, trampoline, .OBJC_ASSOCIATION_RETAIN)
    case 2:
      objc_setAssociatedObject(self, &TapGestureAssociatedKey.two, trampoline, .OBJC_ASSOCIATION_RETAIN)
    case 3:
      objc_setAssociatedObject(self, &TapGestureAssociatedKey.three, trampoline, .OBJC_ASSOCIATION_RETAIN)
    case 10:
      objc_setAssociatedObject(self, &TapGestureAssociatedKey.ten, trampoline, .OBJC_ASSOCIATION_RETAIN)
    default:
      fatalError("*** Add view \(count) taps action not supported yet.")
    }

    return self
  }

  @discardableResult
  public func removeAllTapActions() -> Self {
    gestureRecognizers?.compactMap({ $0 as? UITapGestureRecognizer }).forEach { tap in
      switch tap.numberOfTapsRequired {
      case 1:
        objc_setAssociatedObject(self, &TapGestureAssociatedKey.one, nil, .OBJC_ASSOCIATION_RETAIN)
      case 2:
        objc_setAssociatedObject(self, &TapGestureAssociatedKey.two, nil, .OBJC_ASSOCIATION_RETAIN)
      case 3:
        objc_setAssociatedObject(self, &TapGestureAssociatedKey.three, nil, .OBJC_ASSOCIATION_RETAIN)
      case 10:
        objc_setAssociatedObject(self, &TapGestureAssociatedKey.ten, nil, .OBJC_ASSOCIATION_RETAIN)
      default:
        fatalError("*** Remove view \(tap.numberOfTapsRequired) taps action not supported yet.")
      }
      removeGestureRecognizer(tap)
    }
    return self
  }
}

// MARK: -

public protocol UIControlTargetActionClosureSupport {}
extension UIControl: UIControlTargetActionClosureSupport {}

public protocol GestureTargetActionClosureSupport {}
extension UIView: GestureTargetActionClosureSupport {}

// MARK: - ActionTrampoline

/// See: https://www.mikeash.com/pyblog/friday-qa-2015-12-25-swifty-targetaction.html
final class ActionTrampoline<T: NSObject> {
  private let perform: (T) -> Void

  init(action: @escaping (T) -> Void) {
    perform = action
  }

  @objc func action(sender: NSObject) {
    if let target = sender as? T {
      perform(target)
    } else if let sender = sender as? UIGestureRecognizer, let target = sender.view as? T {
      perform(target)
    } else {
      fatalError("Shit happened")
    }
  }
}

// MARK: - UIControlEventAssociatedKey

struct UIControlEventAssociatedKey {
  static var touchDown: Void?
  static var touchDownRepeat: Void?
  static var touchDragInside: Void?
  static var touchDragOutside: Void?
  static var touchDragEnter: Void?
  static var touchDragExit: Void?
  static var touchUpInside: Void?
  static var touchUpOutside: Void?
  static var touchCancel: Void?
  static var valueChanged: Void?
  static var primaryActionTriggered: Void?
  static var editingDidBegin: Void?
  static var editingChanged: Void?
  static var editingDidEnd: Void?
  static var editingDidEndOnExit: Void?
  static var allTouchEvents: Void?
  static var allEditingEvents: Void?
  static var applicationReserved: Void?
  static var systemReserved: Void?
  static var allEvents: Void?
}

// MARK: - TapGestureAssociatedKey

private struct TapGestureAssociatedKey {
  public static var one: Void?
  public static var two: Void?
  public static var three: Void?
  public static var ten: Void?
}
