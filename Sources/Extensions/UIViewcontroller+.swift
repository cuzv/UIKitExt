import UIKit

// MARK: - TopMostVC

/// http://stackoverflow.com/questions/24825123/get-the-current-view-controller-from-the-app-delegate
public extension UIViewController {
  func topMostViewController() -> UIViewController {
    if let vc = presentedViewController {
      return vc.topMostViewController()
    } else if let vc = self as? UISplitViewController {
      if let vc = vc.viewControllers.last {
        return vc.topMostViewController()
      }
      return vc
    } else if let vc = self as? UINavigationController {
      if let vc = vc.visibleViewController {
        return vc.topMostViewController()
      }
      return vc
    } else if let vc = self as? UITabBarController {
      if let vc = vc.selectedViewController {
        return vc.topMostViewController()
      }
      return vc
    } else {
      return self
    }
  }
}

// MARK: - Adding/Removing a Child View Controller to/from Your Content

// see https://developer.apple.com/library/archive/featuredarticles/ViewControllerPGforiPhoneOS/ImplementingaContainerViewController.html

public extension UIViewController {
  func addSub(_ childController: UIViewController) {
    childController.loadViewIfNeeded()

    addChild(childController)
    childController.view.frame = view.bounds
    view.addSubview(childController.view)

    childController.view.translatesAutoresizingMaskIntoConstraints = false
    childController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    childController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    childController.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    childController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    childController.view.setNeedsLayout()

    childController.didMove(toParent: self)
  }

  func removeFromSuper() {
    willMove(toParent: nil)
    view.removeFromSuperview()
    removeFromParent()
  }

  func transition(
    to next: UIViewController,
    duration: TimeInterval,
    options: UIView.AnimationOptions,
    completion: ((Bool) -> Void)? = nil
  ) {
    if presentedViewController != nil {
      dismiss(animated: false, completion: nil)
    }

    let previous = children

    previous.forEach {
      $0.willMove(toParent: nil)
    }
    next.willMove(toParent: self)

    addChild(next)
    next.loadViewIfNeeded()
    next.view.translatesAutoresizingMaskIntoConstraints = false
    next.view.frame = view.bounds
    view.addSubview(next.view)

    NSLayoutConstraint.activate([
      next.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      next.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      next.view.topAnchor.constraint(equalTo: view.topAnchor),
      next.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
    ])

    UIView.transition(with: view, duration: duration, options: options, animations: {
      previous.forEach {
        $0.view.removeFromSuperview()
        $0.removeFromParent()
      }
      next.view.setNeedsLayout()
    }, completion: { finished in
      previous.forEach {
        $0.didMove(toParent: nil)
      }
      next.didMove(toParent: self)
      completion?(finished)
    })
  }
}
