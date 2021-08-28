import UIKit

extension UILabel {
    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, macCatalyst 13.0, *)
    public convenience init(
        text: String,
        textAlignment: NSTextAlignment = .natural,
        textColor: UIColor = .label,
        font: UIFont = .preferredFont(forTextStyle: .body),
        ineBreakMode: NSLineBreakMode = .byTruncatingTail,
        numberOfLines: Int = 1
    ) {
        self.init()
        self.text = text
        self.textAlignment = textAlignment
        self.textColor = textColor
        self.font = font
        self.lineBreakMode = ineBreakMode
        self.numberOfLines = numberOfLines
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
