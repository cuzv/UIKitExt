import UIKit

@available(iOS 12.0, tvOS 12.0, macCatalyst 13.0, *)
public final class OuroborosView: UIView {
  override public init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }

  required public init?(coder: NSCoder) {
    super.init(coder: coder)
    setup()
  }

  private func setup() {
    if let layer = layer as? CAGradientLayer {
      layer.type = .conic
      layer.startPoint = CGPoint(x: 0.5, y: 0.5)
      layer.endPoint = CGPoint(x: 0.5, y: 0)
      layer.colors = [UIColor.clear.cgColor, tintColor.cgColor]
    }
  }

  override public class var layerClass: AnyClass {
    CAGradientLayer.self
  }

  override public func layoutSubviews() {
    super.layoutSubviews()

    let shape = CAShapeLayer()
    shape.frame = bounds
    shape.strokeColor = tintColor.cgColor
    shape.fillColor = UIColor.clear.cgColor

    let lineWidth: CGFloat = 4
    let path = UIBezierPath(ovalIn: shape.frame.inset(by: UIEdgeInsets(top: lineWidth, left: lineWidth, bottom: lineWidth, right: lineWidth))).cgPath
    shape.path = path
    shape.lineWidth = lineWidth
    shape.lineCap = .round
    shape.lineJoin = .round
    shape.strokeStart = 0.02
    shape.strokeEnd = 0.98
    shape.anchorPoint = CGPoint(x: 0.5, y: 0.5)
    shape.transform = CATransform3DMakeRotation(-.pi/2, 0, 0, 1)
    layer.mask = shape
  }

  override public var tintColor: UIColor! {
    didSet {
      (layer as? CAGradientLayer)?.colors = [UIColor.clear.cgColor, tintColor.cgColor]
      (layer.mask as? CAShapeLayer)?.strokeColor = tintColor.cgColor
    }
  }

  public var progress: CGFloat = 0.02 {
    didSet {
      (layer.mask as? CAShapeLayer)?.strokeEnd = max(0.02, min(progress, 0.98))
    }
  }
}
