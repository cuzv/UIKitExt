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

public enum FlexJustifyContent: Int, @unchecked Sendable {
  case leading
  case center
  case trailing
}

public typealias FlexAlignItems = UIStackView.Alignment

public extension UIView {
  func inHStack(
    justify: FlexJustifyContent = .leading,
    align: FlexAlignItems = .fill,
    spacing: CGFloat = 0,
    paddings: NSDirectionalEdgeInsets = .zero
  ) -> UIStackView {
    inStack(
      axis: .horizontal,
      justify: justify,
      align: align,
      spacing: spacing,
      paddings: paddings
    )
  }

  func inVStack(
    justify: FlexJustifyContent = .leading,
    align: FlexAlignItems = .fill,
    spacing: CGFloat = 0,
    paddings: NSDirectionalEdgeInsets = .zero
  ) -> UIStackView {
    inStack(
      axis: .vertical,
      justify: justify,
      align: align,
      spacing: spacing,
      paddings: paddings
    )
  }

  func inStack(
    axis: NSLayoutConstraint.Axis,
    justify: FlexJustifyContent = .leading,
    align: FlexAlignItems = .fill,
    spacing: CGFloat = 0,
    paddings: NSDirectionalEdgeInsets = .zero
  ) -> UIStackView {
    let stack = UIStackView(
      axis: axis,
      alignment: align,
      distribution: .equalSpacing,
      spacing: spacing,
      paddings: paddings
    )
    .useConstraints()

    if [.trailing, .center].contains(justify) {
      stack.addArrangedSubview(UIView().useConstraints())
    }

    stack.addArrangedSubview(self)

    if [.leading, .center].contains(justify) {
      stack.addArrangedSubview(UIView().useConstraints())
    }

    return stack
  }
}
