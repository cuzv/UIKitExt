import UIKit

public extension UICollectionView {
  @discardableResult
  func dataSource(_ source: UICollectionViewDataSource?) -> Self {
    dataSource = source
    return self
  }

  @discardableResult
  func prefetchingEnabled(_ enabled: Bool) -> Self {
    isPrefetchingEnabled = enabled
    return self
  }

  @discardableResult
  func prefetchDataSource(
    _ source: UICollectionViewDataSourcePrefetching?
  ) -> Self {
    prefetchDataSource = source
    return self
  }

  @discardableResult
  func delegate(_ value: UICollectionViewDelegate?) -> Self {
    delegate = value
    return self
  }

  @discardableResult
  func backgroundView(_ view: UIView?) -> Self {
    backgroundView = view
    return self
  }

  @discardableResult
  func collectionViewLayout(
    _ layout: UICollectionViewLayout,
    animated: Bool
  ) -> Self {
    setCollectionViewLayout(layout, animated: animated)
    return self
  }

  @available(iOS 11.0, *)
  @discardableResult
  func dragDelegate(_ delegate: UICollectionViewDragDelegate?) -> Self {
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
  func dropDelegate(_ delegate: UICollectionViewDropDelegate?) -> Self {
    dropDelegate = delegate
    return self
  }

  @available(iOS 11.0, *)
  @discardableResult
  func reorderingCadence(_ cadence: ReorderingCadence) -> Self {
    reorderingCadence = cadence
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

  @available(iOS 14.0, *)
  @discardableResult
  func allowsSelectionDuringEditing(_ allows: Bool) -> Self {
    allowsSelectionDuringEditing = allows
    return self
  }

  @available(iOS 14.0, *)
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

  @available(iOS 14.0, *)
  @discardableResult
  func editing(_ editing: Bool) -> Self {
    isEditing = editing
    return self
  }

  @discardableResult
  func remembersLastFocusedIndexPath(_ remembers: Bool) -> Self {
    remembersLastFocusedIndexPath = remembers
    return self
  }
}
