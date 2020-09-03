import UIKit

@available(iOS 10.0, *)
public final class VisualEffectView: UIVisualEffectView {
    private var animator: UIViewPropertyAnimator?
    private var observer: NSObjectProtocol?
    private var restoreEffect: UIVisualEffect?

    public override init(effect: UIVisualEffect?) {
        super.init(effect: effect)
        setup()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    deinit {
        if let token = observer {
            observer = nil
            NotificationCenter.default.removeObserver(token)
        }

        if isDisplayLinkInitialized {
            displayLink.invalidate()
        }
    }

    private func setup() {
        observer = NotificationCenter.default.addObserver(forName: UIApplication.didBecomeActiveNotification, object: nil, queue: .main) { [weak self] _ in
            self?.initializeAnimator()
        }
    }

    public override func didMoveToWindow() {
        super.didMoveToWindow()

        if nil != window {
            initializeAnimator()
        }
    }

    private func initializeAnimator() {
        animator?.stopAnimation(false)
        animator = nil

        animator = UIViewPropertyAnimator()
        animator?.addAnimations { [weak self] in
            self?.effect = nil
        }

        restoreEffect = effect
        animator?.addCompletion { [weak self] position in
            let effect = self?.restoreEffect
            if .end == position, nil != effect {
                self?.effect = effect
            }
        }
    }

    public override var effect: UIVisualEffect? {
        didSet {
            if nil != effect {
                restoreEffect = effect
            }
        }
    }

    /// [0...100]
    public var blurRadius: CGFloat {
        get { 100 - min(100, (animator?.fractionComplete ?? 1) * 100) }
        set { animator?.fractionComplete = 1 - min(1, newValue / 100) }
    }

    public var colorTint: UIColor? {
        get { contentView.backgroundColor }
        set { contentView.backgroundColor = newValue }
    }

    public var colorTintAlpha: CGFloat {
        get { contentView.alpha }
        set { contentView.alpha = newValue }
    }

    // MARK: Animation support

    public func animate(blurRadius: CGFloat, within duration: TimeInterval, completion: (() -> Void)? = nil) {
        if isAnimating { return }

        if abs(self.blurRadius - blurRadius) < 0.001 {
            completion?()
            return
        }

        isAnimating = true
        completionHandler = completion
        endRadius = blurRadius

        additionPerFrame = (endRadius - self.blurRadius) / CGFloat(duration * 60)
        displayLink.isPaused = false
    }

    private var endRadius: CGFloat = 0
    private var additionPerFrame: CGFloat = 0
    private var completionHandler: (() -> Void)?
    private var isAnimating: Bool = false

    private func updateFrame() {
        blurRadius += additionPerFrame

        if abs(blurRadius - endRadius) < 0.001 {
            displayLink.isPaused = true

            if let handler = completionHandler {
                completionHandler = nil
                handler()
            }

            isAnimating = false
        }
    }

    private var isDisplayLinkInitialized: Bool = false
    private lazy var displayLink: CADisplayLink = {
        isDisplayLinkInitialized = true
        let displayLink = CADisplayLink(target: TargetProxy(target: self), selector: #selector(TargetProxy.onScreenUpdate))
        displayLink.preferredFramesPerSecond = 60
        displayLink.add(to: .main, forMode: .common)
        displayLink.isPaused = true
        return displayLink
    }()
}

@available(iOS 10.0, *)
extension VisualEffectView {
    class TargetProxy {
        private weak var target: VisualEffectView?

        init(target: VisualEffectView) {
            self.target = target
        }

        @objc func onScreenUpdate() {
            target?.updateFrame()
        }
    }
}
