#if !(os(iOS) && (arch(i386) || arch(arm)))

import Combine
import UIKit

@available(iOS 13.0, *)
public final class ContinuousButton: UIButton {
  private var subscription: AnyCancellable?

  override public var isEnabled: Bool {
    didSet {
      if !isEnabled {
        cancelTask()
      }
    }
  }

  override public var isUserInteractionEnabled: Bool {
    didSet {
      if !isUserInteractionEnabled {
        cancelTask()
      }
    }
  }

  deinit {
    cancelTask()
  }

  override public init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }

  public required init?(coder: NSCoder) {
    super.init(coder: coder)
    setup()
  }

  private func setup() {
    NotificationCenter.default.addObserver(
      self, selector: #selector(cancelTask),
      name: UIApplication.willResignActiveNotification, object: nil
    )
    NotificationCenter.default.addObserver(
      self, selector: #selector(cancelTask),
      name: UIApplication.didEnterBackgroundNotification, object: nil
    )

    addTarget(self, action: #selector(cancelTask), for: [.touchUpInside, .touchUpOutside])
    addTarget(self, action: #selector(scheduleTask), for: .touchDown)
  }

  @objc private func cancelTask() {
    subscription?.cancel()
    subscription = nil
  }

  @objc private func scheduleTask() {
    cancelTask()

    subscription = Timer.publish(every: 0.2, tolerance: nil, on: .main, in: .common, options: nil)
      .autoconnect()
      .receive(on: DispatchQueue.main)
      .sink { [weak self] _ in
        guard let self else { return }
        removeTarget(self, action: #selector(scheduleTask), for: .touchDown)
        sendActions(for: .touchDown)
        addTarget(self, action: #selector(scheduleTask), for: .touchDown)
      }
  }
}

#endif
