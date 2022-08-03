import Flutter
import UIKit
import INFOnlineLibrary

public class SwiftFlutterInfonlineLibraryPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_infonline_library", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterInfonlineLibraryPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    let arguments = call.arguments as? NSDictionary
      
    switch call.method {
      case "startIOMpSession":
        startIOMpSession(
          sessionType: arguments!["sessionType"] as! String,
          type: arguments!["type"] as! String,
          offerIdentifier: arguments!["offerIdentifier"] as! String,
          hybridIdentifier: arguments!["hybridIdentifier"] as? String,
          customerData: arguments!["customerData"] as? String
        )
        result(true)
        break
      case "logViewEvent":
        logViewEvent(
          sessionType: arguments!["sessionType"] as! String,
          type: arguments!["type"] as! String,
          category: arguments!["category"] as! String,
          comment: arguments!["comment"] as? String
        )
        result(true)
        break     
      case "setCustomConsent":
        setCustomConsent(
          sessionType: arguments!["sessionType"] as! String,
          consent: arguments!["consent"] as! String
        )
        result(true)
        break
      case "mostRecentLogs":
        result(mostRecentLogs(arguments!["limit"] as! UInt))
        break
      case "setDebugLogLevel":
        setDebugLogLevel(arguments!["level"] as! String)
        result(true)
        break
      case "sendLoggedEvents":
        sendLoggedEvents(arguments!["sessionType"] as! String)
        result(true)
        break
      case "terminateSession":
        terminateSession(arguments!["sessionType"] as! String)
        result(true)
        break
      default:
        result(true)
        break
    }
  }

  // Flutter API methods

  private func startIOMpSession(sessionType: String, type: String, offerIdentifier: String, hybridIdentifier: String?, customerData: String?) {
    let types = ["ack","lin","pio"]
    defaultSession(sessionType).start(
      withOfferIdentifier: offerIdentifier, 
      privacyType: IOLPrivacyType(rawValue: stringToEnumValue(type, values: types))!, 
      hybridIdentifier: hybridIdentifier, 
      customerData: customerData
    )
  }

  private func logViewEvent(sessionType: String, type: String, category: String, comment: String?) {
    let types = ["appeared","refreshed","disappeared"]
    let eventType = IOLViewEventType(rawValue: stringToEnumValue(type, values: types))!
    let event = IOLViewEvent(type: eventType, category: category, comment: comment)
    defaultSession(sessionType).logEvent(event)
  }

  private func setCustomConsent(sessionType: String, consent: String) {
    defaultSession(sessionType).setCustomConsent(consent)
  }

  private func sendLoggedEvents(_ sessionType: String) {
    defaultSession(sessionType).sendLoggedEvents()
  }

  private func terminateSession(_ sessionType: String) {
    defaultSession(sessionType).terminateSession()
  }

  private func mostRecentLogs(_ limit: UInt) -> [String] {
    return IOLLogging.mostRecentLogs(withLimit: limit)
  }
  
  private func setDebugLogLevel(_ level: String) {
    let levels = ["off","error","warning","info","trace"]
    let level = IOLDebugLevel(rawValue: stringToEnumValue(level, values: levels))!
    IOLLogging.setDebugLogLevel(level)
  }

  // Helper functions

  private func sessionTypeToEnum(_ type: String) -> IOLSessionType {
    let types = ["SZM","OEWA"]
    return IOLSessionType(rawValue: stringToEnumValue(type, values: types))!
  }

  private func defaultSession(_ sessionType: String) -> IOLSession {
    return IOLSession.defaultSession(for: sessionTypeToEnum(sessionType))
  }

  private func stringToEnumValue(_ value: String, values: [String]) -> UInt {
      return UInt(values.firstIndex(where: {$0 == value}) ?? 0)
  }
}
