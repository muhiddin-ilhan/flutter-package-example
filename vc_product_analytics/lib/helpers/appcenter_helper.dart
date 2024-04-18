// ignore_for_file: override_on_non_overriding_member

import 'package:appcenter_sdk_flutter/appcenter_sdk_flutter.dart';
import 'package:flutter/material.dart';

import 'analytics_helper.dart';

class AppcenterHelper extends AnalyticsHelper {
  /// Singleton instance of AppcenterHelper
  static final AppcenterHelper instance = AppcenterHelper._instance();

  /// Represents whether App Center is enabled or not
  bool? isEnabled;

  /// Represents whether App Center is configured or not
  bool? isConfigured;

  /// Unique identifier for the installation of the app
  String? installId;

  /// Indicates whether the app is running in App Center Test Cloud
  bool? isRunningInAppCenterTestCloud;

  /// Represents whether crash reporting is enabled or not
  bool? isCrashEnabled;

  /// Factory constructor to return the singleton instance
  factory AppcenterHelper() {
    return instance;
  }

  /// Private constructor for the singleton instance
  AppcenterHelper._instance();

  /// Flag to check if the AppcenterHelper has been initialized
  @override
  bool _initialized = false;

  /// Initializes App Center SDK with the provided secret.
  /// Optionally, enables Flutter error reporting.
  ///
  /// Parameters:
  /// - [secret]: The App Center secret to initialize the SDK.
  /// - [flutterErrorEnable]: Whether to enable Flutter error reporting (default is false).
  @override
  Future<bool> init({String? secret, bool flutterErrorEnable = false}) async {
    if (!_initialized) {
      if (secret is String) {
        await AppCenter.start(secret: secret);
        await AppCenterCrashes.enable();
        isEnabled = await AppCenter.isEnabled();
        isConfigured = await AppCenter.isConfigured();
        installId = await AppCenter.getInstallId();
        isCrashEnabled = await AppCenterCrashes.isEnabled();
        isRunningInAppCenterTestCloud =
            await AppCenter.isRunningInAppCenterTestCloud();
        await flutterOnError(flutterErrorEnable);
        _initialized = true;
      } else {
        debugPrint('Error: Secret can not be null for AppCenterHelper.');
      }
    }
    return _initialized;
  }

  /// Enables or disables Flutter error reporting based on the provided [isEnabled] parameter.
  ///
  /// Parameters:
  /// - [isEnabled]: Whether to enable or disable Flutter error reporting.
  @override
  Future<void> flutterOnError(bool isEnabled) async {
    if (isEnabled) {
      await flutterOnErrorActivate();
    } else {
      await flutterOnErrorDeactivate();
    }
  }

  /// Activates Flutter error reporting.
  @override
  Future<void> flutterOnErrorActivate() async {
    FlutterError.onError = (final details) async {
      await trackException(details.exception, details.stack);
    };
  }

  /// Deactivates Flutter error reporting.
  @override
  Future<void> flutterOnErrorDeactivate() async {
    FlutterError.onError = (final details) async {};
  }

  /// Tracks an exception with App Center SDK.
  ///
  /// Parameters:
  /// - [exception]: The exception object to be tracked.
  /// - [stackTrace]: The stack trace associated with the exception (default is null).
  @override
  Future<void> trackException(Object exception,
      [StackTrace? stackTrace]) async {
    if (_initialized) {
      await AppCenterCrashes.trackException(
        message: exception.toString(),
        type: exception.runtimeType,
        stackTrace: stackTrace,
      );
    } else {
      // Handle error, init method should be called first
      debugPrint(
          'Error: AppcenterHelper not initialized. Call init method first.');
    }
  }

  /// Generates a test crash for testing purposes.
  Future<void> testCrash() async {
    AppCenterCrashes.generateTestCrash();
  }

  /// Tracks a custom event with the provided [event] name.
  ///
  /// Parameters:
  /// - [event]: The name of the custom event to be tracked.
  @override
  Future<void> trackEvent(String event) async {
    await AppCenterAnalytics.trackEvent(name: event);
  }
}
