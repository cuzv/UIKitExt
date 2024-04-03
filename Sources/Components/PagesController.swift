import UIKit

open class PagesController: UIPageViewController {
  public let pages: [UIViewController]
  open var onSelect: ((Int) -> Void)?

  public init(
    transitionStyle style: UIPageViewController.TransitionStyle = .scroll,
    navigationOrientation orientation: UIPageViewController.NavigationOrientation = .horizontal,
    options: [UIPageViewController.OptionsKey: Any]? = nil,
    pages: [UIViewController]
  ) {
    self.pages = pages
    super.init(
      transitionStyle: style,
      navigationOrientation: orientation,
      options: options
    )
  }

  @available(*, unavailable)
  public required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override open func viewDidLoad() {
    super.viewDidLoad()
    dataSource = self
    delegate = self
    setViewControllers([pages[0]], direction: .forward, animated: false)
  }
}

extension PagesController: UIPageViewControllerDataSource {
  public func pageViewController(
    _: UIPageViewController,
    viewControllerBefore viewController: UIViewController
  ) -> UIViewController? {
    if let index = pages.firstIndex(of: viewController), index != 0 {
      return pages[abs((index - 1) % pages.count)]
    }
    return nil
  }

  public func pageViewController(
    _: UIPageViewController,
    viewControllerAfter viewController: UIViewController
  ) -> UIViewController? {
    if let index = pages.firstIndex(of: viewController), index != pages.count - 1 {
      return pages[abs((index + 1) % pages.count)]
    }
    return nil
  }
}

extension PagesController: UIPageViewControllerDelegate {
  public func pageViewController(
    _ pageViewController: UIPageViewController,
    didFinishAnimating finished: Bool,
    previousViewControllers: [UIViewController],
    transitionCompleted completed: Bool
  ) {
    if
      completed,
      let onSelect,
      let currentViewController = pageViewController.viewControllers?.first,
      let currentIndex = pages.firstIndex(of: currentViewController)
    {
      onSelect(currentIndex)
    }
  }
}
