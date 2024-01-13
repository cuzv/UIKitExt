import UIKit

public extension UINavigationController {
  func push(
    _ vc: UIViewController,
    animated: Bool,
    completion: (() -> Void)?
  ) {
    pushViewController(vc, animated: animated)

    if let coordinator = transitionCoordinator, animated {
      coordinator.animate(alongsideTransition: nil) { _ in
        completion?()
      }
    } else {
      completion?()
    }
  }

  func pop(animated: Bool, completion: (() -> Void)?) {
    popViewController(animated: animated)

    if let coordinator = transitionCoordinator, animated {
      coordinator.animate(alongsideTransition: nil) { _ in
        completion?()
      }
    } else {
      completion?()
    }
  }
}

// ref: https://stackoverflow.com/a/60598558/3797903
extension UINavigationController: UIGestureRecognizerDelegate {
  public func configureWithSloppyPop() {
    // The trick here is to wire up our full-width `fullWidthBackGestureRecognizer` to execute the same handler as
    // the system `interactivePopGestureRecognizer`. That's done by assigning the same "targets" (effectively
    // object and selector) of the system one to our gesture recognizer.
    guard
      let interactivePopGestureRecognizer,
      let targets = interactivePopGestureRecognizer.value(forKey: "targets")
    else {
      return
    }

    let fullWidthBackGestureRecognizer = UIPanGestureRecognizer()
    fullWidthBackGestureRecognizer.setValue(targets, forKey: "targets")
    fullWidthBackGestureRecognizer.delegate = self
    view.addGestureRecognizer(fullWidthBackGestureRecognizer)
  }

  public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
    if viewControllers.count <= 1 {
      return false
    }
    if !(interactivePopGestureRecognizer?.isEnabled ?? false) {
      return false
    }
    if let gestureView = gestureRecognizer.view {
      let location = gestureRecognizer.location(in: gestureView)
      if let view = gestureView.hitTest(location, with: nil) {
        if view.tag == 0xDEAD {
          return false
        }
        if view.isKind(of: UIControl.self), !view.isKind(of: UIButton.self) {
          return false
        }
        if let view = view as? SloppyPopSupport, !view.isSloppyPopEnabled {
          return false
        }
      }
    }
    return true
  }

  public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
    guard let gestureRecognizer = gestureRecognizer as? UIPanGestureRecognizer else {
      return false
    }

    if otherGestureRecognizer.view?.tag == 0xDEAD {
      return false
    }
    if let view = otherGestureRecognizer.view as? SloppyPopSupport, !view.isSloppyPopEnabled {
      return false
    }

    if let scrollView = otherGestureRecognizer.view as? UIScrollView, let gestureView = gestureRecognizer.view {
      let isHScroll = scrollView.contentSize.height > CGFloat.ulpOfOne && scrollView.contentSize.width > scrollView.contentSize.height

      if isHScroll {
        let isRightToLeft = scrollView.effectiveUserInterfaceLayoutDirection == .rightToLeft

        if (
          isRightToLeft && abs(scrollView.contentOffset.x + scrollView.contentInset.right) < .ulpOfOne
        ) || (
          !isRightToLeft && abs(scrollView.contentOffset.x + scrollView.contentInset.left) < .ulpOfOne
        ) {
          let velocity = gestureRecognizer.velocity(in: gestureView)

          if (
            isRightToLeft && velocity.x < .ulpOfOne
          ) || (
            !isRightToLeft && velocity.x > .ulpOfOne
          ) {
            otherGestureRecognizer.isEnabled = false
            otherGestureRecognizer.isEnabled = true
            return true
          }
        }
      }
    }

    return false
  }
}

public protocol SloppyPopSupport {
  var isSloppyPopEnabled: Bool { get }
}
