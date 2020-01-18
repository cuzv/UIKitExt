import UIKit

public protocol TouchesFeedbackable: class {
    var feedbackView: UIView { get }
    var highlightColor: UIColor { get set }
}

extension TouchesFeedbackable where Self: UIView {
    func onHighlight() {
        UIView.animate(withDuration: 0.25) {
            self.feedbackView.alpha = 1
        }
    }

    func onNormal() {
        UIView.animate(withDuration: 0.25) {
            self.feedbackView.alpha = 0
        }
    }

    func onLayout() {
        feedbackView.frame = bounds
        if feedbackView.superview == nil {
            addSubview(feedbackView)
            let color = highlightColor
            self.highlightColor = color
        }
        bringSubviewToFront(feedbackView)
    }
}

open class TouchesFeedbackView: UIView, TouchesFeedbackable {
    public let feedbackView: UIView = {
        let view = UIView()
        view.alpha = 0
        return view
    }()

    @IBInspectable open var highlightColor: UIColor = UIColor.black.withAlphaComponent(0.25) {
        didSet {
            feedbackView.backgroundColor = highlightColor
        }
    }

    open override func layoutSubviews() {
        super.layoutSubviews()
        onLayout()
    }

    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        onHighlight()
    }

    open override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    }

    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        onNormal()
    }

    open override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        onNormal()
    }
}
