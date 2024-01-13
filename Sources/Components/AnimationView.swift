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
  }

  open var isAnimating: Bool = false {
    didSet {
      let currentValue = isAnimating
      if oldValue != currentValue {
        currentValue ? startAnimating() : stopAnimating()
      }
    }
  }

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
    fatalError()
  }

  open func stopAnimating() {
    fatalError()
  }
}

public final class SpinView: AnimationView {
  override public func startAnimating() {
    let animation = CABasicAnimation(keyPath: "transform.rotation.z")
    animation.fromValue = 0
    animation.toValue = 2.0 * .pi
    animation.duration = 1.0
    animation.fillMode = .both
    animation.isRemovedOnCompletion = true
    animation.repeatCount = .greatestFiniteMagnitude
    layer.add(animation, forKey: "rotation")
  }

  override public func stopAnimating() {
    layer.removeAnimation(forKey: "rotation")
  }
}

public final class BreathView: AnimationView {
  override public func startAnimating() {
    let start = layer.opacity
    let end = abs(1.0 - start)

    let animation = CABasicAnimation(keyPath: "opacity")
    animation.fromValue = start
    animation.toValue = end
    animation.duration = 1
    animation.autoreverses = true
    animation.fillMode = .both
    animation.isRemovedOnCompletion = true
    animation.repeatCount = .greatestFiniteMagnitude
    layer.add(animation, forKey: "opacity")

    layer.opacity = end
  }

  override public func stopAnimating() {
    layer.removeAnimation(forKey: "opacity")
  }
}
