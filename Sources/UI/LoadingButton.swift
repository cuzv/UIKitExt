import UIKit

extension UIControl.State {
    public static let loading = UIControl.State(rawValue: 1 << 16)
}

final public class LoadingButton: UIButton {
    private var loadingAnimationToken: CABasicAnimation?
    private let loadingAnimationKey = "bar.foo.loading"
    private let emptyImage = UIImage()

    public var isLoading: Bool = false {
        didSet {
            if oldValue != isLoading {
                onLoadingStateUpdated()
            }
        }
    }

    override public var state: UIControl.State {
        isLoading ? .loading : super.state
    }

    // Prevent weird bug which do animation the second time with image miss-rotation.
    public override func setImage(_ image: UIImage?, for state: UIControl.State) {
        super.setImage(image ?? emptyImage, for: state)
    }

    public override func didMoveToSuperview() {
        super.didMoveToSuperview()

        if nil != superview {
            if nil == image(for: .normal) {
                setImage(nil, for: .normal)
            }
        }
    }

    private func onLoadingStateUpdated() {
        if isLoading {
            let loading = CABasicAnimation(keyPath: "transform.rotation.z")
            loading.fromValue = 0
            loading.toValue = 2.0 * .pi
            loading.duration = 2
            loading.isRemovedOnCompletion = false
            loading.fillMode = .forwards
            loading.repeatDuration = .greatestFiniteMagnitude
            imageView?.layer.add(loading, forKey: loadingAnimationKey)
        } else {
            imageView?.layer.removeAnimation(forKey: loadingAnimationKey)
        }

        setNeedsLayout()
    }
}
