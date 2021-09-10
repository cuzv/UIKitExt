import Foundation
import UIKit

final public class IBAttributedButton: UIButton, TouchesExpandable {

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
      .paragraphStyle: paragraphStyle
    ]

    let states: [UIControl.State] = [.normal, .disabled, .highlighted, .selected]
    states.forEach { state in
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

  // MARK: - TouchesExpandable

  @IBInspectable public var horizontalTouchesMargin: CGPoint = .zero
  @IBInspectable public var verticalTouchesMargin: CGPoint = .zero

  public var touchesMargin: UIEdgeInsets {
    .init(
      top: verticalTouchesMargin.x,
      left: horizontalTouchesMargin.x,
      bottom: verticalTouchesMargin.y,
      right: horizontalTouchesMargin.y
    )
  }

  public override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
    judgeWhetherInsideInclude(point: point, with: event)
  }
}
