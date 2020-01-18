import UIKit

public protocol MultipleSelectable {
    func setMultipleSelection(enabled: Bool, animated: Bool)
}

extension UICollectionView: MultipleSelectable {
    @nonobjc private static var multipleSelectionEnabledKey: Void?

    public var isMultipleSelectionEnabled: Bool {
        objc_getAssociatedObject(self, &UICollectionView.multipleSelectionEnabledKey) as? Bool ?? false
    }

    public func setMultipleSelection(enabled: Bool, animated: Bool) {
        objc_setAssociatedObject(self, &UICollectionView.multipleSelectionEnabledKey, enabled, .OBJC_ASSOCIATION_ASSIGN)

        visibleCells
            .lazy
            .compactMap {
                $0 as? MultipleSelectable
            }
            .forEach {
                $0.setMultipleSelection(enabled: enabled, animated: animated)
            }

        if !enabled, let indexPaths = indexPathsForSelectedItems {
            indexPaths
                .map({ ($0, animated) })
                .forEach(deselectItem(at:animated:))
        }
    }
}
