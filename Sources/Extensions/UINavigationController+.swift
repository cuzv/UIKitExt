import UIKit

extension UINavigationController {
  public func push(
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

  public func pop(animated: Bool, completion: (() -> Void)?) {
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
  public func enableFullWidthBackGesture() {
    // The trick here is to wire up our full-width `fullWidthBackGestureRecognizer` to execute the same handler as
    // the system `interactivePopGestureRecognizer`. That's done by assigning the same "targets" (effectively
    // object and selector) of the system one to our gesture recognizer.
    guard
      let interactivePopGestureRecognizer = interactivePopGestureRecognizer,
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
    let isSystemSwipeToBackEnabled = interactivePopGestureRecognizer?.isEnabled ?? false
    let isThereStackedViewControllers = viewControllers.count > 1
    let result = isSystemSwipeToBackEnabled && isThereStackedViewControllers
    return result
  }

  public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
    guard let gestureRecognizer = gestureRecognizer as? UIPanGestureRecognizer else {
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
