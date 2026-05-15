import UIKit

@objc(Theme)
class Theme: CDVPlugin {

  // MARK: - setStyle

  @objc(setStyle:)
  func setStyle(_ command: CDVInvokedUrlCommand) {
    guard let style = command.arguments.first as? String else {
      let result = CDVPluginResult(status: CDVCommandStatus_ERROR, messageAs: "Missing style argument")
      commandDelegate.send(result, callbackId: command.callbackId)
      return
    }

    guard #available(iOS 13, *) else {
      let result = CDVPluginResult(status: CDVCommandStatus_OK)
      commandDelegate.send(result, callbackId: command.callbackId)
      return
    }

    let interfaceStyle: UIUserInterfaceStyle
    switch style.lowercased() {
    case "light":
      interfaceStyle = .light
    case "dark":
      interfaceStyle = .dark
    default:
      interfaceStyle = .unspecified
    }

    DispatchQueue.main.async { [weak self] in
      self?.viewController.view.window?.overrideUserInterfaceStyle = interfaceStyle
      let result = CDVPluginResult(status: CDVCommandStatus_OK)
      self?.commandDelegate.send(result, callbackId: command.callbackId)
    }
  }

  // MARK: - getStyle

  @objc(getStyle:)
  func getStyle(_ command: CDVInvokedUrlCommand) {
    guard #available(iOS 13, *) else {
      let result = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: "system")
      commandDelegate.send(result, callbackId: command.callbackId)
      return
    }

    DispatchQueue.main.async { [weak self] in
      let style: String
      switch self?.viewController.view.window?.overrideUserInterfaceStyle {
      case .light:
        style = "light"
      case .dark:
        style = "dark"
      default:
        style = "system"
      }
      let result = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: style)
      self?.commandDelegate.send(result, callbackId: command.callbackId)
    }
  }
}
