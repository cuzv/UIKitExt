//  Created by Shaw on 1/1/24.

import Foundation
import SwiftUI
import UIKit

public enum SegmentIndicatorStyle {
  case capsule
  case line(size: CGSize = .init(width: 4, height: 4))
}

public struct SegmentAppearance {
  let normalFont: UIFont
  let normalTextColor: UIColor
  let highlightFont: UIFont
  let highlightTextColor: UIColor
  let indicatorColor: UIColor
  let indicatorStyle: SegmentIndicatorStyle

  public init(
    normalFont: UIFont,
    normalTextColor: UIColor,
    highlightFont: UIFont,
    highlightTextColor: UIColor,
    indicatorColor: UIColor,
    indicatorStyle: SegmentIndicatorStyle
  ) {
    self.normalFont = normalFont
    self.normalTextColor = normalTextColor
    self.highlightFont = highlightFont
    self.highlightTextColor = highlightTextColor
    self.indicatorColor = indicatorColor
    self.indicatorStyle = indicatorStyle
  }
}

@available(iOS 13.0, *)
public final class SegmentView<Element: Hashable & CustomStringConvertible>: UIView {
  public let items: [Element]
  public let appearance: SegmentAppearance
  public let onClick: ((Element, Element) -> Void)?

  private var selected: Int
  private var itemViews: [UILabel]?
  private let indicator = UIView()
  private let paddings = NSDirectionalEdgeInsets(vertical: 8, horizontal: 16)

  public init(
    items: [Element],
    appearance: SegmentAppearance,
    selected: Int = 0,
    onClick: ((Element, Element) -> Void)?
  ) {
    precondition(!items.isEmpty)
    self.items = items
    self.appearance = appearance
    self.selected = selected
    self.onClick = onClick
    super.init(frame: .zero)
    setup()
  }

  @available(*, unavailable)
  public required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setup() {
    let itemViews = items.enumerated().map { offset, item in
      SegmentLabel(text: String(describing: item))
        .textColor(appearance.normalTextColor)
        .font(appearance.normalFont)
        .textAlignment(.center)
        .tag(offset)
        .contentHuggingPriority(.defaultHigh, for: .horizontal)
        .contentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        .contentHuggingPriority(.defaultHigh, for: .vertical)
        .contentCompressionResistancePriority(.defaultHigh, for: .vertical)
        .userInteractionEnabled(true)
        .tapAction { [weak self] sender in
          guard let self else { return }
          select(sender.tag)
        }
    }
    self.itemViews = itemViews

    let stackView: UIStackView
    switch appearance.indicatorStyle {
    case .capsule:
      stackView = UIStackView(
        axis: .horizontal,
        distribution: .equalSpacing,
        spacing: paddings.leading * 2,
        paddings: paddings
      )
    case .line:
      stackView = UIStackView(
        axis: .horizontal,
        distribution: .fillEqually,
        spacing: 0,
        paddings: paddings
      )
    }

    stackView
      .arrange {
        itemViews
      }
      .in(self)

    let pivot = itemViews[0]

    addSubview(
      indicator
        .useConstraints()
        .backgroundColor(appearance.indicatorColor)
        .clipsToBounds(true)
    )

    switch appearance.indicatorStyle {
    case .capsule:
      indicator
        .constraint(
          to: pivot,
          pin: .superview,
          margins: paddings.reversed
        )
        .sendToBack()
    case let .line(size):
      indicator
        .size(size)
        .constraint(
          to: pivot,
          pin: [.centerX, .bottom],
          margins: paddings.reversed
        )
        .sendToBack()
    }

    clipsToBounds(true)

    reactToggle(index: 0)
  }

  override public func layoutSubviews() {
    super.layoutSubviews()

    if case .capsule = appearance.indicatorStyle {
      cornerRadius(bounds.height * 0.5)
    }
    indicator.cornerRadius(indicator.bounds.height * 0.5)
  }

  private func select(_ index: Int) {
    reactToggle(index: index)
    onClick?(items[selected], items[index])
    selected = index
  }

  private func reactToggle(index: Int) {
    guard let itemViews else {
      return
    }

    let pivot = itemViews[index]

    switch appearance.indicatorStyle {
    case .capsule:
      indicator
        .deactivateConstraints()
        .constraint(
          to: pivot,
          pin: .superview,
          margins: paddings.reversed
        )
        .updateConstraintsIfNecessary()
    case .line:
      indicator
        .deactivateConstraints()
        .constraint(
          to: pivot,
          pin: [.centerX, .bottom],
          margins: paddings.reversed
        )
        .updateConstraintsIfNecessary()
    }

    for label in itemViews {
      label
        .font(appearance.normalFont)
        .textColor(appearance.normalTextColor)
    }

    pivot
      .font(appearance.highlightFont)
      .textColor(appearance.highlightTextColor)

    setNeedsLayout()
    UIView.animate(withDuration: 0.25) {
      self.layoutIfNeeded()
    }
  }

  public func select(_ item: Element) {
    if let index = items.firstIndex(where: { $0 == item }) {
      if selected == index {
        return
      }
      select(index)
    } else {
      fatalError("select element must be in items provided by initializer")
    }
  }
}

final class SegmentLabel: UILabel, HitTestSlop {
  var hitTestSlop: UIEdgeInsets {
    .init(value: 8)
  }

  override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
    judgeWhetherInclude(point: point, with: event)
  }
}

@available(iOS 13.0, *)
public struct Segment<Element: Hashable & CustomStringConvertible>: UIViewRepresentable {
  public typealias UIViewType = SegmentView<Element>

  public let items: [Element]
  public let appearance: SegmentAppearance
  @Binding private var selection: (Element, Element)

  public init(
    items: [Element],
    appearance: SegmentAppearance,
    selection: Binding<(Element, Element)>
  ) {
    self.items = items
    self.appearance = appearance
    _selection = selection
  }

  public func makeUIView(context: Context) -> UIViewType {
    .init(items: items, appearance: appearance) { old, new in
      selection = (old, new)
    }
  }

  public func updateUIView(_ uiView: UIViewType, context: Context) {
    uiView.select(selection)
  }
}
