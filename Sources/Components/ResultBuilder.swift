import UIKit

@resultBuilder
public enum ChildrenViewBuilder {
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

@resultBuilder
public enum ChildViewBuilder {
  public static func buildBlock(_ components: UIView) -> UIView {
    components
  }

  public static func buildEither(first component: UIView) -> UIView {
    component
  }

  public static func buildEither(second component: UIView) -> UIView {
    component
  }
}
