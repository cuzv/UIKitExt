import UIKit

public final class DashedLine: UIView {
  override public init(frame: CGRect) {
    super.init(frame: frame)
    awake()
  }

  @available(*, unavailable)
  public required init?(coder: NSCoder) {
    super.init(coder: coder)
    awake()
  }

  private let shapeLayer = CAShapeLayer()

  private func awake() {
    shapeLayer.strokeColor = tintColor.cgColor
    shapeLayer.lineWidth = 1.0 / UIScreen.main.scale
    shapeLayer.lineDashPattern = [2]
    layer.addSublayer(shapeLayer)
  }

  override public func layoutSubviews() {
    super.layoutSubviews()

    let path = CGMutablePath()
    path.addLines(between: [CGPoint(x: 0, y: 0), CGPoint(x: frame.width, y: 0)])
    shapeLayer.path = path
  }

  public func strokeColor(_ color: UIColor) -> Self {
    shapeLayer.strokeColor = color.cgColor
    return self
  }

  public func lineWidth(_ width: CGFloat) -> Self {
    shapeLayer.lineWidth = width
    return self
  }

  public func lineDashPattern(_ pattern: [NSNumber]) -> Self {
    shapeLayer.lineDashPattern = pattern
    return self
  }
}
