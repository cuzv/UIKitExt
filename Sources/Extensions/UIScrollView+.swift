import CoreGraphics
import UIKit

public extension UIScrollView {
  @available(iOS 11.0, tvOS 11.0, macCatalyst 11.0, *)
  convenience init(
    contentInset: UIEdgeInsets,
    contentInsetAdjustmentBehavior: ContentInsetAdjustmentBehavior = .never,
    backgroundColor: UIColor? = nil,
    showsHorizontalScrollIndicator: Bool = false,
    showsVerticalScrollIndicator: Bool = true,
    alwaysBounceHorizontal: Bool = false,
    alwaysBounceVertical: Bool = true
  ) {
    self.init()
    self.contentInset = contentInset
    self.contentInsetAdjustmentBehavior = contentInsetAdjustmentBehavior
    self.backgroundColor = backgroundColor
    self.showsHorizontalScrollIndicator = showsHorizontalScrollIndicator
    self.showsVerticalScrollIndicator = showsVerticalScrollIndicator
    self.alwaysBounceHorizontal = alwaysBounceHorizontal
    self.alwaysBounceVertical = alwaysBounceVertical
    translatesAutoresizingMaskIntoConstraints = false
  }
}

public extension UIScrollView {
  var insetTop: CGFloat {
    get { contentInset.top }
    set {
      var inset = contentInset
      inset.top = newValue
      contentInset = inset
    }
  }

  var insetLeft: CGFloat {
    get { contentInset.left }
    set {
      var inset = contentInset
      inset.left = newValue
      contentInset = inset
    }
  }

  var insetBottom: CGFloat {
    get { contentInset.bottom }
    set {
      var inset = contentInset
      inset.bottom = newValue
      contentInset = inset
    }
  }

  var insetRight: CGFloat {
    get { contentInset.right }
    set {
      var inset = contentInset
      inset.right = newValue
      contentInset = inset
    }
  }

  var scrollIndicatorInsetTop: CGFloat {
    get { scrollIndicatorInsets.top }
    set {
      var inset = scrollIndicatorInsets
      inset.top = newValue
      scrollIndicatorInsets = inset
    }
  }

  var scrollIndicatorInsetLeft: CGFloat {
    get { scrollIndicatorInsets.left }
    set {
      var inset = scrollIndicatorInsets
      inset.left = newValue
      scrollIndicatorInsets = inset
    }
  }

  var scrollIndicatorInsetBottom: CGFloat {
    get { scrollIndicatorInsets.bottom }
    set {
      var inset = scrollIndicatorInsets
      inset.bottom = newValue
      scrollIndicatorInsets = inset
    }
  }

  var scrollIndicatorInsetRight: CGFloat {
    get { scrollIndicatorInsets.right }
    set {
      var inset = scrollIndicatorInsets
      inset.right = newValue
      scrollIndicatorInsets = inset
    }
  }

  var offsetX: CGFloat {
    get { contentOffset.x }
    set {
      var offset = contentOffset
      offset.x = newValue
      contentOffset = offset
    }
  }

  var offsetY: CGFloat {
    get { contentOffset.y }
    set {
      var offset = contentOffset
      offset.y = newValue
      contentOffset = offset
    }
  }

  var contentWidth: CGFloat {
    get { contentSize.width }
    set {
      var size = contentSize
      size.width = newValue
      contentSize = size
    }
  }

  var contentHeight: CGFloat {
    get { contentSize.height }
    set {
      var size = contentSize
      size.height = newValue
      contentSize = size
    }
  }
}

public extension UIScrollView {
  func scrollToHead(animated: Bool = true) {
    scrollRectToVisible(.zero, animated: animated)
  }

  func scrollToTail(animated: Bool = true) {
    if let collectionView = self as? UICollectionView {
      collectionView.cv_scrollToTail(animated: animated)
    } else if let tableView = self as? UITableView {
      tableView.tv_scrollToTail(animated: animated)
    } else {
      scrollRectToVisible(
        CGRect(origin: CGPoint(x: 0, y: contentSize.height), size: .zero),
        animated: animated
      )
    }
  }

  var isZoomed: Bool {
    zoomScale != minimumZoomScale
  }

  func centerContents() {
    var top: CGFloat = 0, left: CGFloat = 0
    if contentSize.height < bounds.height {
      top = (bounds.height - contentSize.height) * 0.5
    }
    if contentSize.width < bounds.width {
      left = (bounds.width - contentSize.width) * 0.5
    }
    contentInset = UIEdgeInsets(top: top, left: left, bottom: top, right: left)
  }

  var contentCenter: CGPoint {
    let (cWidth, cHeight) = (contentSize.width, contentSize.height)
    return CGPoint(
      x: cWidth + max(0, bounds.width - cWidth),
      y: cHeight + max(0, bounds.height - cHeight)
    ).applying(.init(scaleX: 0.5, y: 0.5))
  }
}
