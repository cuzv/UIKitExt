import UIKit

public extension UIApplication {
  var _keyWindow: UIWindow? {
    if #available(iOS 15.0, *) {
      connectedScenes
        .filter { $0.activationState == .foregroundActive }
        .compactMap { $0 as? UIWindowScene }
        .first?
        .windows
        .first(where: \.isKeyWindow)
    } else {
      windows.first(where: \.isKeyWindow)
    }
  }

  func topMostViewController() -> UIViewController? {
    _keyWindow?.rootViewController?.topMostViewController()
  }

  // See https://rambo.codes/ios/quick-tip/2019/12/09/clearing-your-apps-launch-screen-cache-on-ios.html
  func clearLaunchScreenCache() {
    do {
      try FileManager.default.removeItem(
        atPath: NSHomeDirectory() + "/Library/SplashBoard"
      )
    } catch {
      print("Failed to delete launch screen cache: \(error)")
    }
  }

  var safeAreaInsets: UIEdgeInsets {
    _keyWindow?.safeAreaInsets ?? .zero
  }
}
