import UIKit

extension UIBarButtonItem {
  @discardableResult
  public func target(_ object: AnyObject?) -> Self {
    target = object
    return self
  }

  @discardableResult
  public func action(_ value: Selector?) -> Self {
    action = value
    return self
  }

  @discardableResult
  public func style(_ value: Style) -> Self {
    style = value
    return self
  }

  @discardableResult
  public func possibleTitles(_ elements: Set<String>?) -> Self {
    possibleTitles = elements
    return self
  }

  @discardableResult
  public func width(_ value: CGFloat) -> Self {
    width = value
    return self
  }

  @discardableResult
  public func customView(_ view: UIView?) -> Self {
    customView = view
    return self
  }

  @available(iOS 14.0, *)
  @discardableResult
  public func menu(_ view: UIMenu?) -> Self {
    menu = view
    return self
  }

  @available(iOS 14.0, *)
  @discardableResult
  public func primaryAction(_ action: UIAction?) -> Self {
    primaryAction = action
    return self
  }

  @discardableResult
  public func tintColor(_ color: UIColor?) -> Self {
    tintColor = color
    return self
  }

  @discardableResult
  public func backButtonBackgroundImage(
    _ backgroundImage: UIImage?,
    for state: UIControl.State = .normal,
    barMetrics: UIBarMetrics = .default
  ) -> Self {
    setBackButtonBackgroundImage(
      backgroundImage, for: state, barMetrics: barMetrics)
    return self
  }

  @discardableResult
  public func backButtonTitlePositionAdjustment(
    _ adjustment: UIOffset,
    barMetrics: UIBarMetrics = .default
  ) -> Self {
    setBackButtonTitlePositionAdjustment(adjustment, for: barMetrics)
    return self
  }

  @discardableResult
  public func backButtonBackgroundVerticalPositionAdjustment(
    _ adjustment: CGFloat,
    barMetrics: UIBarMetrics = .default
  ) -> Self {
    setBackButtonBackgroundVerticalPositionAdjustment(
      adjustment, for: barMetrics)
    return self
  }

  @discardableResult
  public func backgroundVerticalPositionAdjustment(
    _ adjustment: CGFloat,
    barMetrics: UIBarMetrics = .default
  ) -> Self {
    setBackgroundVerticalPositionAdjustment(
      adjustment, for: barMetrics)
    return self
  }

  @discardableResult
  public func backgroundImage(
    _ backgroundImage: UIImage?,
    for state: UIControl.State = .normal,
    barMetrics: UIBarMetrics = .default
  ) -> Self {
    setBackgroundImage(
      backgroundImage, for: state, barMetrics: barMetrics)
    return self
  }

  @discardableResult
  public func backgroundImage(
    _ backgroundImage: UIImage?,
    for state: UIControl.State = .normal,
    style: UIBarButtonItem.Style = .plain,
    barMetrics: UIBarMetrics = .default
  ) -> Self {
    setBackgroundImage(
      backgroundImage, for: state, style: style, barMetrics: barMetrics)
    return self
  }

  @discardableResult
  public func titlePositionAdjustment(
    _ adjustment: UIOffset,
    barMetrics: UIBarMetrics = .default
  ) -> Self {
    setTitlePositionAdjustment(adjustment, for: barMetrics)
    return self
  }
}
