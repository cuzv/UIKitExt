import UIKit

// MARK: - Toast

open class ToastContent: UIView {
  open func present(completion: @escaping (Bool) -> Void) {
    fatalError("Subclass must override.")
  }

  open func dismiss(delay: TimeInterval, completion: @escaping (Bool) -> Void) {
    fatalError("Subclass must override.")
  }
}

public struct Toast {
  let body: ToastContent
  let duration: TimeInterval

  public init(body: ToastContent, duration: TimeInterval = 2) {
    self.body = body
    self.duration = duration
  }

  public func show() {
    guard UIApplication.shared.applicationState == .active else { return }
    ToastQueue.shared.enqueue(self)
  }
}

// MARK: - ToastQueue

final class ToastQueue {
  static let shared = ToastQueue()

  private let window: ToastWindow
  private var isProcessing = false
  private var pending = [Toast]()

  private init() {
    if #available(iOS 13.0, *) {
      let windowScene = UIApplication.shared.connectedScenes.filter {
        $0.activationState == .foregroundActive
      }.first
      if let windowScene = windowScene as? UIWindowScene {
        window = ToastWindow(windowScene: windowScene)
      } else {
        window = ToastWindow()
      }
    } else {
      window = ToastWindow()
    }
  }

  func enqueue(_ toast: Toast) {
    if isProcessing {
      pending.append(toast)
      return
    }
    isProcessing = true

    window.show(view: toast.body)
    toast.body.present { _ in
      toast.body.dismiss(delay: toast.duration) { _ in
        self.window.hide()
        self.isProcessing = false
        self.reduce()
      }
    }
  }

  private func reduce() {
    if pending.isEmpty { return }
    if isProcessing { return }
    enqueue(pending.removeLast())
  }
}

// MARK: - ToastWindow

final class ToastWindow: UIWindow {
  private var removedSubviews: [UIView] = []
  private let rootVC = UIViewController()
  private weak var currentView: UIView?
  private var keyboardWindowDidAppear = false

  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }

  @available(iOS 13.0, *)
  override init(windowScene: UIWindowScene) {
    super.init(windowScene: windowScene)
    setup()
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  deinit {
    NotificationCenter.default.removeObserver(
      self,
      name: UIWindow.keyboardWillShowNotification,
      object: nil
    )
    NotificationCenter.default.removeObserver(
      self,
      name: UIWindow.keyboardDidHideNotification,
      object: nil
    )
  }

  private func setup() {
    rootVC.view.backgroundColor = .clear
    rootViewController = rootVC
    backgroundColor = .clear
    windowLevel = .init(.greatestFiniteMagnitude)

    NotificationCenter.default.addObserver(
      self,
      selector: #selector(onKeyboardWillShow),
      name: UIWindow.keyboardWillShowNotification,
      object: nil
    )
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(onKeyboardDidHide),
      name: UIWindow.keyboardDidHideNotification,
      object: nil
    )
  }

  @objc private func onKeyboardWillShow() {
    keyboardWindowDidAppear = true
    handleTopWindowAppear()
  }

  @objc private func onKeyboardDidHide() {
    removedSubviews.forEach(rootVC.view.fillSubview(_:))
    removedSubviews = []
    keyboardWindowDidAppear = false
  }

  private func handleTopWindowAppear() {
    // https://github.com/devxoul/Toaster/pull/155/files
    if let window = UIApplication.shared.windows.last(where: {
      keyboardWindowDidAppear || ($0.isOpaque && $0.windowLevel > windowLevel)
    }), window !== self {
      removedSubviews = rootVC.view.subviews
      removedSubviews.forEach(window.fillSubview(_:))
    }
  }

  func show(view: UIView) {
    rootVC.view.fillSubview(view)
    handleTopWindowAppear()
    isHidden = false
    currentView = view
  }

  func hide() {
    isHidden = true
    rootVC.view.subviews.forEach { $0.removeFromSuperview() }
    removedSubviews.forEach { $0.removeFromSuperview() }
    removedSubviews = []
  }

  override func hitTest(_ point: CGPoint, with event: UIEvent!) -> UIView? {
    if let currentView {
      currentView.hitTest(convert(point, to: currentView), with: event)
    } else {
      super.hitTest(point, with: event)
    }
  }
}

private extension UIView {
  func fillSubview(_ subview: UIView) {
    subview.translatesAutoresizingMaskIntoConstraints = false
    addSubview(subview)
    NSLayoutConstraint.activate([
      subview.leadingAnchor.constraint(equalTo: leadingAnchor),
      subview.trailingAnchor.constraint(equalTo: trailingAnchor),
      subview.topAnchor.constraint(equalTo: topAnchor),
      subview.bottomAnchor.constraint(equalTo: bottomAnchor),
    ])
  }
}

// MARK: - Styled Toast

public extension Toast {
  @available(iOS 11.0, *)
  init(text: String, duration: TimeInterval = 2) {
    self.init(body: ContentView(text: text), duration: duration)
  }

  @available(iOS 11.0, *)
  init(attributedText: NSAttributedString, duration: TimeInterval = 2) {
    self.init(
      body: ContentView(attributedText: attributedText),
      duration: duration
    )
  }

  @available(iOS 11.0, *)
  private final class ContentView: ToastContent {
    private let backgroundView = UIView()
    private var shadowLayer: CAShapeLayer?

    convenience init(text: String) {
      self.init(attributedText: NSAttributedString(string: text))
    }

    init(attributedText: NSAttributedString) {
      super.init(frame: .zero)

      let style: UIBlurEffect.Style
      let textColor: UIColor

      if #available(iOS 13.0, *) {
        textColor = .label
        style = .systemChromeMaterial
      } else {
        textColor = .black
        style = .prominent
      }

      let screenBounds = UIScreen.main.bounds
      let screenWidth = min(screenBounds.height, screenBounds.width)
      let maxWidth = min(screenWidth, 414) * 0.8

      backgroundView.translatesAutoresizingMaskIntoConstraints = false
      addSubview(backgroundView)
      NSLayoutConstraint.activate([
        backgroundView.centerXAnchor.constraint(equalTo: centerXAnchor),
        backgroundView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
        backgroundView.widthAnchor.constraint(lessThanOrEqualToConstant: maxWidth),
      ])

      let blurView = UIVisualEffectView(effect: UIBlurEffect(style: style))
      blurView.translatesAutoresizingMaskIntoConstraints = false
      blurView.layer.masksToBounds = true
      backgroundView.addSubview(blurView)
      NSLayoutConstraint.activate([
        blurView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor),
        blurView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor),
        blurView.topAnchor.constraint(equalTo: backgroundView.topAnchor),
        blurView.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor),
      ])

      let textLabel = UILabel()
      textLabel.translatesAutoresizingMaskIntoConstraints = false
      textLabel.attributedText = attributedText
      textLabel.textAlignment = .center
      textLabel.font = .preferredFont(forTextStyle: .footnote)
      textLabel.lineBreakMode = .byTruncatingTail
      textLabel.numberOfLines = 0
      textLabel.textColor = textColor

      let superview = blurView.contentView
      superview.addSubview(textLabel)
      NSLayoutConstraint.activate([
        textLabel.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: 20),
        textLabel.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -20),
        textLabel.topAnchor.constraint(equalTo: superview.topAnchor, constant: 12),
        textLabel.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -12),
      ])
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {
      super.draw(rect)

      let bounds = backgroundView.bounds
      let cornerRadius = bounds.height * 0.5

      backgroundView.layer.cornerRadius = cornerRadius
      backgroundView.subviews.forEach { view in
        view.layer.cornerRadius = cornerRadius
      }

      if let layer = shadowLayer {
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 10).cgPath
      } else {
        let layer = CAShapeLayer()
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 10).cgPath
        layer.shadowOffset = .zero
        layer.shadowRadius = 10
        layer.shadowOpacity = 1
        layer.shadowColor = UIColor.black.withAlphaComponent(0.3).cgColor
        backgroundView.layer.insertSublayer(layer, at: 0)

        shadowLayer = layer
      }
    }

    override func hitTest(_ point: CGPoint, with event: UIEvent!) -> UIView? {
      if backgroundView.frame.contains(point) {
        backgroundView
      } else {
        nil
      }
    }

    override func present(completion: @escaping (Bool) -> Void) {
      backgroundView.transform = .init(translationX: 0, y: -translateDistance)
      UIView.animate(withDuration: 0.25, animations: { [backgroundView] in
        backgroundView.transform = .identity
      }, completion: completion)
    }

    override func dismiss(delay: TimeInterval, completion: @escaping (Bool) -> Void) {
      let translationY = -translateDistance
      UIView.animate(
        withDuration: 0.25, delay: delay,
        options: .beginFromCurrentState, animations: { [backgroundView] in
          backgroundView.transform = .init(translationX: 0, y: translationY)
        },
        completion: completion
      )
    }

    private var translateDistance: CGFloat {
      (superview?.safeAreaInsets ?? safeAreaInsets).top + max(backgroundView.bounds.size.height, 44)
    }
  }
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, macCatalyst 13.0, *)
public extension Task {
  @discardableResult
  static func toast(
    priority: TaskPriority? = nil,
    operation: @escaping @Sendable () async throws -> Void
  ) -> Self
    where Success == Void, Failure == Never
  {
    .init(priority: priority) {
      do {
        try await operation()
      } catch {
        await MainActor.run {
          Toast(text: error.localizedDescription).show()
        }
      }
    }
  }

  @discardableResult
  static func detachedToast(
    priority: TaskPriority? = nil,
    operation: @escaping @Sendable () async throws -> Void
  ) -> Self
    where Success == Void, Failure == Never
  {
    .detached(priority: priority) {
      do {
        try await operation()
      } catch {
        await MainActor.run {
          Toast(text: error.localizedDescription).show()
        }
      }
    }
  }
}
