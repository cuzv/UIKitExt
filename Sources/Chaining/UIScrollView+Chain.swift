import UIKit

extension UIScrollView {
  @discardableResult
  public func contentSize(_ size: CGSize) -> Self {
    contentSize = size
    return self
  }

  @discardableResult
  public func contentOffset(_ offset: CGPoint, animated: Bool = false) -> Self {
    contentOffset = offset
    return self
  }

  @discardableResult
  public func contentInset(_ inset: UIEdgeInsets) -> Self {
    contentInset = inset
    return self
  }

  @available(iOS 11.0, *)
  @discardableResult
  public func contentInsetAdjustmentBehavior(_ behavior: ContentInsetAdjustmentBehavior) -> Self {
    contentInsetAdjustmentBehavior = behavior
    return self
  }

  @discardableResult
  public func scrollEnabled(_ enabled: Bool) -> Self {
    isScrollEnabled = enabled
    return self
  }

  @discardableResult
  public func directionalLockEnabled(_ enabled: Bool) -> Self {
    isDirectionalLockEnabled = enabled
    return self
  }

  @discardableResult
  public func pagingEnabled(_ enabled: Bool) -> Self {
    isPagingEnabled = enabled
    return self
  }

  @discardableResult
  public func scrollsToTopEnabled(_ enabled: Bool) -> Self {
    scrollsToTop = enabled
    return self
  }

  @discardableResult
  public func bounces(_ enabled: Bool) -> Self {
    bounces = enabled
    return self
  }

  @discardableResult
  public func alwaysBounceVertical(_ enabled: Bool) -> Self {
    alwaysBounceVertical = enabled
    return self
  }

  @discardableResult
  public func alwaysBounceHorizontal(_ enabled: Bool) -> Self {
    alwaysBounceHorizontal = enabled
    return self
  }

  @discardableResult
  public func decelerationRate(_ rate: DecelerationRate) -> Self {
    decelerationRate = rate
    return self
  }

  @discardableResult
  public func showsHorizontalScrollIndicator(_ shows: Bool) -> Self {
    showsHorizontalScrollIndicator = shows
    return self
  }

  @discardableResult
  public func showsVerticalScrollIndicator(_ shows: Bool) -> Self {
    showsVerticalScrollIndicator = shows
    return self
  }

  @discardableResult
  public func refreshControl(_ control: UIRefreshControl?) -> Self {
    refreshControl = control
    return self
  }

  @discardableResult
  public func canCancelContentTouches(_ can: Bool) -> Self {
    canCancelContentTouches = can
    return self
  }

  @discardableResult
  public func delaysContentTouches(_ delays: Bool) -> Self {
    delaysContentTouches = delays
    return self
  }

  @discardableResult
  public func maximumZoomScale(_ scale: CGFloat) -> Self {
    maximumZoomScale = scale
    return self
  }

  @discardableResult
  public func minimumZoomScale(_ scale: CGFloat) -> Self {
    minimumZoomScale = scale
    return self
  }

  @discardableResult
  public func bouncesZoom(_ bounces: Bool) -> Self {
    bouncesZoom = bounces
    return self
  }

  @available(iOS 13.0, *)
  @discardableResult
  public func automaticallyAdjustsScrollIndicatorInsets(_ adjusts: Bool) -> Self {
    automaticallyAdjustsScrollIndicatorInsets = adjusts
    return self
  }

  @available(iOS 11.1, *)
  @discardableResult
  public func horizontalScrollIndicatorInsets(_ insets: UIEdgeInsets) -> Self {
    horizontalScrollIndicatorInsets = insets
    return self
  }

  @available(iOS 11.1, *)
  @discardableResult
  public func verticalScrollIndicatorInsets(_ insets: UIEdgeInsets) -> Self {
    verticalScrollIndicatorInsets = insets
    return self
  }
}
