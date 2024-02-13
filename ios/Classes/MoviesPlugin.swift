import Flutter
import UIKit
import Foundation

public class MoviesPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "movies_plugin", binaryMessenger: registrar.messenger())
    let instance = MoviesPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPlatformVersion":
      result("iOS " + UIDevice.current.systemVersion)
    case "searchMovies":
       fetchDataFromAPI { data, error in
                if let error = error {
                    result(FlutterError(code: "ERROR", message: error.localizedDescription, details: nil))
                } else {
                    result(data)
                }
            }
    default:
      result(FlutterMethodNotImplemented)
    }
  }

    private func fetchDataFromAPI(completion: @escaping (String?, Error?) -> Void) {
        let url = URL(string: "http://www.omdbapi.com/?t=$title&apikey=bb307c48")!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(nil, error)
            } else if let data = data,
                      let string = String(data: data, encoding: .utf8) {
                completion(string, nil)
            } else {
                completion(nil, NSError(domain: "YourPlugin", code: 0, userInfo: [NSLocalizedDescriptionKey: "Unknown error"]))
            }
        }
        task.resume()
    }
}
