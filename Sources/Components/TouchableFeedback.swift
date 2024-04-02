import UIKit

// MARK: - TouchableFeedback

public protocol TouchableFeedback: AnyObject {
  var backgroundView: UIView? { get set }
  var feedbackView: UIView { get set }
  var touchesBeganDate: Date? { get set }
  var tapAction: ((TouchableFeedbackView) -> Void)? { get set }
}

public extension TouchableFeedback {
  @discardableResult
  func backgroundView(_ view: UIView?) -> Self {
    backgroundView = view
    return self
  }

  @discardableResult
  func feedbackView(_ view: UIView) -> Self {
    feedbackView = view
    return self
  }

  @discardableResult
  func tapAction(_ action: ((TouchableFeedbackView) -> Void)?) -> Self {
    tapAction = action
    return self
  }
}

// MARK: - TouchableFeedback & UIView

public extension TouchableFeedback where Self: UIView {
  func showFeedback() {
    touchesBeganDate = Date()
    UIView.animate(withDuration: 0.25) {
      self.feedbackView.alpha = 1
    }
  }

  func hideFeedback() {
    let delay = max(0, 0.25 - abs(touchesBeganDate?.timeIntervalSince(Date()) ?? 0))
    UIView.animate(withDuration: 0.25, delay: delay, options: [], animations: {
      self.feedbackView.alpha = 0
    }, completion: nil)
  }

  func layoutDidChange() {
    if feedbackView.superview == nil {
      insertSubview(feedbackView, at: 0)
      feedbackView.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
        feedbackView.leadingAnchor.constraint(equalTo: leadingAnchor),
        feedbackView.trailingAnchor.constraint(equalTo: trailingAnchor),
        feedbackView.topAnchor.constraint(equalTo: topAnchor),
        feedbackView.bottomAnchor.constraint(equalTo: bottomAnchor),
      ])
    }
    sendSubviewToBack(feedbackView)

    if let backgroundView {
      if backgroundView.superview == nil {
        insertSubview(backgroundView, at: 0)
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
          backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
          backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
          backgroundView.topAnchor.constraint(equalTo: topAnchor),
          backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
      }

      sendSubviewToBack(backgroundView)
    }
  }
}

// MARK: - TouchableFeedbackView

open class TouchableFeedbackView: UIView, TouchableFeedback {
  open var tapAction: ((TouchableFeedbackView) -> Void)?
  open var touchesBeganDate: Date?
  open var backgroundView: UIView?
  open var feedbackView = UIView()
    .backgroundColor(.secondaryBackground)
    .alpha(0)

  private var isCancelled = false

  override open func layoutSubviews() {
    super.layoutSubviews()
    layoutDidChange()
  }

  override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    isCancelled = false
    showFeedback()
  }

  override open func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    if let touch = touches.first {
      let position = touch.location(in: self)
      if !bounds.contains(position) {
        isCancelled = true
        hideFeedback()
      }
    }
  }

  override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    hideFeedback()
    if !isCancelled {
      tapAction?(self)
    }
  }

  override open func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    isCancelled = true
    hideFeedback()
  }
}
