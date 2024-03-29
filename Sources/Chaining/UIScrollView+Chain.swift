import UIKit

public extension UIScrollView {
  @discardableResult
  func delegate(_ value: UIScrollViewDelegate) -> Self {
    delegate = value
    return self
  }

  @discardableResult
  func contentSize(_ size: CGSize) -> Self {
    contentSize = size
    return self
  }

  @discardableResult
  func contentOffset(_ offset: CGPoint, animated: Bool = false) -> Self {
    contentOffset = offset
    return self
  }

  @discardableResult
  func contentInset(_ inset: UIEdgeInsets) -> Self {
    contentInset = inset
    return self
  }

  @available(iOS 11.0, *)
  @discardableResult
  func contentInsetAdjustmentBehavior(_ behavior: ContentInsetAdjustmentBehavior) -> Self {
    contentInsetAdjustmentBehavior = behavior
    return self
  }

  @discardableResult
  func scrollEnabled(_ enabled: Bool) -> Self {
    isScrollEnabled = enabled
    return self
  }

  @discardableResult
  func directionalLockEnabled(_ enabled: Bool) -> Self {
    isDirectionalLockEnabled = enabled
    return self
  }

  @discardableResult
  func pagingEnabled(_ enabled: Bool) -> Self {
    isPagingEnabled = enabled
    return self
  }

  @discardableResult
  func scrollsToTop(_ enabled: Bool) -> Self {
    scrollsToTop = enabled
    return self
  }

  @discardableResult
  func bounces(_ enabled: Bool) -> Self {
    bounces = enabled
    return self
  }

  @discardableResult
  func alwaysBounceVertical(_ enabled: Bool) -> Self {
    alwaysBounceVertical = enabled
    return self
  }

  @discardableResult
  func alwaysBounceHorizontal(_ enabled: Bool) -> Self {
    alwaysBounceHorizontal = enabled
    return self
  }

  @discardableResult
  func decelerationRate(_ rate: DecelerationRate) -> Self {
    decelerationRate = rate
    return self
  }

  @discardableResult
  func indicatorStyle(_ style: IndicatorStyle) -> Self {
    indicatorStyle = style
    return self
  }

  @discardableResult
  func showsHorizontalScrollIndicator(_ shows: Bool) -> Self {
    showsHorizontalScrollIndicator = shows
    return self
  }

  @discardableResult
  func showsVerticalScrollIndicator(_ shows: Bool) -> Self {
    showsVerticalScrollIndicator = shows
    return self
  }

  @available(iOS 11.1, *)
  @discardableResult
  func horizontalScrollIndicatorInsets(_ insets: UIEdgeInsets) -> Self {
    horizontalScrollIndicatorInsets = insets
    return self
  }

  @available(iOS 11.1, *)
  @discardableResult
  func verticalScrollIndicatorInsets(_ insets: UIEdgeInsets) -> Self {
    verticalScrollIndicatorInsets = insets
    return self
  }

  @available(iOS 13.0, *)
  @discardableResult
  func automaticallyAdjustsScrollIndicatorInsets(_ adjusts: Bool) -> Self {
    automaticallyAdjustsScrollIndicatorInsets = adjusts
    return self
  }

  @discardableResult
  func refreshControl(_ control: UIRefreshControl?) -> Self {
    refreshControl = control
    return self
  }

  @discardableResult
  func canCancelContentTouches(_ can: Bool) -> Self {
    canCancelContentTouches = can
    return self
  }

  @discardableResult
  func delaysContentTouches(_ delays: Bool) -> Self {
    delaysContentTouches = delays
    return self
  }

  @discardableResult
  func zoomScale(_ scale: CGFloat, animated: Bool = false) -> Self {
    setZoomScale(scale, animated: animated)
    return self
  }

  @discardableResult
  func maximumZoomScale(_ scale: CGFloat) -> Self {
    maximumZoomScale = scale
    return self
  }

  @discardableResult
  func minimumZoomScale(_ scale: CGFloat) -> Self {
    minimumZoomScale = scale
    return self
  }

  @discardableResult
  func bouncesZoom(_ bounces: Bool) -> Self {
    bouncesZoom = bounces
    return self
  }

  @discardableResult
  func keyboardDismissMode(_ mode: KeyboardDismissMode) -> Self {
    keyboardDismissMode = mode
    return self
  }

  @discardableResult
  func indexDisplayMode(_ mode: IndexDisplayMode) -> Self {
    indexDisplayMode = mode
    return self
  }
}

public extension UIScrollView {
  @discardableResult
  func addContentView(_ view: UIView, axis: NSLayoutConstraint.Axis = .vertical) -> Self {
    addSubview(
      view,
      layout: { proxy in
        proxy.edges == proxy.superview.edgesAnchor
        switch axis {
        case .horizontal:
          proxy.height == proxy.superview.heightAnchor
        case .vertical:
          proxy.width == proxy.superview.widthAnchor
        @unknown default:
          proxy.width == proxy.superview.widthAnchor
        }
      }
    )
  }
}
