import UIKit

public extension UIScreen {
  var logicalResolution: LogicalResolution {
    LogicalResolution(width: bounds.size.width, height: bounds.size.height)
  }

  struct LogicalResolution {
    public let width: CGFloat
    public let height: CGFloat
  }
}

extension UIScreen.LogicalResolution: Comparable {
  @inline(__always)
  public static func == (lhs: Self, rhs: Self) -> Bool {
    lhs.area == rhs.area
  }

  @inline(__always)
  private var area: CGFloat {
    width * height
  }

  @inline(__always)
  public static func < (lhs: Self, rhs: Self) -> Bool {
    lhs.area < rhs.area
  }

  @inline(__always)
  public static func > (lhs: Self, rhs: Self) -> Bool {
    lhs.area > rhs.area
  }
}

extension UIScreen.LogicalResolution: CustomStringConvertible {
  public var description: String {
    "(\(width), \(height))"
  }
}

public extension UIScreen.LogicalResolution {
  /// Returns whether this resolution is Portrait.
  var isPortrait: Bool {
    width < height
  }

  /// Returns whether this resolution is Landscape.
  var isLandscape: Bool {
    !isPortrait
  }

  /// Returns portrait version of this resolution.
  var portrait: Self {
    Self(width: min(width, height), height: max(width, height))
  }

  /// Returns landscape version of this resolution.
  var landscape: Self {
    Self(width: max(width, height), height: min(width, height))
  }

  /// 430 x 932 points
  ///
  /// iPhone 6.7-inch
  /// - iPhone 14 Pro Max
  ///
  /// Consider identical to `w932h430`, only this is Portrait.
  static let w430h932 = Self(width: 430, height: 932)

  /// 932 x 430 points
  ///
  /// iPhone 6.7-inch
  /// - iPhone 14 Pro Max
  ///
  /// Consider identical to `w430h932`, only this is Landscape.
  static let w932h430 = Self(width: 932, height: 430)

  /// 428 x 926 points
  ///
  /// iPhone 6.7-inch
  /// - iPhone 12 Pro Max, iPhone 13 Pro Max, iPhone 14 Plus
  ///
  /// Consider identical to `w926h428`, only this is Portrait.
  static let w428h926 = Self(width: 428, height: 926)

  /// 926 x 428 points
  ///
  /// iPhone 6.7-inch
  /// - iPhone 12 Pro Max, iPhone 13 Pro Max, iPhone 14 Plus
  ///
  /// Consider identical to `w428h926`, only this is Landscape.
  static let w926h428 = Self(width: 926, height: 428)

  /// 414 x 896 points
  ///
  /// iPhone 6.5-inch
  /// - iPhone XS Max, iPhone 11 Pro Max
  ///
  /// iPhone 6.1-inch
  /// - iPhone XR, iPhone 11
  ///
  /// Consider identical to `w898h414`, only this is Portrait.
  static let w414h898 = Self(width: 414, height: 898)

  /// 896 x 414 points
  ///
  /// iPhone 6.5-inch
  /// - iPhone XS Max, iPhone 11 Pro Max
  ///
  /// iPhone 6.1-inch
  /// - iPhone XR, iPhone 11
  ///
  /// Consider identical to `w414h898`, only this is Landscape.
  static let w898h414 = Self(width: 898, height: 414)

  /// 393 x 852 points
  ///
  /// iPhone 6.1-inch
  /// - iPhone 14 Pro
  ///
  /// Consider identical to `w852h393`, only this is Portrait.
  static let w393h852 = Self(width: 393, height: 852)

  /// 852 x 393 points
  ///
  /// iPhone 6.1-inch
  /// - iPhone 14 Pro
  ///
  /// Consider identical to `w393h852`, only this is Landscape.
  static let w852h393 = Self(width: 852, height: 393)

  /// 390 x 844 points
  ///
  /// iPhone 6.1-inch
  /// - iPhone 12, iPhone 12 Pro, Phone 13, iPhone 13 Pro, iPhone 14
  ///
  /// Consider identical to `w844h390`, only this is Portrait.
  static let w390h844 = Self(width: 390, height: 844)

  /// 844 x 390 points
  ///
  /// iPhone 6.1-inch
  /// - iPhone 12, iPhone 12 Pro, Phone 13, iPhone 13 Pro, iPhone 14
  ///
  /// Consider identical to `w390h844`, only this is Landscape.
  static let w844h390 = Self(width: 844, height: 390)

  /// 375 x 812 points
  ///
  /// iPhone 5.8-inch
  /// - iPhone X, iPhone XS, iPhone 11 Pro
  ///
  /// iPhone 5.4-inch
  /// - iPhone 12 Mini, iPhone 13 Mini
  ///
  /// Consider identical to `w812h375`, only this is Portrait.
  static let w375h812 = Self(width: 375, height: 812)

  /// 375 x 812 points
  ///
  /// iPhone 5.8-inch
  /// - iPhone X, iPhone XS, iPhone 11 Pro
  ///
  /// iPhone 5.4-inch
  /// - iPhone 12 Mini, iPhone 13 Mini
  ///
  /// Consider identical to `w375h812`, only this is Landscape.
  static let w812h375 = Self(width: 812, height: 375)

  /// 414 x 736 points
  ///
  /// iPhone 5.5-inch
  /// - iPhone 6 Plus, iPhone 6S Plus, iPhone 7 Plus, iPhone 8 Plus
  ///
  /// Consider identical to `w736h414`, only this is Portrait.
  static let w414h736 = Self(width: 414, height: 736)

  /// 736 x 414 points
  ///
  /// iPhone 5.5-inch
  /// - iPhone 6 Plus, iPhone 6S Plus, iPhone 7 Plus, iPhone 8 Plus
  ///
  /// Consider identical to `w414h736`, only this is Landscape.
  static let w736h414 = Self(width: 736, height: 414)

  /// 375 x 667 points
  ///
  /// iPhone 4.7-inch
  /// - iPhone 6, iPhone 6S, iPhone 7, iPhone 8, iPhone SE2, iPhone SE3
  ///
  /// Consider identical to `w667h375`, only this is Portrait.
  static let w375h667 = Self(width: 375, height: 667)

  /// 667 x 375 points
  ///
  /// iPhone 4.7-inch
  /// - iPhone 6, iPhone 6S, iPhone 7, iPhone 8, iPhone SE2, iPhone SE3
  ///
  /// Consider identical to `w375h667`, only this is Landscape.
  static let w667h375 = Self(width: 667, height: 375)

  /// 320 x 568 points
  ///
  /// iPhone 4-inch
  /// - iPhone 5, iPhone 5S, iPhone 5C, iPhone SE
  ///
  /// Consider identical to `w568h320`, only this is Portrait.
  static let w320h568 = Self(width: 320, height: 568)

  /// 568 x 320 points
  ///
  /// iPhone 4-inch
  /// - iPhone 5, iPhone 5S, iPhone 5C, iPhone SE
  ///
  /// Consider identical to `w320h568`, only this is Landscape.
  static let w568h320 = Self(width: 568, height: 320)

  /// 320 x 480 points
  ///
  /// iPhone (Legacy) & iPod Touch
  /// - 1st, 2nd and 3rd Generation
  ///
  /// iPhone 3.5-inch
  /// - iPhone 4, iPhone 4S
  ///
  /// Consider identical to `w480h320`, only this is Portrait.
  static let w320h480 = Self(width: 320, height: 480)

  /// 480 x 320 points
  ///
  /// iPhone (Legacy) & iPod Touch
  /// - 1st, 2nd and 3rd Generation
  ///
  /// iPhone 3.5-inch
  /// - iPhone 4, iPhone 4S
  ///
  /// Consider identical to `w320h480`, only this is Landscape.
  static let w480h320 = Self(width: 480, height: 320)

  /// 1024 x 1366 points
  ///
  /// iPad Pro 12.9-inch
  /// - iPad Pro 12.9-inch 1st, 2nd, 3rd, 4th, 5th and 6th Generation
  ///
  /// Consider identical to `w1366h1024`, only this is Portrait.
  static let w1024h1366 = Self(width: 1024, height: 1366)

  /// 1366 x 1024 points
  ///
  /// iPad Pro 12.9-inch
  /// - iPad Pro 12.9-inch 1st, 2nd, 3rd, 4th, 5th and 6th Generation
  ///
  /// Consider identical to `w1024h1366`, only this is Landscape.
  static let w1366h1024 = Self(width: 1366, height: 1024)

  /// 834 x 1194 points
  ///
  /// iPad Pro 11-inch
  /// - iPad Pro 11-inch 1st, 2nd, 3rd and 4th Generation
  ///
  /// Consider identical to `w1194h834`, only this is Portrait.
  static let w834h1194 = Self(width: 834, height: 1194)

  /// 1194 x 834 points
  ///
  /// iPad Pro 11-inch
  /// - iPad Pro 11-inch 1st, 2nd, 3rd and 4th Generation
  ///
  /// Consider identical to `w834h1194`, only this is Landscape.
  static let w1194h834 = Self(width: 1194, height: 834)

  /// 834 x 1112 points
  ///
  /// iPad 10.5-inch
  /// - iPad Pro 10.5, iPad Air 3rd Generation
  ///
  /// Consider identical to `w1112h834`, only this is Portrait.
  static let w834h1192 = Self(width: 834, height: 1112)

  /// 1112 x 834 points
  ///
  /// iPad 10.5-inch
  /// - iPad Pro 10.5, iPad Air 3rd Generation
  ///
  /// Consider identical to `w834h1192`, only this is Landscape.
  static let w1112h834 = Self(width: 1112, height: 834)

  /// 820 × 1180 points
  ///
  /// iPad 10.9-inch
  /// - iPad 10th Generation
  /// - iPad Air 5th
  ///
  /// Consider identical to `w1180h820`, only this is Portrait.
  static let w820h1180 = Self(width: 820, height: 1180)

  /// 1180 × 820 points
  ///
  /// iPad 10.9-inch
  /// - iPad 10th Generation
  /// - iPad Air 5th
  ///
  /// Consider identical to `w820h1180`, only this is Landscape.
  static let w1180h820 = Self(width: 1180, height: 820)

  /// 810 x 1080 points
  ///
  /// iPad 10.2-inch
  /// - iPad 7th, 8th adn 9th Generation
  ///
  /// Consider identical to `w1080h810`, only this is Portrait.
  static let w810h1080 = Self(width: 810, height: 1080)

  /// 1080 x 810 points
  ///
  /// iPad 10.2-inch
  /// - iPad 7th, 8th adn 9th Generation
  ///
  /// Consider identical to `w810h1080`, only this is Landscape.
  static let w1080h810 = Self(width: 1080, height: 810)

  /// 768 x 1024 points
  ///
  /// iPad 9.7-inch Retina
  /// - iPad 3rd, iPad 4th, iPad Air 1st, iPad Air 2nd, iPad Pro 9.7-inch, iPad 5th, iPad 6th Generation
  ///
  /// iPad (Legacy)
  /// - 1st and 2nd Generation
  ///
  /// iPad Mini Retina
  /// - iPad Mini 2nd, 3rd, 4th and 5th Generation
  ///
  /// iPad Mini (Legacy)
  /// - iPad Mini 1st Generation
  ///
  /// Consider identical to `w1024h768`, only this is Portrait.
  static let w768h1024 = Self(width: 768, height: 1024)

  /// 1024 x 768 points
  ///
  /// iPad 9.7-inch Retina
  /// - iPad 3rd, iPad 4th, iPad Air 1st, iPad Air 2nd, iPad Pro 9.7-inch, iPad 5th, iPad 6th Generation
  ///
  /// iPad (Legacy)
  /// - 1st and 2nd Generation
  ///
  /// iPad Mini Retina
  /// - iPad Mini 2nd, 3rd, 4th and 5th Generation
  ///
  /// iPad Mini (Legacy)
  /// - iPad Mini 1st Generation
  ///
  /// Consider identical to `w768h1024`, only this is Landscape.
  static let w1024h768 = Self(width: 1024, height: 768)

  /// 744 x 1133 points
  ///
  /// iPad 8.3-inch
  /// - iPad Mini 6th Generation
  ///
  /// Consider identical to `w1133h744`, only this is Landscape.
  static let w744h1133 = Self(width: 744, height: 1133)

  /// 1133 x 744 points
  ///
  /// iPad 8.3-inch
  /// - iPad Mini 6th Generation
  ///
  /// Consider identical to `w744h1133`, only this is Landscape.
  static let w1133h744 = Self(width: 1133, height: 744)
}
