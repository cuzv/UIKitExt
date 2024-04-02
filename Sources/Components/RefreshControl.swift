import Combine
import UIKit

@available(iOS 13.0, *)
public final class RefreshControl: UIRefreshControl {
  private let spinView = OuroborosView()
  private var widthConstraint: NSLayoutConstraint?
  private var heightConstraint: NSLayoutConstraint?
  private var bag: AnyCancellable?

  override public init(frame: CGRect) {
    super.init(frame: frame)
    awake()
  }

  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    awake()
  }

  private func awake() {
    tintColor = .clear

    spinView.hidesWhenStopped = false
    spinView.tintColor = .label
    addSubview(spinView)
    spinView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      spinView.centerXAnchor.constraint(equalTo: centerXAnchor),
      spinView.centerYAnchor.constraint(equalTo: centerYAnchor),
    ])

    widthConstraint = spinView.widthAnchor.constraint(equalToConstant: spinnerSize)
    widthConstraint?.isActive = true
    heightConstraint = spinView.heightAnchor.constraint(equalToConstant: spinnerSize)
    heightConstraint?.isActive = true
  }

  public var spinnerSize: CGFloat = 32 {
    didSet {
      widthConstraint?.constant = spinnerSize
      heightConstraint?.constant = spinnerSize
      setNeedsUpdateConstraints()
    }
  }

  override public func didMoveToSuperview() {
    super.didMoveToSuperview()

    if let superview = superview as? UIScrollView, bag == nil {
      bag = superview
        .publisher(for: \.contentOffset, options: .new)
        .sink(receiveValue: { [weak self] point in
          guard let self else { return }
          contentOffsetChanges(point)
        })
    }
  }

  private var isEnding = false

  override public func endRefreshing() {
    if isRefreshing {
      isEnding = true
    }

    super.endRefreshing()
  }

  private func contentOffsetChanges(_ offset: CGPoint) {
    let pullDistance = max(0.0, -offset.y)
    let pullRatio = min(max(pullDistance, 0.0), 140.0) / 140.0

    if (pullRatio - 0) < .ulpOfOne {
      isEnding = false
    }

    if isEnding {
      return
    }

    spinView.progress = isRefreshing ? 1.0 : pullRatio
    spinView.isAnimating = isRefreshing
  }

  override public var isHidden: Bool {
    set {
      super.isHidden = newValue
      spinView.isHidden = newValue
    }
    get {
      super.isHidden
    }
  }
}

@available(iOS 13.0, *)
public extension RefreshControl {
  @discardableResult
  func spinnerSize(_ size: CGFloat) -> Self {
    spinnerSize = size
    return self
  }

  @discardableResult
  func spinningColor(_ color: UIColor) -> Self {
    spinView.tintColor(color)
    return self
  }
}
