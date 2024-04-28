import UIKit

public extension UITableView {
  @available(iOS 11.0, tvOS 11.0, macCatalyst 11.0, *)
  convenience init(
    style: UITableView.Style,
    backgroundColor: UIColor? = nil,
    alwaysBounceHorizontal: Bool = false,
    alwaysBounceVertical: Bool = true,
    showsHorizontalScrollIndicator: Bool = false,
    showsVerticalScrollIndicator: Bool = true,
    contentInsetAdjustmentBehavior: UIScrollView.ContentInsetAdjustmentBehavior = .never
  ) {
    self.init(frame: .zero, style: style)
    self.backgroundColor = backgroundColor
    self.alwaysBounceHorizontal = alwaysBounceHorizontal
    self.alwaysBounceVertical = alwaysBounceVertical
    self.showsHorizontalScrollIndicator = showsHorizontalScrollIndicator
    self.showsVerticalScrollIndicator = showsVerticalScrollIndicator
    self.contentInsetAdjustmentBehavior = contentInsetAdjustmentBehavior
    clipsToBounds = true
    scrollsToTop = true
    bounces = true
    bouncesZoom = true
    estimatedRowHeight = 0
    estimatedSectionFooterHeight = 0
    estimatedSectionHeaderHeight = 0
    layoutMargins = .zero
    separatorInset = .zero
    tableHeaderView = UIView(
      frame: CGRect(x: 0, y: 0, width: 0, height: Double.leastNonzeroMagnitude)
    )
    tableFooterView = UIView(
      frame: CGRect(x: 0, y: 0, width: 0, height: Double.leastNonzeroMagnitude)
    )
    translatesAutoresizingMaskIntoConstraints = false
  }
}

public extension UITableView {
  internal func tv_scrollToTail(animated: Bool = true) {
    let section = numberOfSections - 1
    let lastIndexPath = IndexPath(item: numberOfRows(inSection: section) - 1, section: section)
    scrollToRow(at: lastIndexPath, at: .bottom, animated: animated)
  }

  @available(iOS 11.0, *)
  func reloadVisibleRows(completion: ((Bool) -> Void)? = nil) {
    if let indexPaths = indexPathsForVisibleRows {
      performBatchUpdates({
        reloadRows(at: indexPaths, with: .automatic)
      }, completion: completion)
    }
  }

  func deselectVisibleRows(animated: Bool = true) {
    indexPathsForVisibleRows?
      .map { ($0, animated) }
      .forEach(deselectRow(at:animated:))
  }

  private var indexPathsForAll: LazySequence<FlattenSequence<LazyMapSequence<Range<Int>, LazyMapSequence<Range<Int>, IndexPath>>>> {
    (0 ..< numberOfSections)
      .lazy
      .flatMap { section in
        (0 ..< self.numberOfRows(inSection: section))
          .lazy
          .map { (section, $0) }
          .map(IndexPath.init(item:section:))
      }
  }

  func selectAllRows(animated: Bool = false, scrollPosition: UITableView.ScrollPosition = .none) {
    indexPathsForAll
      .map { ($0, animated, scrollPosition) }
      .forEach(selectRow(at:animated:scrollPosition:))
  }

  func deselectSelectedRows(animated: Bool = false) {
    indexPathsForSelectedRows?
      .map { ($0, animated) }
      .forEach(deselectRow(at:animated:))
  }

  var isAllSelected: Bool {
    if let count = indexPathForSelectedRow?.count {
      return count == (0 ..< numberOfSections)
        .lazy
        .map(numberOfRows(inSection:))
        .reduce(0, +)
    }
    return false
  }

  var sectionIndex: UIView? {
    subviews.filter { "\(Mirror(reflecting: $0).subjectType)" == "UITableViewIndex" }.last
  }
}

public extension UITableView {
  func layoutSize(
    for cell: UITableViewCell,
    sectionInset: UIEdgeInsets = .zero
  ) -> CGSize {
    super.layoutSize(for: cell, sectionInset: sectionInset)
  }
}
