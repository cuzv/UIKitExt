import UIKit

extension UISearchBar {
  @discardableResult
  public func placeholder(_ value: String?) -> Self {
    placeholder = value
    return self
  }

  @discardableResult
  public func prompt(_ value: String?) -> Self {
    prompt = value
    return self
  }

  @discardableResult
  public func text(_ value: String?) -> Self {
    text = value
    return self
  }

  @discardableResult
  public func barTintColor(_ color: UIColor?) -> Self {
    barTintColor = color
    return self
  }

  @discardableResult
  public func tintColor(_ color: UIColor) -> Self {
    tintColor = color
    return self
  }

  @discardableResult
  public func translucent(_ translucent: Bool) -> Self {
    isTranslucent = translucent
    return self
  }

  @discardableResult
  public func barStyle(_ style: UIBarStyle) -> Self {
    barStyle = style
    return self
  }

  @discardableResult
  public func showsBookmarkButton(_ shows: Bool) -> Self {
    showsBookmarkButton = shows
    return self
  }

  @discardableResult
  public func showsCancelButton(_ shows: Bool) -> Self {
    showsCancelButton = shows
    return self
  }

  @discardableResult
  public func showsSearchResultsButton(_ shows: Bool) -> Self {
    showsSearchResultsButton = shows
    return self
  }

  @discardableResult
  public func searchResultsButtonSelected(_ selected: Bool) -> Self {
    isSearchResultsButtonSelected = selected
    return self
  }

  @discardableResult
  public func backgroundImage(_ image: UIImage?) -> Self {
    backgroundImage = image
    return self
  }

  @discardableResult
  public func inputAccessoryView(_ view: UIView?) -> Self {
    inputAccessoryView = view
    return self
  }

  @discardableResult
  public func searchFieldBackgroundPositionAdjustment(_ offset: UIOffset) -> Self {
    searchFieldBackgroundPositionAdjustment = offset
    return self
  }

  @discardableResult
  public func searchTextPositionAdjustment(_ offset: UIOffset) -> Self {
    searchTextPositionAdjustment = offset
    return self
  }

  @discardableResult
  public func scopeButtonTitles(_ titles: [String]?) -> Self {
    scopeButtonTitles = titles
    return self
  }

  @discardableResult
  public func selectedScopeButtonIndex(_ index: Int) -> Self {
    selectedScopeButtonIndex = index
    return self
  }

  @discardableResult
  public func showsScopeBar(_ shows: Bool) -> Self {
    showsScopeBar = shows
    return self
  }

  @discardableResult
  public func scopeBarBackgroundImage(_ image: UIImage?) -> Self {
    scopeBarBackgroundImage = image
    return self
  }
}
