import UIKit

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

    public func clearsSelection(animated: Bool = true) {
        indexPathsForSelectedRows?
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

    public func selectAll(animated: Bool = false, scrollPosition: UITableView.ScrollPosition = .none) {
        indexPathsForAll
            .map({ ($0, animated, scrollPosition) })
            .forEach(selectRow(at:animated:scrollPosition:))
    }

    public func deselectAll(animated: Bool = false) {
        indexPathsForAll
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
}
