import UIKit

// MARK: - AppLanguage

public enum AppLanguage {
  private static let kAppleLanguages = "AppleLanguages"

  public static var currentLanguage: String? {
    get {
      UserDefaults.standard.string(forKey: #function) ?? NSLocale.preferredLanguages.first
    }
    set {
      if let newValue, !newValue.isEmpty {
        UserDefaults.standard.set([newValue], forKey: kAppleLanguages)
        UserDefaults.standard.set(newValue, forKey: #function)
      } else {
        UserDefaults.standard.removeObject(forKey: kAppleLanguages)
        UserDefaults.standard.removeObject(forKey: #function)
      }
    }
  }
}

// MARK: -

private var _al_localizedBundleKey: Void?
private var _al_languageKey: Void?

public extension Bundle {
  class func awake() {
    let clazz = Bundle.self
    let originalSelector = #selector(localizedString(forKey:value:table:))
    let overrideSelector = #selector(_al_localizedStringForKey(forKey:value:table:))
    if
      let originalMethod = class_getInstanceMethod(clazz, originalSelector),
      let overrideMethod = class_getInstanceMethod(clazz, overrideSelector)
    {
      if class_addMethod(
        clazz,
        originalSelector,
        method_getImplementation(overrideMethod),
        method_getTypeEncoding(overrideMethod)
      ) {
        class_replaceMethod(
          clazz,
          overrideSelector,
          method_getImplementation(originalMethod),
          method_getTypeEncoding(originalMethod)
        )
      } else {
        method_exchangeImplementations(originalMethod, overrideMethod)
      }
    }
  }

  @objc func _al_localizedStringForKey(
    forKey key: String, value: String?, table tableName: String?
  ) -> String {
    _al_localizedBundle._al_localizedStringForKey(
      forKey: key, value: value, table: tableName
    )
  }

  private var _al_localizedBundle: Bundle {
    var bundle: Bundle?
    let currentLanguage = AppLanguage.currentLanguage
    let previousLanguage = _al_language

    if currentLanguage == nil, previousLanguage == nil {
      bundle = self
      objc_setAssociatedObject(
        self, &_al_localizedBundleKey, nil, .OBJC_ASSOCIATION_RETAIN_NONATOMIC
      )
    } else if currentLanguage == previousLanguage {
      bundle = objc_getAssociatedObject(
        self, &_al_localizedBundleKey
      ) as? Bundle
    } else {
      objc_setAssociatedObject(
        self, &_al_localizedBundleKey, nil, .OBJC_ASSOCIATION_RETAIN_NONATOMIC
      )
    }

    if
      bundle == nil,
      let currentLanguage,
      !currentLanguage.isEmpty,
      let path = Bundle.main.path(forResource: currentLanguage, ofType: "lproj")
    {
      bundle = Bundle(path: path)
      objc_setAssociatedObject(
        self, &_al_localizedBundleKey,
        bundle, .OBJC_ASSOCIATION_RETAIN_NONATOMIC
      )
      _al_language = currentLanguage
    }

    return bundle ?? self
  }

  private var _al_language: String? {
    get {
      objc_getAssociatedObject(self, &_al_languageKey) as? String
    }
    set {
      objc_setAssociatedObject(
        self, &_al_languageKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC
      )
    }
  }
}

// MARK: -

// See https://stackoverflow.com/questions/42824541/swift-3-1-deprecates-initialize-how-can-i-achieve-the-same-thing/42824542
extension UIApplication {
  private static let runOnce: Void = {
    Bundle.awake()
  }()

  override open var next: UIResponder? {
    // Called before applicationDidFinishLaunching
    UIApplication.runOnce
    return super.next
  }
}
