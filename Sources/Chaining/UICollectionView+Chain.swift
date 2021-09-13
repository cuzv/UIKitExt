import UIKit

extension UICollectionView {
  @discardableResult
  public func dataSource(_ source: UICollectionViewDataSource?) -> Self {
    dataSource = source
    return self
  }

  @discardableResult
  public func prefetchingEnabled(_ enabled: Bool) -> Self {
    isPrefetchingEnabled = enabled
    return self
  }

  @discardableResult
  public func prefetchDataSource(
    _ source: UICollectionViewDataSourcePrefetching?
  ) -> Self {
    prefetchDataSource = source
    return self
  }

  @discardableResult
  public func delegate(_ value: UICollectionViewDelegate?) -> Self {
    delegate = value
    return self
  }

  @discardableResult
  public func backgroundView(_ view: UIView?) -> Self {
    backgroundView = view
    return self
  }

  @discardableResult
  public func collectionViewLayout(
    _ layout: UICollectionViewLayout,
    animated: Bool
  ) -> Self {
    setCollectionViewLayout(layout, animated: animated)
    return self
  }

  @available(iOS 11.0, *)
  @discardableResult
  public func dragDelegate(_ delegate: UICollectionViewDragDelegate?) -> Self {
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
  public func dropDelegate(_ delegate: UICollectionViewDropDelegate?) -> Self {
    dropDelegate = delegate
    return self
  }

  @available(iOS 11.0, *)
  @discardableResult
  public func reorderingCadence(_ cadence: ReorderingCadence) -> Self {
    reorderingCadence = cadence
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

  @available(iOS 14.0, *)
  @discardableResult
  public func allowsSelectionDuringEditing(_ allows: Bool) -> Self {
    allowsSelectionDuringEditing = allows
    return self
  }

  @available(iOS 14.0, *)
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

  @available(iOS 14.0, *)
  @discardableResult
  public func editing(_ editing: Bool) -> Self {
    isEditing = editing
    return self
  }

  @discardableResult
  public func remembersLastFocusedIndexPath(_ remembers: Bool) -> Self {
    remembersLastFocusedIndexPath = remembers
    return self
  }
}
