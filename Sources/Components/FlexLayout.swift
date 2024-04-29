import UIKit

// MARK: - Typealias

public typealias FlexColumn = Flex.Column
public typealias FlexRow = Flex.Row
public typealias FlexScroll = Flex.Scroll
public typealias FlexView = Flex.View
public typealias FlexStack = Flex.Stack

public typealias FlexJustifyContent = Flex.JustifyContent
public typealias FlexAlignItems = Flex.AlignItems
public typealias FlexOverlayAlignment = Flex.OverlayAlignment

// MARK: - Flex

public enum Flex {
  public enum JustifyContent: Int, @unchecked Sendable {
    case start
    case center
    case end
    case spaceBetween
    case spaceAround
    case spaceEvenly

    var distribution: UIStackView.Distribution {
      switch self {
      case .spaceEvenly: .equalSpacing
      case .spaceBetween: .equalSpacing
      default: .fill
      }
    }
  }

  public enum AlignItems: Int, @unchecked Sendable {
    case start
    case center
    case end
    case baseline
    case stretch

    func alignment(axis: NSLayoutConstraint.Axis) -> UIStackView.Alignment {
      switch self {
      case .start: .leading
      case .center: .center
      case .end: .trailing
      case .baseline:
        switch axis {
        case .horizontal: .lastBaseline
        case .vertical: .firstBaseline
        @unknown default: .firstBaseline
        }
      case .stretch: .fill
      }
    }
  }

  public enum OverlayAlignment: Int, @unchecked Sendable {
    case center
    case topLeading
    case topTrailing
    case bottomLeading
    case botomTrailing
    case leadingCenter
    case trailingCenter
    case topCenter
    case bottomCenter
  }

  // MARK: Column

  open class Column: HitTestSlopStackView {
    public convenience init(
      justify: JustifyContent = .start,
      align: AlignItems = .stretch,
      spacing: CGFloat = 0,
      paddings: NSDirectionalEdgeInsets = .zero,
      @ChildrenViewBuilder content: () -> [UIView]
    ) {
      self.init(
        axis: .vertical,
        justify: justify,
        align: align,
        spacing: spacing,
        paddings: paddings,
        content: content
      )
    }
  }

  // MARK: Row

  open class Row: HitTestSlopStackView {
    public convenience init(
      justify: JustifyContent = .start,
      align: AlignItems = .stretch,
      spacing: CGFloat = 0,
      paddings: NSDirectionalEdgeInsets = .zero,
      @ChildrenViewBuilder content: () -> [UIView]
    ) {
      self.init(
        axis: .horizontal,
        justify: justify,
        align: align,
        spacing: spacing,
        paddings: paddings,
        content: content
      )
    }
  }

  // MARK: Scroll

  open class Scroll: HitTestSlopScrollView {
    public convenience init(
      axis: NSLayoutConstraint.Axis,
      contentInset: UIEdgeInsets = .zero,
      contentInsetAdjustmentBehavior: ContentInsetAdjustmentBehavior = .automatic,
      backgroundColor: UIColor? = nil,
      showsHorizontalScrollIndicator: Bool? = nil,
      showsVerticalScrollIndicator: Bool? = nil,
      alwaysBounceHorizontal: Bool? = nil,
      alwaysBounceVertical: Bool? = nil,
      justify: JustifyContent = .start,
      align: AlignItems = .stretch,
      spacing: CGFloat = 0,
      paddings: NSDirectionalEdgeInsets = .zero,
      @ChildrenViewBuilder content: () -> [UIView]
    ) {
      self.init(
        contentInset: contentInset,
        contentInsetAdjustmentBehavior: contentInsetAdjustmentBehavior,
        backgroundColor: backgroundColor,
        showsHorizontalScrollIndicator: showsHorizontalScrollIndicator ?? (axis == .horizontal),
        showsVerticalScrollIndicator: showsVerticalScrollIndicator ?? (axis == .vertical),
        alwaysBounceHorizontal: alwaysBounceHorizontal ?? (axis == .horizontal),
        alwaysBounceVertical: alwaysBounceVertical ?? (axis == .vertical)
      )

      switch axis {
      case .horizontal:
        addSubview(
          Flex.Row(
            justify: justify,
            align: align,
            spacing: spacing,
            paddings: paddings,
            content: content
          ),
          pin: [.superview, .height]
        )
      case .vertical:
        addSubview(
          Flex.Column(
            justify: justify,
            align: align,
            spacing: spacing,
            paddings: paddings,
            content: content
          ),
          pin: [.superview, .width]
        )
      @unknown default:
        break
      }
    }
  }

  // MARK: View

  open class View: HitTestSlopView {
    public convenience init(
      pin anchors: PinLayoutAnchor = .superview,
      paddings insets: NSDirectionalEdgeInsets = .zero,
      @ChildViewBuilder content: () -> UIView
    ) {
      self.init()
      translatesAutoresizingMaskIntoConstraints = false
      addSubview(content(), pin: anchors, paddings: insets)
    }
  }

  // MARK: Stack

  open class Stack: HitTestSlopView {
    public convenience init(
      pin anchors: PinLayoutAnchor = .superview,
      paddings insets: NSDirectionalEdgeInsets = .zero,
      @ChildrenViewBuilder content: () -> [UIView]
    ) {
      self.init()
      translatesAutoresizingMaskIntoConstraints = false
      for view in content() {
        addSubview(view, pin: anchors, paddings: insets)
      }
    }
  }

  // MARK: HitTestSlopStackView

  open class HitTestSlopStackView: UIStackView, HitTestSlop {
    public private(set) var hitTestSlop: UIEdgeInsets = .zero

    override open func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
      judgeWhetherInclude(point: point, with: event)
    }

    @discardableResult
    public func hitTestSlop(_ slop: UIEdgeInsets) -> Self {
      hitTestSlop = slop
      return self
    }
  }

  // MARK: HitTestSlopScrollView

  open class HitTestSlopScrollView: UIScrollView, HitTestSlop {
    public private(set) var hitTestSlop: UIEdgeInsets = .zero

    override open func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
      judgeWhetherInclude(point: point, with: event)
    }

    @discardableResult
    public func hitTestSlop(_ slop: UIEdgeInsets) -> Self {
      hitTestSlop = slop
      return self
    }
  }

  // MARK: HitTestSlopView

  open class HitTestSlopView: TouchableFeedbackView, HitTestSlop {
    public private(set) var hitTestSlop: UIEdgeInsets = .zero

    override open func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
      judgeWhetherInclude(point: point, with: event)
    }

    @discardableResult
    public func hitTestSlop(_ slop: UIEdgeInsets) -> Self {
      hitTestSlop = slop
      return self
    }
  }
}

public extension Flex.HitTestSlopStackView {
  convenience init(
    axis: NSLayoutConstraint.Axis,
    justify: Flex.JustifyContent,
    align: Flex.AlignItems,
    spacing: CGFloat,
    paddings: NSDirectionalEdgeInsets,
    @ChildrenViewBuilder content: () -> [UIView]
  ) {
    self.init(
      axis: axis,
      distribution: justify.distribution,
      alignment: align.alignment(axis: axis),
      spacing: spacing,
      paddings: paddings
    )

    var leadingView: UIView?
    if [.end, .center, .spaceEvenly, .spaceAround].contains(justify) {
      let view = UIView().useConstraints()
      addArrangedSubview(view)
      leadingView = view
    }

    var spacers = [UIView]()
    let itemViews = content()
    if [.spaceBetween, .spaceAround].contains(justify) {
      let last = itemViews.last
      for itemView in itemViews {
        if itemView !== last {
          let spacer = UIView().useConstraints()
          spacers.append(spacer)
          addArrangedSubviews([
            itemView,
            spacer,
          ])
        } else {
          addArrangedSubview(itemView)
        }
      }
    } else {
      addArrangedSubviews(itemViews)
    }

    let growItemViews = itemViews.filter { $0.grow >= 1 }
    if growItemViews.count > 1 {
      let first = growItemViews[0]
      for view in growItemViews.dropFirst() {
        switch axis {
        case .horizontal:
          NSLayoutConstraint.activate(
            first.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: first.grow / view.grow)
          )
        case .vertical:
          NSLayoutConstraint.activate(
            first.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: first.grow / view.grow)
          )
        @unknown default:
          break
        }
      }
    }

    var trailingView: UIView?
    if [.start, .center, .spaceEvenly, .spaceAround].contains(justify) {
      let view = UIView().useConstraints()
      addArrangedSubview(view)
      trailingView = view
    }

    if let leadingView, let trailingView {
      switch axis {
      case .horizontal:
        NSLayoutConstraint.activate(
          leadingView.widthAnchor.constraint(equalTo: trailingView.widthAnchor)
        )
      case .vertical:
        NSLayoutConstraint.activate(
          leadingView.heightAnchor.constraint(equalTo: trailingView.heightAnchor)
        )
      @unknown default:
        break
      }

      if justify == .spaceAround {
        for view in spacers {
          switch axis {
          case .horizontal:
            NSLayoutConstraint.activate(
              view.widthAnchor.constraint(equalTo: leadingView.widthAnchor, multiplier: 2)
            )
          case .vertical:
            NSLayoutConstraint.activate(
              view.heightAnchor.constraint(equalTo: leadingView.heightAnchor, multiplier: 2)
            )
          @unknown default:
            break
          }
        }
      }
    }
  }
}

// MARK: - FlexGrowSupport

public protocol FlexGrowSupport: AnyObject {
  var grow: CGFloat { get set }
}

public extension FlexGrowSupport {
  @discardableResult
  func grow(_ value: CGFloat) -> Self {
    precondition(value >= 1.0, "Flex grow must be >= 1.0")
    grow = value
    return self
  }
}

extension NSObject: FlexGrowSupport {
  @nonobjc private static var flexGrowKey: Void?
  public var grow: CGFloat {
    get { objc_getAssociatedObject(self, &Self.flexGrowKey) as? CGFloat ?? 0 }
    set { objc_setAssociatedObject(self, &Self.flexGrowKey, newValue, .OBJC_ASSOCIATION_ASSIGN) }
  }
}

// MARK: - Flex Extension

public extension UIView {
  @discardableResult
  func inRow(
    justify: Flex.JustifyContent = .start,
    align: Flex.AlignItems = .stretch,
    spacing: CGFloat = 0,
    paddings: NSDirectionalEdgeInsets = .zero
  ) -> Flex.Row {
    .init(
      justify: justify,
      align: align,
      spacing: spacing,
      paddings: paddings
    ) {
      self
    }
  }

  @discardableResult
  func inColumn(
    justify: Flex.JustifyContent = .start,
    align: Flex.AlignItems = .stretch,
    spacing: CGFloat = 0,
    paddings: NSDirectionalEdgeInsets = .zero
  ) -> Flex.Column {
    .init(
      justify: justify,
      align: align,
      spacing: spacing,
      paddings: paddings
    ) {
      self
    }
  }

  @discardableResult
  func inStack(
    axis: NSLayoutConstraint.Axis,
    justify: Flex.JustifyContent = .start,
    align: Flex.AlignItems = .stretch,
    spacing: CGFloat = 0,
    paddings: NSDirectionalEdgeInsets = .zero
  ) -> Flex.HitTestSlopStackView {
    .init(
      axis: axis,
      justify: justify,
      align: align,
      spacing: spacing,
      paddings: paddings
    ) {
      self
    }
  }

  @discardableResult
  func inScroll(
    axis: NSLayoutConstraint.Axis,
    contentInset: UIEdgeInsets = .zero,
    contentInsetAdjustmentBehavior: UIScrollView.ContentInsetAdjustmentBehavior = .automatic,
    backgroundColor: UIColor? = nil,
    showsHorizontalScrollIndicator: Bool? = nil,
    showsVerticalScrollIndicator: Bool? = nil,
    alwaysBounceHorizontal: Bool? = nil,
    alwaysBounceVertical: Bool? = nil,
    justify: Flex.JustifyContent = .start,
    align: Flex.AlignItems = .stretch,
    spacing: CGFloat = 0,
    paddings: NSDirectionalEdgeInsets = .zero
  ) -> Flex.Scroll {
    .init(
      axis: axis,
      contentInset: contentInset,
      contentInsetAdjustmentBehavior: contentInsetAdjustmentBehavior,
      backgroundColor: backgroundColor,
      showsHorizontalScrollIndicator: showsHorizontalScrollIndicator,
      showsVerticalScrollIndicator: showsVerticalScrollIndicator,
      alwaysBounceHorizontal: alwaysBounceHorizontal,
      alwaysBounceVertical: alwaysBounceVertical,
      justify: justify,
      align: align,
      spacing: spacing,
      paddings: paddings
    ) {
      self
    }
  }

  @discardableResult
  func inView(
    pin anchors: PinLayoutAnchor = .superview,
    paddings insets: NSDirectionalEdgeInsets = .zero
  ) -> Flex.View {
    .init(
      pin: anchors,
      paddings: insets
    ) {
      self
    }
  }

  @discardableResult
  func padding(
    pin anchors: PinLayoutAnchor = .superview,
    _ insets: NSDirectionalEdgeInsets = .zero
  ) -> Flex.View {
    inView(
      pin: anchors,
      paddings: insets
    )
  }
}

public extension UIStackView {
  @discardableResult
  func arrange(
    @ChildrenViewBuilder content: () -> [UIView]
  ) -> Self {
    addArrangedSubviews(content())
  }
}
