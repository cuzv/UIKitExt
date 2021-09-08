import UIKit

// MARK: - Toast Basics

public struct Toast {
  let view: UIView
  let duration: TimeInterval

  public init(view: UIView, duration: TimeInterval = 2) {
    self.view = view
    self.duration = duration
  }

  public func show() {
    guard UIApplication.shared.applicationState == .active else { return }
    ToastQueue.shared.enqueue(self)
  }
}

final class ToastQueue {
  static let shared = ToastQueue()

  private let window: ToastWindow
  private var isProcessing = false
  private var pending = [Toast]()

  private init() {
    if #available(iOS 13.0, *) {
      let windowScene = UIApplication.shared.connectedScenes.filter { $0.activationState == .foregroundActive }.first
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

    window.show(view: toast.view)
    toast.view.alpha = 0
    UIView.animate(withDuration: 0.25) {
      toast.view.alpha = 1
    } completion: { _ in
      UIView.animate(withDuration: 0.25, delay: toast.duration, options: .beginFromCurrentState) {
        toast.view.alpha = 0
      } completion: { _ in
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
    NotificationCenter.default.removeObserver(self, name: UIWindow.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.removeObserver(self, name: UIWindow.keyboardDidHideNotification, object: nil)
  }

  private func setup() {
    rootVC.view.backgroundColor = .clear
    rootViewController = rootVC
    backgroundColor = .clear
    windowLevel = .init(.greatestFiniteMagnitude)

    NotificationCenter.default.addObserver(self, selector: #selector(onKeyboardWillShow), name: UIWindow.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(onKeyboardDidHide), name: UIWindow.keyboardDidHideNotification, object: nil)
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
    if let window = UIApplication.shared.windows.last(where: { keyboardWindowDidAppear || ($0.isOpaque && $0.windowLevel > windowLevel) }), window !== self {
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

// MARK: - Toast Convenience Methods

extension Toast {
  @available(iOS 11.0, *)
  public init(text: String, duration: TimeInterval = 2) {
    self.init(view: PlainContainerView(text: text), duration: duration)
  }

  @available(iOS 11.0, *)
  public init(attributedText: NSAttributedString, duration: TimeInterval = 2) {
    self.init(view: PlainContainerView(attributedText: attributedText), duration: duration)
  }

  @available(iOS 11.0, *)
  private final class PlainContainerView: UIView {
    private let textLabel: UILabel
    private let backgroundView: UIView

    convenience init(text: String) {
      self.init(attributedText: NSAttributedString(string: text))
    }

    init(attributedText: NSAttributedString) {
      textLabel = UILabel()
      textLabel.translatesAutoresizingMaskIntoConstraints = false
      textLabel.textAlignment = .left
      textLabel.font = .preferredFont(forTextStyle: .footnote)
      textLabel.lineBreakMode = .byTruncatingTail
      textLabel.numberOfLines = 0
      if #available(iOS 13.0, *) {
        textLabel.textColor = .systemBackground
      } else {
        textLabel.textColor = .white
      }
      textLabel.attributedText = attributedText

      backgroundView = UIView()
      backgroundView.translatesAutoresizingMaskIntoConstraints = false
      backgroundView.layer.cornerRadius = 6
      if #available(iOS 13.0, *) {
        backgroundView.backgroundColor = .label
      } else {
        backgroundView.backgroundColor = .black
      }

      super.init(frame: .zero)

      backgroundColor = .clear
      translatesAutoresizingMaskIntoConstraints = false

      addSubview(backgroundView)
      NSLayoutConstraint.activate([
        backgroundView.centerXAnchor.constraint(equalTo: centerXAnchor),
        backgroundView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -44),
        backgroundView.widthAnchor.constraint(lessThanOrEqualToConstant: 280),
      ])

      addSubview(textLabel)
      NSLayoutConstraint.activate([
        textLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 8),
        textLabel.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -8),
        textLabel.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 6),
        textLabel.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -6),
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
  }
}
