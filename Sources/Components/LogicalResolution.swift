import UIKit

@available(iOSApplicationExtension, unavailable)
public struct LogicalResolution {
  let width: CGFloat
  let height: CGFloat

  /// 3.5"
  /// - @1x: iPhone 3GS and 3G, gen 1
  /// - @1x: iPod touch (gen 3) and gen 2, gen 1
  /// - @2x: iPhone 4s and 4
  /// - @2x: iPod touch (gen 4)
  public static let _320_480 = LogicalResolution(width: 320, height: 480)

  /// 4"
  /// - @2x: iPhone SE and 5s, 5c, 5
  /// - @2x: iPod touch (gen 6) and gen 5
  public static let _320_568 = LogicalResolution(width: 320, height: 568)

  /// 4.7"
  /// - @2x: iPhone 8 and 7, 6s, 6
  public static let _375_667 = LogicalResolution(width: 375, height: 667)

  /// 5.8"
  /// - @3x: iPhone 11 Pro, iPhone Xs and X
  /// - 5.4'' iPhone 12 Mini
  public static let _375_812 = LogicalResolution(width: 375, height: 812)

  /// iPhone 6.1-inch
  /// - iPhone 12, iPhone 12 Pro
  public static let _390_844 = LogicalResolution(width: 390, height: 844)

  /// 5.5"
  /// - @3x: iPhone 8+ and 7+, 6s+, 6+
  public static let _414_736 = LogicalResolution(width: 414, height: 736)

  /// 6.1", 6.5"
  /// - @3x: iPhone 11 Pro Max, iPhone Xs Max
  /// - @2x: iPhone 11, iPhone Xr
  public static let _414_896 = LogicalResolution(width: 414, height: 896)

  /// iPhone 6.7-inch
  /// - iPhone 12 Pro Max
  public static let _428_926 = LogicalResolution(width: 428, height: 926)

  /// 7.9", 9.7"
  /// - @1x: iPad (gen 2) and iPad (gen 1)
  /// - @1x: iPad mini (gen 1)
  /// - @2x: iPad mini (gen 5) and mini 4, mini 3, mini 2
  /// - @2x: iPad (gen 6) and iPad (gen 5), iPad Pro 9.7", Air 2, Air (gen 1), iPad 4, iPad (gen 3)
  public static let _768_1024 = LogicalResolution(width: 768, height: 1024)

  /// iPad 10.2-inch
  /// iPad 7th Generation
  public static let _810_1080 = LogicalResolution(width: 810, height: 1080)

  /// 10.5"
  /// - @2x: iPad Air 10.5" and iPad Pro 10.5"
  public static let _834_1112 = LogicalResolution(width: 834, height: 1112)

  /// 11"
  /// - @2x: iPad Pro 11"
  public static let _834_1194 = LogicalResolution(width: 834, height: 1194)

  /// 12.9"
  /// - @2x: iPad Pro 12.9"
  public static let _1024_1366 = LogicalResolution(width: 1024, height: 1366)

  public static var current: LogicalResolution {
    var size = UIScreen.main.bounds.size

    if UIApplication.shared.statusBarOrientation.isLandscape {
      size = CGSize(width: size.height, height: size.width)
    }

    return .init(width: size.width, height: size.height)
  }

  public var isNotchExist: Bool {
    [Self._414_896, ._375_812].contains(self)
  }

  public var bottomPadding: CGFloat {
    isNotchExist ? 34 : 0
  }

  public var topPadding: CGFloat {
    isNotchExist ? 44 : 20
  }
}

@available(iOSApplicationExtension, unavailable)
extension LogicalResolution: Equatable {
}

@available(iOSApplicationExtension, unavailable)
extension LogicalResolution: Comparable {
  private var area: CGFloat {
    width * height
  }

  @inline(__always)
  public static func < (lhs: LogicalResolution, rhs: LogicalResolution) -> Bool {
    lhs.area < rhs.area
  }

  @inline(__always)
  public static func > (lhs: LogicalResolution, rhs: LogicalResolution) -> Bool {
    lhs.area > rhs.area
  }

  @inline(__always)
  public static func == (lhs: LogicalResolution, rhs: LogicalResolution) -> Bool {
    lhs.width == rhs.width && lhs.height == rhs.height
  }
}
