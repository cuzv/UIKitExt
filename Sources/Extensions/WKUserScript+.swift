import WebKit

public extension WKUserScript {
  ///
  /// ```swift
  /// let controller = WKUserContentController()
  /// controller.add(self, name: "error")
  /// controller.addUserScript(.onerror)
  ///
  /// let configuration = WKWebViewConfiguration()
  /// configuration.userContentController = controller
  ///
  /// let webView = WKWebView(frame: .zero, configuration: configuration)
  /// ```
  ///
  /// Now define your WKScriptMessageHandler:
  /// ```swift
  /// func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
  ///   switch message.name {
  ///   case "error":
  ///     // You should actually handle the error :)
  ///     let error = (message.body as? [String: Any])?["message"] as? String ?? "unknown"
  ///   a ssertionFailure("JavaScript error: \(error)")
  ///   default:
  ///     assertionFailure("Received invalid message: \(message.name)")
  ///   }
  /// }
  /// ```
  static let onerror: WKUserScript = .init(
    source: """
      window.onerror = (msg, url, line, column, error) => {
        const message = {
          message: msg,
          url: url,
          line: line,
          column: column,
          error: JSON.stringify(error)
        }

        if (window.webkit) {
          window.webkit.messageHandlers.error.postMessage(message);
        } else {
          console.log("Error:", message);
        }
      };
      """,
    injectionTime: .atDocumentStart,
    forMainFrameOnly: false
  )
}
