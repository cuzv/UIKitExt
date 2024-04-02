import UIKit

@available(iOS 12.0, tvOS 12.0, macCatalyst 13.0, *)
public final class OuroborosView: SpinView {
  override public init(frame: CGRect) {
    super.init(frame: frame)
    awake()
  }

  public required init?(coder: NSCoder) {
    super.init(coder: coder)
    awake()
  }

  private func awake() {
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

    let lineWidth: CGFloat = 4

    let rect = bounds.inset(by: UIEdgeInsets(
      top: lineWidth,
      left: lineWidth,
      bottom: lineWidth,
      right: lineWidth
    ))
    let path = UIBezierPath(ovalIn: rect).cgPath

    let shapeLayer = CAShapeLayer()
    shapeLayer.path = path
    shapeLayer.frame = bounds
    shapeLayer.strokeColor = tintColor.cgColor
    shapeLayer.fillColor = UIColor.clear.cgColor
    shapeLayer.lineWidth = lineWidth
    shapeLayer.lineCap = .round
    shapeLayer.lineJoin = .round
    shapeLayer.strokeStart = 0.025
    shapeLayer.strokeEnd = progress
    shapeLayer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
    shapeLayer.transform = CATransform3DMakeRotation(-.pi / 2, 0, 0, 1)

    layer.mask = shapeLayer
  }

  override public var tintColor: UIColor! {
    didSet {
      (layer as? CAGradientLayer)?.colors = [UIColor.clear.cgColor, tintColor.cgColor]
      (layer.mask as? CAShapeLayer)?.strokeColor = tintColor.cgColor
    }
  }

  public var progress: CGFloat = 1 {
    didSet {
      (layer.mask as? CAShapeLayer)?.strokeEnd = max(progress, 0.025)
    }
  }
}
