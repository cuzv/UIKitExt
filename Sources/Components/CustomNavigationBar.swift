import UIKit

let kPadding: CGFloat = 0
let kBarHeight: CGFloat = 44

// MARK: - Navigation subviews

public extension Navigation where Base: UIViewController {
  var bar: UIView {
    let it = base.view.subviews.first { view in
      view.isKind(of: _NavView.self)
    }

    if let it {
      return it
    } else {
      base.additionalSafeAreaInsets.top = kBarHeight

      let it = _NavView()
      it.translatesAutoresizingMaskIntoConstraints = false
      base.view.addSubview(it)
      NSLayoutConstraint.activate([
        it.leadingAnchor.constraint(equalTo: base.view.leadingAnchor),
        it.trailingAnchor.constraint(equalTo: base.view.trailingAnchor),
        it.topAnchor.constraint(equalTo: base.view.topAnchor),
        it.bottomAnchor.constraint(equalTo: base.view.safeAreaLayoutGuide.topAnchor),
      ])

      return it
    }
  }

  var titleLabel: UILabel {
    let nav = bar
    let label = nav.subviews.first {
      $0.isKind(of: UILabel.self)
    } as? UILabel

    if let label {
      return label
    } else {
      let it = UILabel()
      it.translatesAutoresizingMaskIntoConstraints = false
      it.font = .preferredFont(forTextStyle: .headline)
      if #available(iOS 13.0, *) {
        it.textColor = .label
      } else {
        it.textColor = .black
      }
      it.textAlignment = .center
      nav.addSubview(it)
      NSLayoutConstraint.activate([
        it.centerXAnchor.constraint(equalTo: nav.centerXAnchor),
        it.bottomAnchor.constraint(equalTo: nav.bottomAnchor),
        it.heightAnchor.constraint(equalToConstant: base.additionalSafeAreaInsets.top),
      ])

      return it
    }
  }

  var leadingButtons: [UIButton] {
    get {
      let stackView = leadingStackView
      let buttons = stackView.arrangedSubviews.filter {
        $0.isKind(of: UIButton.self)
      } as? [UIButton]
      return buttons ?? []
    }
    set {
      let stackView = leadingStackView
      for arrangedSubview in stackView.arrangedSubviews {
        stackView.removeArrangedSubview(arrangedSubview)
        arrangedSubview.removeFromSuperview()
      }

      for item in newValue {
        stackView.addArrangedSubview(item)
      }

      let spacer = UIView()
      spacer.translatesAutoresizingMaskIntoConstraints = false
      stackView.addArrangedSubview(spacer)
    }
  }

  var trailingButtons: [UIButton] {
    get {
      let stackView = trailingStackView
      let buttons = stackView.arrangedSubviews.filter {
        $0.isKind(of: UIButton.self)
      } as? [UIButton]
      return buttons ?? []
    }
    set {
      let stackView = trailingStackView
      for arrangedSubview in stackView.arrangedSubviews {
        stackView.removeArrangedSubview(arrangedSubview)
        arrangedSubview.removeFromSuperview()
      }

      let spacer = UIView()
      spacer.translatesAutoresizingMaskIntoConstraints = false
      stackView.addArrangedSubview(spacer)

      for item in newValue.reversed() {
        stackView.addArrangedSubview(item)
      }
    }
  }

  func onPopTapped() {
    if let nvc = base.navigationController {
      if nvc.viewControllers.count > 1 {
        nvc.popViewController(animated: true)
      } else {
        nvc.presentingViewController?.dismiss(animated: true)
      }
    }
  }
}

// MARK: - Leading & Trailing StackView

extension Navigation where Base: UIViewController {
  var leadingStackView: UIStackView {
    let it = bar.subviews.first { view in
      view.isKind(of: _NavLeadingStackView.self)
    } as? UIStackView

    if let it {
      return it
    } else {
      let it = _NavLeadingStackView()
      it.translatesAutoresizingMaskIntoConstraints = false
      it.axis = .horizontal
      it.alignment = .center
      it.distribution = .fill
      it.spacing = UIStackView.spacingUseSystem

      let bar = bar
      bar.addSubview(it)
      // 这里不能通过设置 directionalLayoutMargins 来实现 content padding 的效果
      // 会导致子视图布局位置偏移，可能和靠近系统 navigation bar 布局有关系
      // 同样的布局代码，放到正常区域就没问题
      NSLayoutConstraint.activate([
        it.leadingAnchor.constraint(equalTo: bar.leadingAnchor, constant: kPadding),
        it.trailingAnchor.constraint(equalTo: bar.trailingAnchor, constant: -kPadding),
        it.bottomAnchor.constraint(equalTo: bar.bottomAnchor),
        it.heightAnchor.constraint(equalToConstant: base.additionalSafeAreaInsets.top),
      ])

      return it
    }
  }

  var trailingStackView: UIStackView {
    let it = bar.subviews.first { view in
      view.isKind(of: _NavTrailingStackView.self)
    } as? UIStackView

    if let it {
      return it
    } else {
      let it = _NavTrailingStackView()
      it.translatesAutoresizingMaskIntoConstraints = false
      it.axis = .horizontal
      it.alignment = .center
      it.distribution = .fill
      it.spacing = UIStackView.spacingUseSystem

      let bar = bar
      bar.addSubview(it)
      NSLayoutConstraint.activate([
        it.leadingAnchor.constraint(equalTo: bar.leadingAnchor, constant: kPadding),
        it.trailingAnchor.constraint(equalTo: bar.trailingAnchor, constant: -kPadding),
        it.bottomAnchor.constraint(equalTo: bar.bottomAnchor),
        it.heightAnchor.constraint(equalToConstant: base.additionalSafeAreaInsets.top),
      ])

      return it
    }
  }
}

// MARK: - Private classes

private final class _NavView: UIView {}
private class _StackView: UIStackView {
  override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
    for view in arrangedSubviews {
      if view.frame.contains(point) {
        return true
      }
    }
    return false
  }
}

private final class _NavLeadingStackView: _StackView {}
private final class _NavTrailingStackView: _StackView {}

// MARK: - NavigationProvider

public protocol NavigationProvider: AnyObject {}

public extension NavigationProvider {
  var nav: Navigation<Self> {
    get { Navigation(self) }
    set {}
  }

  static var nav: Navigation<Self>.Type {
    get { Navigation<Self>.self }
    set {}
  }
}

public struct Navigation<Base> {
  public let base: Base

  fileprivate init(_ base: Base) {
    self.base = base
  }
}

extension UIViewController: NavigationProvider {}
