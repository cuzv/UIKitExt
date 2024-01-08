import UIKit

public enum Flex {
  public enum JustifyContent: Int, @unchecked Sendable {
    case leading
    case center
    case trailing
  }

  public typealias AlignItems = UIStackView.Alignment
}

public extension Flex {
  final class Column: UIStackView {
    public convenience init(
      justify: JustifyContent = .leading,
      align: AlignItems = .fill,
      spacing: CGFloat = 0,
      paddings: NSDirectionalEdgeInsets = .zero,
      @LayoutSpecBuilder content: () -> [UIView]
    ) {
      self.init(
        axis: .vertical,
        justify: justify,
        align: align,
        spacing: spacing,
        paddings: paddings,
        content: content
      )
    }
  }

  final class Row: UIStackView {
    public convenience init(
      justify: JustifyContent = .leading,
      align: AlignItems = .fill,
      spacing: CGFloat = 0,
      paddings: NSDirectionalEdgeInsets = .zero,
      @LayoutSpecBuilder content: () -> [UIView]
    ) {
      self.init(
        axis: .horizontal,
        justify: justify,
        align: align,
        spacing: spacing,
        paddings: paddings,
        content: content
      )
    }
  }
}

public extension UIStackView {
  convenience init(
    axis: NSLayoutConstraint.Axis,
    justify: Flex.JustifyContent = .leading,
    align: Flex.AlignItems = .fill,
    spacing: CGFloat = 0,
    paddings: NSDirectionalEdgeInsets = .zero,
    @Flex.LayoutSpecBuilder content: () -> [UIView]
  ) {
    self.init(
      axis: axis,
      alignment: align,
      distribution: .fill,
      spacing: spacing
    )
    translatesAutoresizingMaskIntoConstraints = false

    var leadingView: UIView?
    if [.trailing, .center].contains(justify) {
      let view = UIView().useConstraints()
      addArrangedSubview(view)
      leadingView = view
    }

    addArrangedSubviews(content())

    var trailingView: UIView?
    if [.leading, .center].contains(justify) {
      let view = UIView().useConstraints()
      addArrangedSubview(view)
      trailingView = view
    }

    if let leadingView, let trailingView {
      NSLayoutConstraint.activate(leadingView.widthAnchor.constraint(equalTo: trailingView.widthAnchor))
    }
  }
}

public extension Flex {
  @resultBuilder enum LayoutSpecBuilder {
    public static func buildBlock(_ components: [UIView]) -> [UIView] {
      components
    }

    public static func buildBlock(_ components: [UIView]...) -> [UIView] {
      components.flatMap { $0 }
    }

    public static func buildExpression(_ expression: UIView) -> [UIView] {
      [expression]
    }

    public static func buildExpression(_ expression: [UIView]) -> [UIView] {
      expression
    }

    public static func buildOptional(_ component: [UIView]?) -> [UIView] {
      component ?? []
    }

    public static func buildEither(first component: [UIView]) -> [UIView] {
      component
    }

    public static func buildEither(second component: [UIView]) -> [UIView] {
      component
    }
  }
}

public extension UIView {
  func inRow(
    justify: Flex.JustifyContent = .leading,
    align: Flex.AlignItems = .fill,
    spacing: CGFloat = 0,
    paddings: NSDirectionalEdgeInsets = .zero
  ) -> UIStackView {
    .init(
      axis: .horizontal,
      justify: justify,
      align: align,
      spacing: spacing,
      paddings: paddings
    ) {
      self
    }
  }

  func inHStack(
    justify: Flex.JustifyContent = .leading,
    align: Flex.AlignItems = .fill,
    spacing: CGFloat = 0,
    paddings: NSDirectionalEdgeInsets = .zero
  ) -> UIStackView {
    inRow(
      justify: justify,
      align: align,
      spacing: spacing,
      paddings: paddings
    )
  }

  func inColumn(
    justify: Flex.JustifyContent = .leading,
    align: Flex.AlignItems = .fill,
    spacing: CGFloat = 0,
    paddings: NSDirectionalEdgeInsets = .zero
  ) -> UIStackView {
    .init(
      axis: .vertical,
      justify: justify,
      align: align,
      spacing: spacing,
      paddings: paddings
    ) {
      self
    }
  }

  func inVStack(
    justify: Flex.JustifyContent = .leading,
    align: Flex.AlignItems = .fill,
    spacing: CGFloat = 0,
    paddings: NSDirectionalEdgeInsets = .zero
  ) -> UIStackView {
    inColumn(
      justify: justify,
      align: align,
      spacing: spacing,
      paddings: paddings
    )
  }

  func inStack(
    axis: NSLayoutConstraint.Axis,
    justify: Flex.JustifyContent = .leading,
    align: Flex.AlignItems = .fill,
    spacing: CGFloat = 0,
    paddings: NSDirectionalEdgeInsets = .zero
  ) -> UIStackView {
    .init(
      axis: axis,
      justify: justify,
      align: align,
      spacing: spacing,
      paddings: paddings
    ) {
      self
    }
  }
}
