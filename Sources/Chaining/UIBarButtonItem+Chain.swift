import UIKit

public extension UIBarButtonItem {
  @discardableResult
  func target(_ object: AnyObject?) -> Self {
    target = object
    return self
  }

  @discardableResult
  func action(_ value: Selector?) -> Self {
    action = value
    return self
  }

  @discardableResult
  func style(_ value: Style) -> Self {
    style = value
    return self
  }

  @discardableResult
  func possibleTitles(_ elements: Set<String>?) -> Self {
    possibleTitles = elements
    return self
  }

  @discardableResult
  func width(_ value: CGFloat) -> Self {
    width = value
    return self
  }

  @discardableResult
  func customView(_ view: UIView?) -> Self {
    customView = view
    return self
  }

  @available(iOS 14.0, *)
  @discardableResult
  func menu(_ view: UIMenu?) -> Self {
    menu = view
    return self
  }

  @available(iOS 14.0, *)
  @discardableResult
  func primaryAction(_ action: UIAction?) -> Self {
    primaryAction = action
    return self
  }

  @discardableResult
  func tintColor(_ color: UIColor?) -> Self {
    tintColor = color
    return self
  }

  @discardableResult
  func backButtonBackgroundImage(
    _ backgroundImage: UIImage?,
    for state: UIControl.State = .normal,
    barMetrics: UIBarMetrics = .default
  ) -> Self {
    setBackButtonBackgroundImage(
      backgroundImage, for: state, barMetrics: barMetrics
    )
    return self
  }

  @discardableResult
  func backButtonTitlePositionAdjustment(
    _ adjustment: UIOffset,
    barMetrics: UIBarMetrics = .default
  ) -> Self {
    setBackButtonTitlePositionAdjustment(adjustment, for: barMetrics)
    return self
  }

  @discardableResult
  func backButtonBackgroundVerticalPositionAdjustment(
    _ adjustment: CGFloat,
    barMetrics: UIBarMetrics = .default
  ) -> Self {
    setBackButtonBackgroundVerticalPositionAdjustment(
      adjustment, for: barMetrics
    )
    return self
  }

  @discardableResult
  func backgroundVerticalPositionAdjustment(
    _ adjustment: CGFloat,
    barMetrics: UIBarMetrics = .default
  ) -> Self {
    setBackgroundVerticalPositionAdjustment(
      adjustment, for: barMetrics
    )
    return self
  }

  @discardableResult
  func backgroundImage(
    _ backgroundImage: UIImage?,
    for state: UIControl.State = .normal,
    barMetrics: UIBarMetrics = .default
  ) -> Self {
    setBackgroundImage(
      backgroundImage, for: state, barMetrics: barMetrics
    )
    return self
  }

  @discardableResult
  func backgroundImage(
    _ backgroundImage: UIImage?,
    for state: UIControl.State = .normal,
    style: UIBarButtonItem.Style = .plain,
    barMetrics: UIBarMetrics = .default
  ) -> Self {
    setBackgroundImage(
      backgroundImage, for: state, style: style, barMetrics: barMetrics
    )
    return self
  }

  @discardableResult
  func titlePositionAdjustment(
    _ adjustment: UIOffset,
    barMetrics: UIBarMetrics = .default
  ) -> Self {
    setTitlePositionAdjustment(adjustment, for: barMetrics)
    return self
  }
}
