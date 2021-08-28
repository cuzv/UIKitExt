import UIKit

extension UITableView {
    @available(macOS 10.13, iOS 11.0, tvOS 11.0, watchOS 4.0, macCatalyst 13.0, *)
    public convenience init(
        style: UITableView.Style = .plain,
        backgroundColor: UIColor,
        alwaysBounceHorizontal: Bool = false,
        alwaysBounceVertical: Bool = true,
        showsHorizontalScrollIndicator: Bool = false,
        showsVerticalScrollIndicator: Bool = true,
        contentInsetAdjustmentBehavior: UIScrollView.ContentInsetAdjustmentBehavior = .never
    ) {
        self.init(frame: .zero, style: style)
        self.backgroundColor = backgroundColor
        self.clipsToBounds = true
        self.scrollsToTop = true
        self.bounces = true
        self.bouncesZoom = true
        self.alwaysBounceHorizontal = alwaysBounceHorizontal
        self.alwaysBounceVertical = alwaysBounceVertical
        self.showsHorizontalScrollIndicator = showsHorizontalScrollIndicator
        self.showsVerticalScrollIndicator = showsVerticalScrollIndicator
        self.contentInsetAdjustmentBehavior = contentInsetAdjustmentBehavior
        self.estimatedRowHeight = 0
        self.estimatedSectionFooterHeight = 0
        self.estimatedSectionHeaderHeight = 0
        self.layoutMargins = .zero
        self.separatorInset = .zero
        self.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: Double.leastNonzeroMagnitude))
        self.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: Double.leastNonzeroMagnitude))
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}

extension UITableView {
    func tv_scrollToTail(animated: Bool = true) {
        let section = numberOfSections - 1
        let lastIndexPath = IndexPath(item: numberOfRows(inSection: section) - 1, section: section)
        scrollToRow(at: lastIndexPath, at: .bottom, animated: animated)
    }

    @available(iOS 11.0, *)
    public func reloadVisibleRows(completion: ((Bool) -> Void)? = nil) {
        if let indexPaths = indexPathsForVisibleRows {
            performBatchUpdates({
                reloadRows(at: indexPaths, with: .automatic)
            }, completion: completion)
        }
    }

    public func deselectVisibleRows(animated: Bool = true) {
        indexPathsForVisibleRows?
            .map({ ($0, animated) })
            .forEach(deselectRow(at:animated:))
    }

    private var indexPathsForAll: LazySequence<FlattenSequence<LazyMapSequence<(Range<Int>), LazyMapSequence<(Range<Int>), IndexPath>>>> {
        (0 ..< numberOfSections)
            .lazy
            .flatMap { section in
                (0 ..< self.numberOfRows(inSection: section))
                    .lazy
                    .map({ (section, $0) })
                    .map(IndexPath.init(item:section:))
            }
    }

    public func selectAllRows(animated: Bool = false, scrollPosition: UITableView.ScrollPosition = .none) {
        indexPathsForAll
            .map({ ($0, animated, scrollPosition) })
            .forEach(selectRow(at:animated:scrollPosition:))
    }

    public func deselectSelectedRows(animated: Bool = false) {
        indexPathsForSelectedRows?
            .map({ ($0, animated) })
            .forEach(deselectRow(at:animated:))
    }

    public var isAllSelected: Bool {
        if let count = indexPathForSelectedRow?.count {
            return count == (0 ..< numberOfSections)
                .lazy
                .map(numberOfRows(inSection:))
                .reduce(0, +)
        }
        return false
    }

    public var sectionIndex: UIView? {
        subviews.filter { "\(Mirror(reflecting: $0).subjectType)" == "UITableViewIndex" }.last
    }
}

extension UITableView {
    public func calculateSize(
        forDeployedCell cell: UITableViewCell,
        sectionInset: UIEdgeInsets? = nil
    ) -> CGSize {
        cell.layoutIfNeeded()

        let sectionInset = sectionInset ?? .zero

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
