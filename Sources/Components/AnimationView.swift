import CoreGraphics
import QuartzCore
import UIKit

open class AnimationView: UIView {
  @IBInspectable open var resumeWhileAwake: Bool = true
  @IBInspectable open var image: UIImage? {
    didSet {
      layer.contents = image?.cgImage
    }
  }

  override public init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }

  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }

  deinit {
    NotificationCenter.default.removeObserver(self)
  }

  private func setup() {
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(updateAnimation),
      name: UIApplication.didBecomeActiveNotification,
      object: nil
    )
    stopAnimating()
  }

  open var isAnimating: Bool = false {
    didSet {
      let currentValue = isAnimating
      if oldValue != currentValue {
        currentValue ? startAnimating() : stopAnimating()
      }
    }
  }

  open var hidesWhenStopped: Bool = true

  override open func didMoveToWindow() {
    super.didMoveToWindow()
    updateAnimation()
  }

  @objc private func updateAnimation() {
    if resumeWhileAwake {
      if window != nil, isAnimating {
        isAnimating.toggle()
        isAnimating.toggle()
      }
    } else {
      isAnimating = false
    }
  }

  open func startAnimating() {
    alpha(1)
  }

  open func stopAnimating() {
    alpha(hidesWhenStopped ? 0 : 1)
  }

  @discardableResult
  open func animating(_ value: Bool) -> Self {
    isAnimating = value
    return self
  }
}

open class SpinView: AnimationView {
  override public func startAnimating() {
    super.startAnimating()
    let animation = CABasicAnimation(keyPath: "transform.rotation.z")
    animation.fromValue = 0
    animation.toValue = 2.0 * .pi
    animation.duration = 0.7
    animation.fillMode = .both
    animation.isRemovedOnCompletion = true
    animation.repeatCount = .greatestFiniteMagnitude
    layer.add(animation, forKey: "rotation")
  }

  override public func stopAnimating() {
    super.stopAnimating()
    layer.removeAnimation(forKey: "rotation")
  }
}

open class BreathView: AnimationView {
  override public func startAnimating() {
    super.startAnimating()

    let start = layer.opacity
    let end = abs(1.0 - start)

    let animation = CABasicAnimation(keyPath: "opacity")
    animation.fromValue = start
    animation.toValue = end
    animation.duration = 0.7
    animation.autoreverses = true
    animation.fillMode = .both
    animation.isRemovedOnCompletion = true
    animation.repeatCount = .greatestFiniteMagnitude
    layer.add(animation, forKey: "opacity")

    layer.opacity = end
  }

  override public func stopAnimating() {
    super.stopAnimating()
    layer.removeAnimation(forKey: "opacity")
  }
}
