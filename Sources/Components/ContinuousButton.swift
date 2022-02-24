#if !(os(iOS) && (arch(i386) || arch(arm)))

import UIKit
import Combine

@available(iOS 13.0, *)
public final class ContinuousButton: UIButton {
  private var subscription: AnyCancellable?

  public override var isEnabled: Bool {
    didSet {
      if !isEnabled {
        cancelTask()
      }
    }
  }

  public override var isUserInteractionEnabled: Bool {
    didSet {
      if !isUserInteractionEnabled {
        cancelTask()
      }
    }
  }

  deinit {
    cancelTask()
  }

  public override init(frame: CGRect) {
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
      name: UIApplication.willResignActiveNotification, object: nil)
    NotificationCenter.default.addObserver(
      self, selector: #selector(cancelTask),
      name: UIApplication.didEnterBackgroundNotification, object: nil)

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
        guard let self = self else { return }
        self.removeTarget(self, action: #selector(self.scheduleTask), for: .touchDown)
        self.sendActions(for: .touchDown)
        self.addTarget(self, action: #selector(self.scheduleTask), for: .touchDown)
      }
  }
}

#endif
