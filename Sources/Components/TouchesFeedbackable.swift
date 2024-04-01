import UIKit

public protocol TouchesFeedbackable: AnyObject {
  var backgroundView: UIView? { get set }
  var feedbackView: UIView { get set }
  var touchesBeganDate: Date? { get set }
}

public extension TouchesFeedbackable where Self: UIView {
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

open class TouchesFeedbackView: UIView, TouchesFeedbackable {
  public var tapAction: ((TouchesFeedbackView) -> Void)?

  public var touchesBeganDate: Date?
  public var backgroundView: UIView?
  public var feedbackView: UIView = {
    let view = UIView()
    if #available(iOS 13.0, *) {
      view.backgroundColor = .secondarySystemBackground
    } else {
      view.backgroundColor = UIColor(red: 217 / 255.0, green: 217 / 255.0, blue: 217 / 255.0, alpha: 1)
    }
    view.alpha = 0
    return view
  }()

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
