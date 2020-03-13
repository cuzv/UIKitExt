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
            let currentValue = isLoading
            if oldValue != currentValue {
                onLoadingStateUpdated(isLoading: currentValue)
            }
        }
    }

    override public var state: UIControl.State {
        isLoading ? .loading : super.state
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    private func setup() {
        NotificationCenter.default.addObserver(self, selector: #selector(resumeAnimationIfNeeded), name: UIApplication.didBecomeActiveNotification, object: nil)
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

    public override func didMoveToWindow() {
        super.didMoveToWindow()
        resumeAnimationIfNeeded()
    }

    private func onLoadingStateUpdated(isLoading: Bool) {
        if isLoading {
            let loading = CABasicAnimation(keyPath: "transform.rotation.z")
            loading.fromValue = 0
            loading.toValue = 2.0 * .pi
            loading.duration = 2
            loading.fillMode = .both
            loading.repeatDuration = .greatestFiniteMagnitude
            imageView?.layer.add(loading, forKey: loadingAnimationKey)
        } else {
            imageView?.layer.removeAnimation(forKey: loadingAnimationKey)
        }

        setNeedsLayout()
    }

    @objc private func resumeAnimationIfNeeded() {
        if nil != window && isLoading {
            isLoading.toggle()
            isLoading.toggle()
        }
    }
}
