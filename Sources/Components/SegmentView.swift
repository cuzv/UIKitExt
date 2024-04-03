//  Created by Shaw on 1/1/24.

import Foundation
import SwiftUI
import UIKit

public struct SegmentStyle {
  let normalFont: UIFont
  let normalTextColor: UIColor
  let highlightFont: UIFont
  let highlightTextColor: UIColor
  let indicatorColor: UIColor

  public init(
    normalFont: UIFont,
    normalTextColor: UIColor,
    highlightFont: UIFont,
    highlightTextColor: UIColor,
    indicatorColor: UIColor
  ) {
    self.normalFont = normalFont
    self.normalTextColor = normalTextColor
    self.highlightFont = highlightFont
    self.highlightTextColor = highlightTextColor
    self.indicatorColor = indicatorColor
  }
}

@available(iOS 13.0, *)
public final class SegmentView<Element: Hashable & CustomStringConvertible>: UIView {
  public let items: [Element]
  public let style: SegmentStyle
  public let onClick: ((Element, Element) -> Void)?

  private var selected: Int
  private var itemViews: [UILabel]?
  private let indicator = UIView()
  let stackView = UIStackView(axis: .horizontal, distribution: .equalSpacing, spacing: 32, paddings: .init(vertical: 8, horizontal: 16))

  public init(
    items: [Element],
    style: SegmentStyle,
    selected: Int = 0,
    onClick: ((Element, Element) -> Void)?
  ) {
    precondition(!items.isEmpty)
    self.items = items
    self.style = style
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
        .textColor(style.normalTextColor)
        .font(style.normalFont)
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

    stackView
      .backgroundColor(.black.withAlphaComponent(0.06))
      .addArrangedSubviews(itemViews)
      .in(self)

    let pivot = itemViews[0]
    pivot.textColor(.label)

    addSubview(
      indicator
        .useConstraints()
        .backgroundColor(style.indicatorColor)
    )
    indicator.layout { proxy in
      proxy.leading == pivot.leadingAnchor - 16
      proxy.trailing == pivot.trailingAnchor + 16
      proxy.top == pivot.topAnchor - 8
      proxy.bottom == pivot.bottomAnchor + 8
    }

    sendSubviewToBack(indicator)

    indicator.clipsToBounds(true)
    clipsToBounds(true)

    reactToggle(index: 0)
  }

  override public func layoutSubviews() {
    super.layoutSubviews()

    cornerRadius(indicator.bounds.height * 0.5)
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

    indicator.relayout { proxy in
      proxy.leading == pivot.leadingAnchor - 16
      proxy.trailing == pivot.trailingAnchor + 16
      proxy.top == pivot.topAnchor - 8
      proxy.bottom == pivot.bottomAnchor + 8
    }

    for label in itemViews {
      label
        .font(style.normalFont)
        .textColor(style.normalTextColor)
    }

    pivot
      .font(style.highlightFont)
      .textColor(style.highlightTextColor)

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
  public let style: SegmentStyle
  @Binding private var selection: (Element, Element)

  public init(
    items: [Element],
    style: SegmentStyle,
    selection: Binding<(Element, Element)>
  ) {
    self.items = items
    self.style = style
    _selection = selection
  }

  public func makeUIView(context: Context) -> UIViewType {
    .init(items: items, style: style) { old, new in
      selection = (old, new)
    }
  }

  public func updateUIView(_ uiView: UIViewType, context: Context) {
    uiView.select(selection)
  }
}
