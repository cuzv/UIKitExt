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

  @available(iOS 13.0, tvOS 13.0, macCatalyst 13.0, *)
  public func openAppStore(appId: String, writeReview: Bool = false) async throws -> Bool {
    var link = "itms-apps://itunes.apple.com/app/id\(appId)?mt=8"
    if writeReview {
      link.append("&action=write-review")
    }

    guard let url = URL(string: link) else {
      throw URLError.invalid
    }

    return await withCheckedContinuation { continuation in
      open(url, options: [:]) { result in
        continuation.resume(with: .success(result))
      }
    }
  }
}

public enum URLError: Error {
  case invalid
}
