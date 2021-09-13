import UIKit

extension UITableView {
  @discardableResult
  public func dataSource(_ source: UITableViewDataSource?) -> Self {
    dataSource = source
    return self
  }

  @discardableResult
  public func prefetchDataSource(
    _ source: UITableViewDataSourcePrefetching?
  ) -> Self {
    prefetchDataSource = source
    return self
  }

  @discardableResult
  public func delegate(_ value: UITableViewDelegate?) -> Self {
    delegate = value
    return self
  }

  @discardableResult
  public func tableHeaderView(_ view: UIView?) -> Self {
    tableHeaderView = view
    return self
  }

  @discardableResult
  public func tableFooterView(_ view: UIView?) -> Self {
    tableFooterView = view
    return self
  }

  @discardableResult
  public func backgroundView(_ view: UIView?) -> Self {
    backgroundView = view
    return self
  }

  @discardableResult
  public func rowHeight(_ height: CGFloat) -> Self {
    rowHeight = height
    return self
  }

  @discardableResult
  public func estimatedRowHeight(_ height: CGFloat) -> Self {
    estimatedRowHeight = height
    return self
  }

  @discardableResult
  public func cellLayoutMarginsFollowReadableWidth(_ follow: Bool) -> Self {
    cellLayoutMarginsFollowReadableWidth = follow
    return self
  }

  @available(iOS 11.0, *)
  @discardableResult
  public func insetsContentViewsToSafeArea(_ insets: Bool) -> Self {
    insetsContentViewsToSafeArea = insets
    return self
  }

  @discardableResult
  public func sectionHeaderHeight(_ height: CGFloat) -> Self {
    sectionHeaderHeight = height
    return self
  }

  @discardableResult
  public func sectionFooterHeight(_ height: CGFloat) -> Self {
    sectionFooterHeight = height
    return self
  }

  @discardableResult
  public func estimatedSectionHeaderHeight(_ height: CGFloat) -> Self {
    estimatedSectionHeaderHeight = height
    return self
  }

  @discardableResult
  public func estimatedSectionFooterHeight(_ height: CGFloat) -> Self {
    estimatedSectionFooterHeight = height
    return self
  }

  @discardableResult
  public func separatorStyle(_ style: UITableViewCell.SeparatorStyle) -> Self {
    separatorStyle = style
    return self
  }

  @discardableResult
  public func separatorColor(_ color: UIColor?) -> Self {
    separatorColor = color
    return self
  }

  @discardableResult
  public func separatorEffect(_ effect: UIVisualEffect?) -> Self {
    separatorEffect = effect
    return self
  }

  @discardableResult
  public func separatorInset(_ insets: UIEdgeInsets) -> Self {
    separatorInset = insets
    return self
  }

  @available(iOS 11.0, *)
  @discardableResult
  public func separatorInsetReference(_ reference: SeparatorInsetReference ) -> Self {
    separatorInsetReference = reference
    return self
  }

  @discardableResult
  public func allowsSelection(_ allows: Bool) -> Self {
    allowsSelection = allows
    return self
  }

  @discardableResult
  public func allowsMultipleSelection(_ allows: Bool) -> Self {
    allowsMultipleSelection = allows
    return self
  }

  @discardableResult
  public func allowsSelectionDuringEditing(_ allows: Bool) -> Self {
    allowsSelectionDuringEditing = allows
    return self
  }

  @discardableResult
  public func allowsMultipleSelectionDuringEditing(_ allows: Bool) -> Self {
    allowsMultipleSelectionDuringEditing = allows
    return self
  }

  @available(iOS 14.0, *)
  @discardableResult
  public func selectionFollowsFocus(_ follows: Bool) -> Self {
    selectionFollowsFocus = follows
    return self
  }

  @discardableResult
  public func sectionIndexMinimumDisplayRowCount(_ count: Int) -> Self {
    sectionIndexMinimumDisplayRowCount = count
    return self
  }

  @discardableResult
  public func sectionIndexColor(_ color: UIColor?) -> Self {
    sectionIndexColor = color
    return self
  }

  @discardableResult
  public func sectionIndexBackgroundColor(_ color: UIColor?) -> Self {
    sectionIndexBackgroundColor = color
    return self
  }

  @discardableResult
  public func sectionIndexTrackingBackgroundColor(_ color: UIColor?) -> Self {
    sectionIndexTrackingBackgroundColor = color
    return self
  }

  @available(iOS 11.0, *)
  @discardableResult
  public func dragDelegate(_ delegate: UITableViewDragDelegate?) -> Self {
    dragDelegate = delegate
    return self
  }

  @available(iOS 11.0, *)
  @discardableResult
  public func dragInteractionEnabled(_ enabled: Bool) -> Self {
    dragInteractionEnabled = enabled
    return self
  }

  @available(iOS 11.0, *)
  @discardableResult
  public func dropDelegate(_ delegate: UITableViewDropDelegate?) -> Self {
    dropDelegate = delegate
    return self
  }

  @discardableResult
  public func editing(_ editing: Bool, animated: Bool = false) -> Self {
    setEditing(editing, animated: animated)
    return self
  }

  @discardableResult
  public func remembersLastFocusedIndexPath(_ remembers: Bool) -> Self {
    remembersLastFocusedIndexPath = remembers
    return self
  }
}
