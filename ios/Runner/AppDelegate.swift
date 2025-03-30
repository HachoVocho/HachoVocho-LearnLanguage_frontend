import Flutter
import UIKit
import AVFoundation

@main
@objc class AppDelegate: FlutterAppDelegate {
  var audioRecorder: AVAudioRecorder?
  var audioData: Data = Data()
  var methodChannel: FlutterMethodChannel?

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
    methodChannel = FlutterMethodChannel(name: "com.example.hachovocho_learn_language/audio",
                                         binaryMessenger: controller.binaryMessenger)

    methodChannel?.setMethodCallHandler({
      [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
      guard let self = self else { return }

      if call.method == "startRecording" {
        self.startRecording(result: result)
      } else if call.method == "stopRecording" {
        self.stopRecording(result: result)
      } else {
        result(FlutterMethodNotImplemented)
      }
    })

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  func startRecording(result: @escaping FlutterResult) {
    let audioSession = AVAudioSession.sharedInstance()
    do {
      try audioSession.setCategory(.playAndRecord, mode: .default)
      try audioSession.setActive(true)

      let settings: [String: Any] = [
        AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
        AVSampleRateKey: 16000,
        AVNumberOfChannelsKey: 1,
        AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
      ]

      audioRecorder = try AVAudioRecorder(url: getAudioFileURL(), settings: settings)
      audioRecorder?.delegate = self
      audioRecorder?.record()

      result("Recording started")
    } catch {
      result(FlutterError(code: "RECORDING_FAILED",
                          message: "Could not start recording",
                          details: nil))
    }
  }

  func stopRecording(result: @escaping FlutterResult) {
    audioRecorder?.stop()
    audioRecorder = nil

    // Read the recorded audio data
    if let url = getAudioFileURL() as URL? {
      do {
        let data = try Data(contentsOf: url)
        // Optionally, delete the file after reading
        try FileManager.default.removeItem(at: url)
        result(data)
      } catch {
        result(FlutterError(code: "READ_FAILED",
                            message: "Could not read recorded audio",
                            details: nil))
      }
    } else {
      result(FlutterError(code: "URL_FAILED",
                          message: "Invalid audio file URL",
                          details: nil))
    }
  }

  func getAudioFileURL() -> URL {
    let paths = FileManager.default.temporaryDirectory
    return paths.appendingPathComponent("recorded_audio.m4a")
  }
}

extension AppDelegate: AVAudioRecorderDelegate {
  func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
    if !flag {
      methodChannel?.invokeMethod("audioRecordingFailed", arguments: nil)
    }
  }
}

