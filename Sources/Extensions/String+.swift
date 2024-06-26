//  Created by Shaw on 3/20/24.

import UIKit

// MARK: - Design

public extension String {
  func attributed(
    font: UIFont,
    foregroundColor: UIColor? = nil,
    lineSpacing: CGFloat = 0,
    alignment: NSTextAlignment = .justified
  ) -> NSAttributedString {
    let style = NSMutableParagraphStyle()
    style.lineSpacing = font.lineSpacing(lineSpacing)
    style.alignment = alignment

    let color: UIColor
    if #available(iOS 13.0, *) {
      color = foregroundColor ?? .label
    } else {
      color = foregroundColor ?? .black
    }

    let attributedText = NSAttributedString(string: self, attributes: [
      .paragraphStyle: style,
      .font: font,
      .foregroundColor: color,
    ])

    return attributedText
  }
}
