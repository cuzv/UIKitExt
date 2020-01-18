import UIKit

// MARK: - TopMostVC

/// http://stackoverflow.com/questions/24825123/get-the-current-view-controller-from-the-app-delegate
extension UIViewController {
    public func topMostViewController() -> UIViewController {
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

extension UIViewController {
    @available(iOS 9.0, *)
    public func addSub(_ childController: UIViewController) {
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

    public func removeFromSuper() {
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}
