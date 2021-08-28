import UIKit

extension UIStackView {
    public convenience init(
        axis: NSLayoutConstraint.Axis,
        alignment: UIStackView.Alignment = .fill,
        distribution: UIStackView.Distribution = .fill,
        spacing: CGFloat = 0
    ) {
        self.init()
        self.axis = axis
        self.alignment = alignment
        self.distribution = distribution
        self.spacing = spacing
        self.translatesAutoresizingMaskIntoConstraints = false
    }

    public func addArrangedSubviews(_ views: UIView...) {
        views.forEach(addArrangedSubview(_:))
    }

    public func removeArrangedSubviews(_ views: UIView...) {
        views.forEach(removeArrangedSubview(_:))
    }
}
