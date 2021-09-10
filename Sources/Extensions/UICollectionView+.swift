import UIKit

extension UICollectionView {
  @available(iOS 11.0, tvOS 11.0, macCatalyst 11.0, *)
  public convenience init(
    layout: UICollectionViewLayout,
    backgroundColor: UIColor? = nil,
    showsHorizontalScrollIndicator: Bool = false,
    showsVerticalScrollIndicator: Bool = true,
    alwaysBounceHorizontal: Bool = false,
    alwaysBounceVertical: Bool = true,
    contentInsetAdjustmentBehavior: ContentInsetAdjustmentBehavior = .never,
    clipsToBounds: Bool = true
  ) {
    self.init(frame: .zero, collectionViewLayout: layout)
    self.backgroundColor = backgroundColor
    self.showsHorizontalScrollIndicator = showsHorizontalScrollIndicator
    self.showsVerticalScrollIndicator = showsVerticalScrollIndicator
    self.alwaysBounceHorizontal = alwaysBounceHorizontal
    self.alwaysBounceVertical = alwaysBounceVertical
    self.contentInsetAdjustmentBehavior = contentInsetAdjustmentBehavior
    self.clipsToBounds = clipsToBounds
    self.translatesAutoresizingMaskIntoConstraints = false
  }
}

extension UICollectionView {
  func cv_scrollToTail(animated: Bool = true) {
    let sectionCount = numberOfSections
    let lastSectionIndex = sectionCount - 1

    if 0 ..< sectionCount ~= lastSectionIndex {
      let itemCount = numberOfItems(inSection: lastSectionIndex)
      let lastItemIndex = itemCount - 1

      if 0 ..< itemCount ~= lastItemIndex {
        let lastIndexpath = IndexPath(item: lastItemIndex, section: lastSectionIndex)

        assert(collectionViewLayout is UICollectionViewFlowLayout, "Only supports on UICollectionViews have a UICollectionViewFlowLayout")
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        let position: ScrollPosition = layout.scrollDirection == .horizontal ? .right : .bottom

        scrollToItem(at: lastIndexpath, at: position, animated: animated)
      }
    }
  }

  public func reloadVisibleItems() {
    reloadItems(at: indexPathsForVisibleItems)
  }

  public func deselectVisibleItems(animated: Bool = true) {
    indexPathsForVisibleItems
      .map({ ($0, animated) })
      .forEach(deselectItem(at:animated:))
  }

  private var indexPathsForAll: LazySequence<FlattenSequence<LazyMapSequence<(Range<Int>), LazyMapSequence<(Range<Int>), IndexPath>>>> {
    (0 ..< numberOfSections)
      .lazy
      .flatMap { section in
        (0 ..< self.numberOfItems(inSection: section))
          .lazy
          .map({ (section, $0) })
          .map(IndexPath.init(item:section:))
      }
  }

  public func selectAllItems(animated: Bool = false, scrollPosition: ScrollPosition = []) {
    indexPathsForAll
      .map({ ($0, animated, scrollPosition) })
      .forEach(selectItem(at:animated:scrollPosition:))
  }

  public func deselectSelectedItems(animated: Bool = false) {
    indexPathsForSelectedItems?
      .map({ ($0, animated) })
      .forEach(deselectItem(at:animated:))
  }

  public var isAllSelected: Bool {
    if let count = indexPathsForSelectedItems?.count {
      return count == (0 ..< numberOfSections)
        .lazy
        .map(numberOfItems(inSection:))
        .reduce(0, +)
    }
    return false
  }
}

extension UICollectionView {
  public func calculateSize(
    forDeployedCell cell: UICollectionViewCell,
    sectionInset: UIEdgeInsets? = nil
  ) -> CGSize {
    cell.layoutIfNeeded()

    let sectionInset = sectionInset ??
      (collectionViewLayout as? UICollectionViewFlowLayout)?.sectionInset ??
      .zero

    let fixedWith = bounds
      .inset(by: contentInset)
      .inset(by: sectionInset)
      .width

    let calculatedSize = cell.contentView.systemLayoutSizeFitting(
      .init(width: fixedWith, height: UIView.layoutFittingCompressedSize.height),
      withHorizontalFittingPriority: .required,
      verticalFittingPriority: .fittingSizeLevel
    )

    return calculatedSize
  }
}
