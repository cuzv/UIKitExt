import UIKit

extension UINavigationController {
    public func push(_ vc: UIViewController, animated: Bool, completion: (() -> Void)?) {
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
