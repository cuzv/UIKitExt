import Foundation
import UIKit

final public class IBAttributedLabel: UILabel {
    @IBInspectable public var character: Double = 0 { didSet { updateAttributes() } }
    @IBInspectable public var line: CGFloat = 0 { didSet { updateAttributes() } }
    @IBInspectable public var paragraph: CGFloat = 0 { didSet { updateAttributes() } }
    @IBInspectable public var isTruncatingMiddle: Bool = false { didSet { updateAttributes() } }

    override public var text: String? {
        didSet {
            updateAttributes()
        }
    }

    private func updateAttributes() {
        guard let text = text, !text.isEmpty else {
            return
        }

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = textAlignment
        paragraphStyle.lineBreakMode = isTruncatingMiddle ? .byTruncatingMiddle : .byTruncatingTail
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
        if let color = textColor {
            attributes[.foregroundColor] = color
        }

        let attributedTitle = NSAttributedString(string: text, attributes: attributes)
        attributedText = attributedTitle
    }
}
