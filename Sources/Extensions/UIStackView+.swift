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
  public static func create(
    axis: NSLayoutConstraint.Axis,
    alignment: UIStackView.Alignment = .fill,
    distribution: UIStackView.Distribution = .fill,
    spacing: CGFloat = 0,
    margins: NSDirectionalEdgeInsets = .init()
  ) -> UIStackView {
    UIStackView(
      axis: axis, alignment: alignment,
      distribution: distribution, spacing: spacing)
    .useConstraints()
    .directionalLayoutMargins(margins)
    .layoutMarginsRelativeArrangement(true)
  }
}
