import UIKit

public extension UIStackView {
  convenience init(
    axis: NSLayoutConstraint.Axis,
    alignment: UIStackView.Alignment = .fill,
    distribution: UIStackView.Distribution = .fill,
    spacing: CGFloat = 0
  ) {
    self.init(
      axis: axis,
      alignment: alignment,
      distribution: distribution,
      spacing: spacing,
      paddings: .zero
    )
  }
}

public extension UIStackView {
  @available(iOS 11.0, tvOS 11.0, macCatalyst 11.0, *)
  convenience init(
    axis: NSLayoutConstraint.Axis,
    alignment: UIStackView.Alignment = .fill,
    distribution: UIStackView.Distribution = .fill,
    spacing: CGFloat = 0,
    paddings: NSDirectionalEdgeInsets = .zero
  ) {
    self.init()
    self.axis = axis
    self.alignment = alignment
    self.distribution = distribution
    self.spacing = spacing
    translatesAutoresizingMaskIntoConstraints = false
    directionalLayoutMargins = paddings
    isLayoutMarginsRelativeArrangement = paddings != .zero
  }
}
