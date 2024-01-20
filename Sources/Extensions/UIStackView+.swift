import UIKit

@available(iOS 11.0, tvOS 11.0, macCatalyst 11.0, *)
public extension UIStackView {
  convenience init(
    axis: NSLayoutConstraint.Axis,
    distribution: UIStackView.Distribution = .fill,
    alignment: UIStackView.Alignment = .fill,
    spacing: CGFloat = 0,
    paddings: NSDirectionalEdgeInsets = .zero
  ) {
    self.init()
    self.axis = axis
    self.distribution = distribution
    self.alignment = alignment
    self.spacing = spacing
    translatesAutoresizingMaskIntoConstraints = false
    directionalLayoutMargins = paddings
    isLayoutMarginsRelativeArrangement = paddings != .zero
  }

  convenience init(
    axis: NSLayoutConstraint.Axis,
    distribution: UIStackView.Distribution = .fill,
    alignment: UIStackView.Alignment = .fill,
    spacing: CGFloat = 0,
    paddings: NSDirectionalEdgeInsets = .zero,
    @Flex.LayoutSpecBuilder content: () -> [UIView]
  ) {
    self.init(
      axis: axis,
      distribution: distribution,
      alignment: alignment,
      paddings: paddings
    )
    for view in content() {
      addArrangedSubview(view)
    }
  }
}
