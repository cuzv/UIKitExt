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
    if let currentView = currentView {
      return currentView.hitTest(convert(point, to: currentView), with: event)
    } else {
      return super.hitTest(point, with: event)
    }
  }
}

extension UIView {
  fileprivate func fillSubview(_ subview: UIView) {
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

extension Toast {
  @available(iOS 11.0, *)
  public init(text: String, duration: TimeInterval = 2) {
    self.init(body: ContentView(text: text), duration: duration)
  }

  @available(iOS 11.0, *)
  public init(attributedText: NSAttributedString, duration: TimeInterval = 2) {
    self.init(
      body: ContentView(attributedText: attributedText),
      duration: duration
    )
  }

  @available(iOS 11.0, *)
  private final class ContentView: ToastContent {
    private let backgroundView: UIVisualEffectView = {
      let style: UIBlurEffect.Style
      if #available(iOS 13.0, *) {
        style = .systemChromeMaterial
      } else {
        style = .prominent
      }
      return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }()

    convenience init(text: String) {
      self.init(attributedText: NSAttributedString(string: text))
    }

    init(attributedText: NSAttributedString) {
      super.init(frame: .zero)

      let textLabel = UILabel()
      textLabel.attributedText = attributedText
      textLabel.translatesAutoresizingMaskIntoConstraints = false
      textLabel.textAlignment = .left
      textLabel.font = .preferredFont(forTextStyle: .footnote)
      textLabel.lineBreakMode = .byTruncatingTail
      textLabel.numberOfLines = 0
      if #available(iOS 13.0, *) {
        textLabel.textColor = .label
      } else {
        textLabel.textColor = .white
        backgroundView.backgroundColor = .black
      }

      backgroundView.translatesAutoresizingMaskIntoConstraints = false
      backgroundView.layer.cornerRadius = 8
      backgroundView.layer.masksToBounds = true
      addSubview(backgroundView)
      NSLayoutConstraint.activate([
        backgroundView.centerXAnchor.constraint(equalTo: centerXAnchor),
        backgroundView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
        backgroundView.widthAnchor.constraint(lessThanOrEqualToConstant: 280),
      ])

      let superview = backgroundView.contentView
      superview.addSubview(textLabel)
      NSLayoutConstraint.activate([
        textLabel.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: 15),
        textLabel.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -15),
        textLabel.topAnchor.constraint(equalTo: superview.topAnchor, constant: 12),
        textLabel.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -12),
      ])
    }

    required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }

    override func hitTest(_ point: CGPoint, with event: UIEvent!) -> UIView? {
      if backgroundView.frame.contains(point) {
        return backgroundView
      } else {
        return nil
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
        }, completion: completion)
    }

    private var translateDistance: CGFloat {
      (superview?.safeAreaInsets ?? safeAreaInsets).top + max(backgroundView.bounds.size.height, 44)
    }
  }
}
