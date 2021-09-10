import UIKit

extension UIButton {
  public convenience init(
    type buttonType: ButtonType = .system,
    title: String,
    titleColor: UIColor? = .foreground,
    backgroundColor: UIColor? = nil,
    font: UIFont? = nil,
    image: UIImage? = nil,
    backgroundImage: UIImage? = nil,
    showsTouchWhenHighlighted: Bool = false,
    layoutAxisAlignment: LayoutAxisAlignment? = nil,
    padding: UIEdgeInsets? = nil,
    contentSpacing: CGFloat? = nil
  ) {
    self.init(type: buttonType)
    self.setTitle(title, for: .normal)
    self.setTitleColor(titleColor, for: .normal)
    self.backgroundColor = backgroundColor
    self.titleLabel?.font = font
    self.setImage(image, for: .normal)
    self.setBackgroundImage(backgroundImage, for: .normal)
    self.showsTouchWhenHighlighted = showsTouchWhenHighlighted
    self.translatesAutoresizingMaskIntoConstraints = false
    if let value = layoutAxisAlignment { self.layoutAxisAlignment = value }
    if let value = padding { self.padding = value }
    if let value = contentSpacing { self.contentSpacing = value }
  }
}

private struct _UIButtonAssociatedKey {
  public static var layoutAxisAlignment: Void?
  public static var contentSpacing: Void?
  public static var padding: Void?
}

/// FYI: https://noahgilmore.com/blog/uibutton-padding/
/// FYI: http://shinancao.cn/2016/12/15/iOS-UIButton-EdgeInsets/
extension UIButton {
  public enum LayoutAxisAlignment: Int {
    case horizontalConventional     = 1
    case horizontalUnconventional   = 2
    case verticalConventional       = 4
    case verticalUnconventional     = 8
  }

  public var layoutAxisAlignment: LayoutAxisAlignment {
    get {
      objc_getAssociatedObject(self, &_UIButtonAssociatedKey.layoutAxisAlignment) as? LayoutAxisAlignment ?? .horizontalConventional
    }
    set {
      objc_setAssociatedObject(
        self,
        &_UIButtonAssociatedKey.layoutAxisAlignment,
        newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC
      )
      layoutDidChange()
    }
  }

  /// - horizontalConventional     = 1
  /// - horizontalUnconventional   = 2
  /// - verticalConventional       = 4
  /// - verticalUnconventional     = 8
  @IBInspectable public var layoutAxisAlignmentRawValue: Int {
    get { layoutAxisAlignment.rawValue }
    set { layoutAxisAlignment = LayoutAxisAlignment(rawValue: newValue) ?? .horizontalConventional }
  }

  @IBInspectable public var contentSpacing: CGFloat {
    get { objc_getAssociatedObject(self, &_UIButtonAssociatedKey.contentSpacing) as? CGFloat ?? 0.0 }
    set {
      objc_setAssociatedObject(
        self,
        &_UIButtonAssociatedKey.contentSpacing,
        newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC
      )
      layoutDidChange()
    }
  }

  public var padding: UIEdgeInsets {
    get { objc_getAssociatedObject(self, &_UIButtonAssociatedKey.padding) as? UIEdgeInsets ?? .zero }
    set {
      objc_setAssociatedObject(
        self,
        &_UIButtonAssociatedKey.padding,
        newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC
      )
      layoutDidChange()
    }
  }

  @IBInspectable public var paddingRectValue: CGRect {
    get {
      .init(
        x: padding.top,
        y: padding.left,
        width: padding.bottom,
        height: padding.right
      )
    }
    set {
      padding = .init(
        top: newValue.origin.x,
        left: newValue.origin.y,
        bottom: newValue.width,
        right: newValue.height
      )
    }
  }

  public func layoutDidChange() {
    let titleSize: CGSize
    if let font = titleLabel?.font,
       let size = currentTitle?.size(withAttributes: [.font: font]) {
      titleSize = size
    } else {
      titleSize = .zero
    }

    let imageSize = imageView?.image?.size ?? .zero

    if  titleSize == .zero && imageSize == .zero {
      return
    }

    let halfSpacing = contentSpacing * 0.5
    var contentMargin = padding

    let isR2LLayout = effectiveUserInterfaceLayoutDirection == .rightToLeft

    if isR2LLayout {
      let left = contentMargin.left
      contentMargin.left = contentMargin.right
      contentMargin.right = left
    }
    let factor: CGFloat = isR2LLayout ? -1 : 1

    switch layoutAxisAlignment {
    case .horizontalConventional:
      // H: |-(padding)-[image]-(spacing)-[title]-(padding)-|
      imageEdgeInsets = UIEdgeInsets(
        top: 0, left: -halfSpacing * factor,
        bottom: 0, right: halfSpacing * factor)
      titleEdgeInsets = UIEdgeInsets(
        top: 0, left: halfSpacing * factor,
        bottom: 0, right: -halfSpacing * factor)
      contentEdgeInsets = UIEdgeInsets(
        top: contentMargin.top, left: halfSpacing + contentMargin.left,
        bottom: contentMargin.bottom, right: halfSpacing + contentMargin.right)
    case .horizontalUnconventional:
      // H: |-(padding)-[title]-(spacing)-[image]-(padding)-|
      let imageWidth = imageSize.width
      let titleWidth = titleSize.width

      imageEdgeInsets = UIEdgeInsets(
        top: 0, left: (titleWidth + halfSpacing) * factor,
        bottom: 0, right: -(titleWidth + halfSpacing) * factor)
      titleEdgeInsets = UIEdgeInsets(
        top: 0, left: -(imageWidth + halfSpacing) * factor,
        bottom: 0, right: (imageWidth + halfSpacing) * factor)
      contentEdgeInsets = UIEdgeInsets(
        top: contentMargin.top, left: halfSpacing + contentMargin.left,
        bottom: contentMargin.bottom, right: halfSpacing + contentMargin.right)
    case .verticalConventional:
      // V: |-(padding)-[image]-(spacing)-[title]-(padding)-|
      let imageWidth = imageSize.width
      let titleWidth = titleSize.width
      let imageHeight = imageSize.height
      let titleHeight = titleSize.height

      imageEdgeInsets = UIEdgeInsets(
        top: -(titleHeight * 0.5 + halfSpacing),
        left: titleWidth * 0.5 * factor,
        bottom: titleHeight * 0.5 + halfSpacing,
        right: -(titleWidth * 0.5) * factor)
      titleEdgeInsets = UIEdgeInsets(
        top: imageHeight * 0.5 + halfSpacing,
        left: -(imageWidth * 0.5) * factor,
        bottom: -(imageHeight * 0.5 + halfSpacing),
        right: imageWidth * 0.5 * factor)

      let padding = min(imageWidth, titleWidth) * 0.5
      let margin = min(imageHeight, titleHeight) * 0.5

      contentEdgeInsets = UIEdgeInsets(
        top: contentMargin.top + margin + halfSpacing,
        left: contentMargin.left - padding,
        bottom: contentMargin.bottom + margin + halfSpacing,
        right: contentMargin.right - padding)
    case .verticalUnconventional:
      // V: |-(padding)-[title]-(spacing)-[image]-(padding)-|
      let imageWidth = imageSize.width
      let titleWidth = titleSize.width
      let imageHeight = imageSize.height
      let titleHeight = titleSize.height

      imageEdgeInsets = UIEdgeInsets(
        top: (titleHeight * 0.5 + halfSpacing),
        left: titleWidth * 0.5 * factor,
        bottom: -((titleHeight * 0.5 + halfSpacing)),
        right: -(titleWidth * 0.5) * factor)
      titleEdgeInsets = UIEdgeInsets(
        top: -(imageHeight * 0.5 + halfSpacing),
        left: -(imageWidth * 0.5) * factor,
        bottom: imageHeight * 0.5 + halfSpacing,
        right: imageWidth * 0.5 * factor)

      let padding = min(imageWidth, titleWidth) * 0.5
      let margin = min(imageHeight, titleHeight) * 0.5

      contentEdgeInsets = UIEdgeInsets(
        top: contentMargin.top + margin + halfSpacing,
        left: contentMargin.left - padding,
        bottom: contentMargin.bottom + margin + halfSpacing,
        right: contentMargin.right - padding)
    }
  }
}
