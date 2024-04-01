import UIKit

// MARK: - TableViewDiffableDataSourceProvider

@available(iOS 13.0, tvOS 13.0, *)
public protocol TableViewDiffableDataSourceProvider {
  associatedtype Model: Hashable
  associatedtype Element: Hashable

  typealias Section = SectionModel<Model, Element>
  typealias DataSource = UITableViewDiffableDataSource<Section, Element>
  typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Element>

  var tableView: UITableView { get }
  var dataSource: DataSource! { get }
}

@available(iOS 13.0, tvOS 13.0, *)
public extension TableViewDiffableDataSourceProvider {
  func apply(sections: [Section]) {
    var snapshot = Snapshot()
    snapshot.appendSections(sections)
    for section in sections {
      snapshot.appendItems(section.elements, toSection: section)
    }
    dataSource.apply(snapshot, animatingDifferences: tableView.window != nil)
  }
}

// MARK: - CollectionViewDiffableDataSourceProvider

@available(iOS 13.0, tvOS 13.0, *)
public protocol CollectionViewDiffableDataSourceProvider {
  associatedtype Model: Hashable
  associatedtype Element: Hashable

  typealias Section = SectionModel<Model, Element>
  typealias DataSource = UICollectionViewDiffableDataSource<Section, Element>
  typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Element>

  var collectionView: UICollectionView { get }
  var dataSource: DataSource! { get }
}

@available(iOS 13.0, tvOS 13.0, *)
public extension CollectionViewDiffableDataSourceProvider {
  func apply(sections: [Section]) {
    var snapshot = Snapshot()
    snapshot.appendSections(sections)
    for section in sections {
      snapshot.appendItems(section.elements, toSection: section)
    }
    dataSource.apply(snapshot, animatingDifferences: collectionView.window != nil)
  }

  func updateTransition(with coordinator: UIViewControllerTransitionCoordinator) {
    coordinator.animate(alongsideTransition: { [layout = collectionView.collectionViewLayout] context in
      layout.invalidateLayout()
    }, completion: nil)
  }
}
