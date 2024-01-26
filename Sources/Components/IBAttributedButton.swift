import Foundation
import UIKit

public final class IBAttributedButton: UIButton, HitTestSlop {
  // MARK: - Attributed String

  @IBInspectable public var character: Double = 0 { didSet { updateAttributes() } }
  @IBInspectable public var line: CGFloat = 0 { didSet { updateAttributes() } }
  @IBInspectable public var paragraph: CGFloat = 0 { didSet { updateAttributes() } }

  override public func setTitle(_ title: String?, for state: UIControl.State) {
    super.setTitle(title, for: state)
    updateAttributes()
  }

  private func updateAttributes() {
    let paragraphStyle = NSMutableParagraphStyle()
    if line > 0 {
      paragraphStyle.minimumLineHeight = line
    }
    if paragraph > 0 {
      paragraphStyle.paragraphSpacing = paragraph
    }

    var attributes: [NSAttributedString.Key: Any] = [
      .kern: NSNumber(value: character),
      .paragraphStyle: paragraphStyle,
    ]

    let states: [UIControl.State] = [.normal, .disabled, .highlighted, .selected]
    for state in states {
      if let color = titleColor(for: state) {
        attributes[.foregroundColor] = color
      }
      let attributedTitle = NSAttributedString(
        string: title(for: state) ?? "",
        attributes: attributes
      )
      setAttributedTitle(attributedTitle, for: state)
    }
  }

  // MARK: - HitTestSlop

  @IBInspectable public var horizontalHitTestSlop: CGPoint = .zero
  @IBInspectable public var verticalHitTestSlop: CGPoint = .zero

  public var hitTestSlop: UIEdgeInsets {
    .init(
      top: verticalHitTestSlop.x,
      left: horizontalHitTestSlop.x,
      bottom: verticalHitTestSlop.y,
      right: horizontalHitTestSlop.y
    )
  }

  override public func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
    judgeWhetherInclude(point: point, with: event)
  }
}
