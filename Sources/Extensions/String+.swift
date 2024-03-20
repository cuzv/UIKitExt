//  Created by Shaw on 3/20/24.

import Foundation

// MARK: - Design

public extension String {
  func attributed(
    foregroundColor: UIColor,
    font: UIFont,
    lineSpacing: CGFloat,
    alignment: NSTextAlignment = .justified
  ) -> NSAttributedString {
    let style = NSMutableParagraphStyle()
    style.lineSpacing = font.lineSpacing(lineSpacing)
    style.alignment = alignment

    let attributedText = NSAttributedString(string: self, attributes: [
      .paragraphStyle: style,
      .font: font,
      .foregroundColor: foregroundColor,
    ])

    return attributedText
  }
}
