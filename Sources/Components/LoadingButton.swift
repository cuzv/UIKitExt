import UIKit

public extension UIControl.State {
  static let loading = UIControl.State(rawValue: 1 << 16)
}

public final class LoadingButton: UIButton {
  private var loadingAnimationToken: CABasicAnimation?
  private let loadingAnimationKey = "com.redrainlab.loading"
  private let emptyImage = UIImage()

  @objc public dynamic var isLoading: Bool = false {
    didSet {
      let loading = isLoading
      if oldValue != loading {
        onLoadingStateUpdated(isLoading: loading)
      }

      isUserInteractionEnabled = !loading
    }
  }

  override public var state: UIControl.State {
    isLoading ? .loading : super.state
  }

  override public init(frame: CGRect) {
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
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(resumeAnimationIfNeeded),
      name: UIApplication.didBecomeActiveNotification,
      object: nil
    )
  }

  // Prevent weird bug which do animation the second time with image miss-rotation.
  override public func setImage(_ image: UIImage?, for state: UIControl.State) {
    super.setImage(image ?? emptyImage, for: state)
  }

  override public func didMoveToSuperview() {
    super.didMoveToSuperview()

    if superview != nil {
      if image(for: .normal) == nil {
        setImage(nil, for: .normal)
      }
    }
  }

  override public func didMoveToWindow() {
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
    if window != nil, isLoading {
      isLoading.toggle()
      isLoading.toggle()
    }
  }
}
