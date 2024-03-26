import UIKit

public extension UIControl.State {
  static let loading = UIControl.State(rawValue: 1 << 16)
}

public final class LoadingButton: HitTestSlopButton {
  private let emptyImage = UIImage()
  private var loadingView: AnimationView = OuroborosView()

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

    title("", for: .loading)
      .image(emptyImage, for: .loading)
      .backgroundImage(emptyImage, for: .loading)

    loadingView(loadingView)
  }

  @discardableResult
  public func loadingView(_ view: AnimationView) -> Self {
    loadingView.removeFromSuperview()
    loadingView = view
    view.isAnimating = false

    return addSubview(view) { proxy in
      proxy.width == proxy.superview.heightAnchor * 0.7
      proxy.height == proxy.superview.heightAnchor * 0.7
      proxy.center == proxy.superview.centerAnchor
    }
  }

  @discardableResult
  public func loadingColor(_ color: UIColor) -> Self {
    loadingView.tintColor(color)
    return self
  }

  @discardableResult
  public func loading(_ value: Bool) -> Self {
    isLoading = value
    return self
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
    loadingView.isAnimating = isLoading
    setNeedsLayout()
  }

  @objc private func resumeAnimationIfNeeded() {
    if window != nil, isLoading {
      isLoading.toggle()
      isLoading.toggle()
    }
  }
}
