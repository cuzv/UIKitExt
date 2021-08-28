import UIKit

public protocol TouchesFeedbackable: AnyObject {
    var backgroundView: UIView? { get set }
    var feedbackView: UIView { get set }
    var touchesBeganDate: Date? { get set }
}

extension TouchesFeedbackable where Self: UIView {
    public func showFeedback() {
        touchesBeganDate = Date()
        UIView.animate(withDuration: 0.25) {
            self.feedbackView.alpha = 1
        }
    }

    public func hideFeedback() {
        let delay = max(0, 0.25 - abs(touchesBeganDate?.timeIntervalSince(Date()) ?? 0))
        UIView.animate(withDuration: 0.25, delay: delay, options: [], animations: {
            self.feedbackView.alpha = 0
        }, completion: nil)
    }

    public func layoutDidChange() {
        if nil == feedbackView.superview {
            insertSubview(feedbackView, at: 0)
            feedbackView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                feedbackView.leadingAnchor.constraint(equalTo: leadingAnchor),
                feedbackView.trailingAnchor.constraint(equalTo: trailingAnchor),
                feedbackView.topAnchor.constraint(equalTo: topAnchor),
                feedbackView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
        }
        sendSubviewToBack(feedbackView)

        if let backgroundView = backgroundView {
            if nil == backgroundView.superview {
                insertSubview(backgroundView, at: 0)
                backgroundView.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
                    backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
                    backgroundView.topAnchor.constraint(equalTo: topAnchor),
                    backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor)
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
        view.backgroundColor = UIColor(red: 217 / 255.0, green: 217 / 255.0, blue: 217 / 255.0, alpha: 1)
        view.alpha = 0
        return view
    }()

    open override func layoutSubviews() {
        super.layoutSubviews()
        layoutDidChange()
    }

    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        showFeedback()
    }

    open override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    }

    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        hideFeedback()
        tapAction?(self)
    }

    open override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        hideFeedback()
    }
}
