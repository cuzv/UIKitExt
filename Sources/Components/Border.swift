import UIKit

extension UIView {
    public struct Border {
        public enum Edge: CaseIterable {
            case leading
            case trailing
            case top
            case bottom
        }

        let edge: Edge
        let width: CGFloat
        let color: UIColor
        let leading: CGFloat
        let trailing: CGFloat

        public init(
            edge: Edge,
            width: CGFloat = 1.0 / UIScreen.main.scale,
            color: UIColor = UIColor(red: 200/255.0, green: 199/255.0, blue: 204/255.0, alpha: 1),
            leading: CGFloat = 0,
            trailing: CGFloat = 0
        ) {
            self.edge = edge
            self.width = width
            self.color = color
            self.leading = leading
            self.trailing = trailing
        }
    }

    @discardableResult
    public func addBorder(_ border: Border) -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = border.color
        addSubview(view)

        switch border.edge {
        case .leading:
            NSLayoutConstraint.activate([
                view.widthAnchor.constraint(equalToConstant: border.width),
                view.topAnchor.constraint(equalTo: topAnchor, constant: border.leading),
                view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -border.trailing),
                view.leadingAnchor.constraint(equalTo: leadingAnchor)
            ])
        case .trailing:
            NSLayoutConstraint.activate([
                view.widthAnchor.constraint(equalToConstant: border.width),
                view.topAnchor.constraint(equalTo: topAnchor, constant: border.leading),
                view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -border.trailing),
                view.trailingAnchor.constraint(equalTo: trailingAnchor)
            ])
        case .top:
            NSLayoutConstraint.activate([
                view.heightAnchor.constraint(equalToConstant: border.width),
                view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: border.leading),
                view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -border.trailing),
                view.topAnchor.constraint(equalTo: topAnchor)
            ])
        case .bottom:
            NSLayoutConstraint.activate([
                view.heightAnchor.constraint(equalToConstant: border.width),
                view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: border.leading),
                view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -border.trailing),
                view.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
        }

        return view
    }
}
