import UIKit

extension UIApplication {
  public func topMostViewController() -> UIViewController? {
    keyWindow?.rootViewController?.topMostViewController()
  }

  // See https://rambo.codes/ios/quick-tip/2019/12/09/clearing-your-apps-launch-screen-cache-on-ios.html
  public func clearLaunchScreenCache() {
    do {
      try FileManager.default.removeItem(
        atPath: NSHomeDirectory() + "/Library/SplashBoard"
      )
    } catch {
      print("Failed to delete launch screen cache: \(error)")
    }
  }
}