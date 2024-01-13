import UIKit

public extension UISearchBar {
  @discardableResult
  func delegate(_ value: UISearchBarDelegate?) -> Self {
    delegate = value
    return self
  }

  @discardableResult
  func placeholder(_ value: String?) -> Self {
    placeholder = value
    return self
  }

  @discardableResult
  func prompt(_ value: String?) -> Self {
    prompt = value
    return self
  }

  @discardableResult
  func text(_ value: String?) -> Self {
    text = value
    return self
  }

  @discardableResult
  func barTintColor(_ color: UIColor?) -> Self {
    barTintColor = color
    return self
  }

  @discardableResult
  func tintColor(_ color: UIColor) -> Self {
    tintColor = color
    return self
  }

  @discardableResult
  func translucent(_ translucent: Bool) -> Self {
    isTranslucent = translucent
    return self
  }

  @discardableResult
  func barStyle(_ style: UIBarStyle) -> Self {
    barStyle = style
    return self
  }

  @discardableResult
  func showsBookmarkButton(_ shows: Bool) -> Self {
    showsBookmarkButton = shows
    return self
  }

  @discardableResult
  func showsCancelButton(_ shows: Bool) -> Self {
    showsCancelButton = shows
    return self
  }

  @discardableResult
  func showsCancelButton(_ shows: Bool, animated: Bool) -> Self {
    setShowsCancelButton(shows, animated: animated)
    return self
  }

  @discardableResult
  func showsSearchResultsButton(_ shows: Bool) -> Self {
    showsSearchResultsButton = shows
    return self
  }

  @discardableResult
  func searchResultsButtonSelected(_ selected: Bool) -> Self {
    isSearchResultsButtonSelected = selected
    return self
  }

  @discardableResult
  func backgroundImage(_ image: UIImage?) -> Self {
    backgroundImage = image
    return self
  }

  @discardableResult
  func backgroundImage(
    _ backgroundImage: UIImage?,
    for barPosition: UIBarPosition,
    barMetrics: UIBarMetrics
  ) -> Self {
    setBackgroundImage(backgroundImage, for: barPosition, barMetrics: barMetrics)
    return self
  }

  @discardableResult
  func image(
    _ iconImage: UIImage?,
    for icon: UISearchBar.Icon,
    state: UIControl.State
  ) -> Self {
    setImage(iconImage, for: icon, state: state)
    return self
  }

  @discardableResult
  func positionAdjustment(
    _ adjustment: UIOffset,
    for icon: UISearchBar.Icon
  ) -> Self {
    setPositionAdjustment(adjustment, for: icon)
    return self
  }

  @discardableResult
  func inputAccessoryView(_ view: UIView?) -> Self {
    inputAccessoryView = view
    return self
  }

  @discardableResult
  func searchFieldBackgroundImage(
    _ backgroundImage: UIImage?,
    for state: UIControl.State
  ) -> Self {
    setSearchFieldBackgroundImage(backgroundImage, for: state)
    return self
  }

  @discardableResult
  func searchFieldBackgroundPositionAdjustment(_ offset: UIOffset) -> Self {
    searchFieldBackgroundPositionAdjustment = offset
    return self
  }

  @discardableResult
  func searchTextPositionAdjustment(_ offset: UIOffset) -> Self {
    searchTextPositionAdjustment = offset
    return self
  }

  @discardableResult
  func scopeButtonTitles(_ titles: [String]?) -> Self {
    scopeButtonTitles = titles
    return self
  }

  @discardableResult
  func selectedScopeButtonIndex(_ index: Int) -> Self {
    selectedScopeButtonIndex = index
    return self
  }

  @discardableResult
  func showsScopeBar(_ shows: Bool) -> Self {
    showsScopeBar = shows
    return self
  }

  @discardableResult
  func scopeBarBackgroundImage(_ image: UIImage?) -> Self {
    scopeBarBackgroundImage = image
    return self
  }

  @discardableResult
  func scopeBarButtonBackgroundImage(
    _ backgroundImage: UIImage?,
    for state: UIControl.State
  ) -> Self {
    setScopeBarButtonBackgroundImage(backgroundImage, for: state)
    return self
  }

  @discardableResult
  func scopeBarButtonDividerImage(
    _ dividerImage: UIImage?,
    forLeftSegmentState leftState: UIControl.State,
    rightSegmentState rightState: UIControl.State
  ) -> Self {
    setScopeBarButtonDividerImage(
      dividerImage,
      forLeftSegmentState: leftState, rightSegmentState: rightState
    )
    return self
  }

  @discardableResult
  func scopeBarButtonTitleTextAttributes(
    _ attributes: [NSAttributedString.Key: Any]?,
    for state: UIControl.State
  ) -> Self {
    setScopeBarButtonTitleTextAttributes(attributes, for: state)
    return self
  }
}
