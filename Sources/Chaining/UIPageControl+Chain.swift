import UIKit

public extension UIPageControl {
  @discardableResult
  func currentPage(_ page: Int) -> Self {
    currentPage = page
    return self
  }

  @discardableResult
  func numberOfPages(_ page: Int) -> Self {
    numberOfPages = page
    return self
  }

  @discardableResult
  func hidesForSinglePage(_ hides: Bool) -> Self {
    hidesForSinglePage = hides
    return self
  }

  @discardableResult
  func pageIndicatorTintColor(_ color: UIColor?) -> Self {
    pageIndicatorTintColor = color
    return self
  }

  @discardableResult
  func currentPageIndicatorTintColor(_ color: UIColor?) -> Self {
    currentPageIndicatorTintColor = color
    return self
  }

  @discardableResult
  func defersCurrentPageDisplay(_ defers: Bool) -> Self {
    defersCurrentPageDisplay = defers
    return self
  }

  @available(iOS 14.0, *)
  @discardableResult
  func backgroundStyle(_ style: BackgroundStyle) -> Self {
    backgroundStyle = style
    return self
  }

  @available(iOS 14.0, *)
  @discardableResult
  func allowsContinuousInteraction(_ allows: Bool) -> Self {
    allowsContinuousInteraction = allows
    return self
  }

  @available(iOS 14.0, *)
  @discardableResult
  func preferredIndicatorImage(_ image: UIImage?) -> Self {
    preferredIndicatorImage = image
    return self
  }

  @available(iOS 14.0, *)
  @discardableResult
  func indicatorImage(_ image: UIImage?, forPage page: Int) -> Self {
    setIndicatorImage(image, forPage: page)
    return self
  }
}
