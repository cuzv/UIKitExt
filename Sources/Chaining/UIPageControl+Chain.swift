import UIKit

extension UIPageControl {
  @discardableResult
  public func currentPage(_ page: Int) -> Self {
    currentPage = page
    return self
  }

  @discardableResult
  public func numberOfPages(_ page: Int) -> Self {
    numberOfPages = page
    return self
  }

  @discardableResult
  public func hidesForSinglePage(_ hides: Bool) -> Self {
    hidesForSinglePage = hides
    return self
  }

  @discardableResult
  public func pageIndicatorTintColor(_ color: UIColor?) -> Self {
    pageIndicatorTintColor = color
    return self
  }

  @discardableResult
  public func currentPageIndicatorTintColor(_ color: UIColor?) -> Self {
    currentPageIndicatorTintColor = color
    return self
  }

  @discardableResult
  public func defersCurrentPageDisplay(_ defers: Bool) -> Self {
    defersCurrentPageDisplay = defers
    return self
  }

  @available(iOS 14.0, *)
  @discardableResult
  public func backgroundStyle(_ style: BackgroundStyle ) -> Self {
    backgroundStyle = style
    return self
  }

  @available(iOS 14.0, *)
  @discardableResult
  public func allowsContinuousInteraction(_ allows: Bool) -> Self {
    allowsContinuousInteraction = allows
    return self
  }

  @available(iOS 14.0, *)
  @discardableResult
  public func preferredIndicatorImage(_ image: UIImage?) -> Self {
    preferredIndicatorImage = image
    return self
  }

  @available(iOS 14.0, *)
  @discardableResult
  public func indicatorImage(_ image: UIImage?, forPage page: Int) -> Self {
    setIndicatorImage(image, forPage: page)
    return self
  }
}
