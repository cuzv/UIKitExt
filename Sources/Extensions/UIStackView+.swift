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
}

extension UIStackView {
  @available(iOS 11.0, tvOS 11.0, macCatalyst 11.0, *)
  public convenience init(
    axis: NSLayoutConstraint.Axis,
    alignment: UIStackView.Alignment = .fill,
    distribution: UIStackView.Distribution = .fill,
    spacing: CGFloat = 0,
    paddings: NSDirectionalEdgeInsets = .init()
  ) {
    self.init()
    self.axis = axis
    self.alignment = alignment
    self.distribution = distribution
    self.spacing = spacing
    self.translatesAutoresizingMaskIntoConstraints = false
    self.directionalLayoutMargins = paddings
    self.isLayoutMarginsRelativeArrangement = paddings != .zero
  }
}
