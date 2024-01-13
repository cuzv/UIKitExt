import UIKit

public extension UITableView {
  @discardableResult
  func dataSource(_ source: UITableViewDataSource?) -> Self {
    dataSource = source
    return self
  }

  @discardableResult
  func prefetchDataSource(
    _ source: UITableViewDataSourcePrefetching?
  ) -> Self {
    prefetchDataSource = source
    return self
  }

  @discardableResult
  func delegate(_ value: UITableViewDelegate?) -> Self {
    delegate = value
    return self
  }

  @discardableResult
  func tableHeaderView(_ view: UIView?) -> Self {
    tableHeaderView = view
    return self
  }

  @discardableResult
  func tableFooterView(_ view: UIView?) -> Self {
    tableFooterView = view
    return self
  }

  @discardableResult
  func backgroundView(_ view: UIView?) -> Self {
    backgroundView = view
    return self
  }

  @discardableResult
  func rowHeight(_ height: CGFloat) -> Self {
    rowHeight = height
    return self
  }

  @discardableResult
  func estimatedRowHeight(_ height: CGFloat) -> Self {
    estimatedRowHeight = height
    return self
  }

  @discardableResult
  func cellLayoutMarginsFollowReadableWidth(_ follow: Bool) -> Self {
    cellLayoutMarginsFollowReadableWidth = follow
    return self
  }

  @available(iOS 11.0, *)
  @discardableResult
  func insetsContentViewsToSafeArea(_ insets: Bool) -> Self {
    insetsContentViewsToSafeArea = insets
    return self
  }

  @discardableResult
  func sectionHeaderHeight(_ height: CGFloat) -> Self {
    sectionHeaderHeight = height
    return self
  }

  @discardableResult
  func sectionFooterHeight(_ height: CGFloat) -> Self {
    sectionFooterHeight = height
    return self
  }

  @discardableResult
  func estimatedSectionHeaderHeight(_ height: CGFloat) -> Self {
    estimatedSectionHeaderHeight = height
    return self
  }

  @discardableResult
  func estimatedSectionFooterHeight(_ height: CGFloat) -> Self {
    estimatedSectionFooterHeight = height
    return self
  }

  @discardableResult
  func separatorStyle(_ style: UITableViewCell.SeparatorStyle) -> Self {
    separatorStyle = style
    return self
  }

  @discardableResult
  func separatorColor(_ color: UIColor?) -> Self {
    separatorColor = color
    return self
  }

  @discardableResult
  func separatorEffect(_ effect: UIVisualEffect?) -> Self {
    separatorEffect = effect
    return self
  }

  @discardableResult
  func separatorInset(_ insets: UIEdgeInsets) -> Self {
    separatorInset = insets
    return self
  }

  @available(iOS 11.0, *)
  @discardableResult
  func separatorInsetReference(_ reference: SeparatorInsetReference) -> Self {
    separatorInsetReference = reference
    return self
  }

  @discardableResult
  func allowsSelection(_ allows: Bool) -> Self {
    allowsSelection = allows
    return self
  }

  @discardableResult
  func allowsMultipleSelection(_ allows: Bool) -> Self {
    allowsMultipleSelection = allows
    return self
  }

  @discardableResult
  func allowsSelectionDuringEditing(_ allows: Bool) -> Self {
    allowsSelectionDuringEditing = allows
    return self
  }

  @discardableResult
  func allowsMultipleSelectionDuringEditing(_ allows: Bool) -> Self {
    allowsMultipleSelectionDuringEditing = allows
    return self
  }

  @available(iOS 14.0, *)
  @discardableResult
  func selectionFollowsFocus(_ follows: Bool) -> Self {
    selectionFollowsFocus = follows
    return self
  }

  @discardableResult
  func sectionIndexMinimumDisplayRowCount(_ count: Int) -> Self {
    sectionIndexMinimumDisplayRowCount = count
    return self
  }

  @discardableResult
  func sectionIndexColor(_ color: UIColor?) -> Self {
    sectionIndexColor = color
    return self
  }

  @discardableResult
  func sectionIndexBackgroundColor(_ color: UIColor?) -> Self {
    sectionIndexBackgroundColor = color
    return self
  }

  @discardableResult
  func sectionIndexTrackingBackgroundColor(_ color: UIColor?) -> Self {
    sectionIndexTrackingBackgroundColor = color
    return self
  }

  @available(iOS 11.0, *)
  @discardableResult
  func dragDelegate(_ delegate: UITableViewDragDelegate?) -> Self {
    dragDelegate = delegate
    return self
  }

  @available(iOS 11.0, *)
  @discardableResult
  func dragInteractionEnabled(_ enabled: Bool) -> Self {
    dragInteractionEnabled = enabled
    return self
  }

  @available(iOS 11.0, *)
  @discardableResult
  func dropDelegate(_ delegate: UITableViewDropDelegate?) -> Self {
    dropDelegate = delegate
    return self
  }

  @discardableResult
  func editing(_ editing: Bool, animated: Bool = false) -> Self {
    setEditing(editing, animated: animated)
    return self
  }

  @discardableResult
  func remembersLastFocusedIndexPath(_ remembers: Bool) -> Self {
    remembersLastFocusedIndexPath = remembers
    return self
  }
}
