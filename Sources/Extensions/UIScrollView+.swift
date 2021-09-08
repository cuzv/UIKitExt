import UIKit
import CoreGraphics

extension UIScrollView {
  public var insetTop: CGFloat {
    get { contentInset.top }
    set {
      var inset = contentInset
      inset.top = newValue
      contentInset = inset
    }
  }

  public var insetLeft: CGFloat {
    get { contentInset.left }
    set {
      var inset = contentInset
      inset.left = newValue
      contentInset = inset
    }
  }

  public var insetBottom: CGFloat {
    get { contentInset.bottom }
    set {
      var inset = contentInset
      inset.bottom = newValue
      contentInset = inset
    }
  }

  public var insetRight: CGFloat {
    get { contentInset.right }
    set {
      var inset = contentInset
      inset.right = newValue
      contentInset = inset
    }
  }

  public var scrollIndicatorInsetTop: CGFloat {
    get { scrollIndicatorInsets.top }
    set {
      var inset = scrollIndicatorInsets
      inset.top = newValue
      scrollIndicatorInsets = inset
    }
  }

  public var scrollIndicatorInsetLeft: CGFloat {
    get { scrollIndicatorInsets.left }
    set {
      var inset = scrollIndicatorInsets
      inset.left = newValue
      scrollIndicatorInsets = inset
    }
  }

  public var scrollIndicatorInsetBottom: CGFloat {
    get { scrollIndicatorInsets.bottom }
    set {
      var inset = scrollIndicatorInsets
      inset.bottom = newValue
      scrollIndicatorInsets = inset
    }
  }

  public var scrollIndicatorInsetRight: CGFloat {
    get { scrollIndicatorInsets.right }
    set {
      var inset = scrollIndicatorInsets
      inset.right = newValue
      scrollIndicatorInsets = inset
    }
  }

  public var offsetX: CGFloat {
    get { contentOffset.x }
    set {
      var offset = contentOffset
      offset.x = newValue
      contentOffset = offset
    }
  }

  public var offsetY: CGFloat {
    get { contentOffset.y }
    set {
      var offset = contentOffset
      offset.y = newValue
      contentOffset = offset
    }
  }

  public var contentWidth: CGFloat {
    get { contentSize.width }
    set {
      var size = contentSize
      size.width = newValue
      contentSize = size
    }
  }

  public var contentHeight: CGFloat {
    get { contentSize.height }
    set {
      var size = contentSize
      size.height = newValue
      contentSize = size
    }
  }
}

extension UIScrollView {
  public func scrollToHead(animated: Bool = true) {
    scrollRectToVisible(.zero, animated: animated)
  }

  public func scrollToTail(animated: Bool = true) {
    if let collectionView = self as? UICollectionView {
      collectionView.cv_scrollToTail(animated: animated)
    } else if let tableView = self as? UITableView {
      tableView.tv_scrollToTail(animated: animated)
    } else {
      scrollRectToVisible(CGRect(origin: CGPoint(x: 0, y: contentSize.height), size: .zero), animated: animated)
    }
  }
}
