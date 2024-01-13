import UIKit

public extension UILabel {
  convenience init(
    text: String,
    textColor: UIColor = .foreground,
    textAlignment: NSTextAlignment = .natural,
    font: UIFont = .preferredFont(forTextStyle: .body),
    lineBreakMode: NSLineBreakMode = .byTruncatingTail,
    numberOfLines: Int = 0,
    backgroundColor: UIColor = .clear
  ) {
    self.init()
    self.text = text
    self.textAlignment = textAlignment
    self.textColor = textColor
    self.font = font
    self.lineBreakMode = lineBreakMode
    self.numberOfLines = numberOfLines
    // backgroundColor set to `nil` not working as doc says, use `.clear` instead
    self.backgroundColor = backgroundColor
    translatesAutoresizingMaskIntoConstraints = false
    adjustsFontForContentSizeCategory = true
  }
}
