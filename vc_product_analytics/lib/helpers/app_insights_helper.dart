import 'package:azure_application_insights/azure_application_insights.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'analytics_helper.dart';

class AppInsightsHelper extends AnalyticsHelper {
  /// Singleton instance of AppInsightsHelper
  static final AppInsightsHelper instance = AppInsightsHelper._instance();

  final client = Client();

  BufferedProcessor? processor;

  TelemetryClient? telemetryClient;

  /// Factory constructor to return the singleton instance
  factory AppInsightsHelper() {
    return instance;
  }

  /// Private constructor for the singleton instance
  AppInsightsHelper._instance();

  /// Flag to check if the AppInsightsHelper has been initialized
  bool _initialized = false;

  /// Initializes AppInsights with the provided secret.
  /// Optionally, enables Flutter error reporting.
  ///
  /// Parameters:
  /// - [secret]: The AppInsights instrumentationKey to initialize the SDK.
  /// - [flutterErrorEnable]: Whether to enable Flutter error reporting (default is false).
  @override
  Future<bool> init({String? secret, bool flutterErrorEnable = false}) async {
    if (!_initialized) {
      if (secret is String) {
        // Create a processor that will handle the telemetry items.
        processor = BufferedProcessor(
          next: TransmissionProcessor(
            instrumentationKey: secret,
            httpClient: client,
            timeout: const Duration(seconds: 10),
          ),
        );

        // Create a telemetry client that uses the processor.
        telemetryClient = TelemetryClient(
          processor: processor!,
        );
        _initialized = true;
      } else {
        debugPrint('Error: Secret can not be null for AppInsightsHelper.');
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

  /// Tracks an exception with App Insights.
  ///
  /// Parameters:
  /// - [exception]: The exception object to be tracked.
  /// - [stackTrace]: The stack trace associated with the exception (default is null).
  @override
  Future<void> trackException(Object exception,
      [StackTrace? stackTrace]) async {
    if (_initialized) {
      try {
        // Get any additional properties for the crash report here, such as device information.
        final Map<String, Object> errorProperties = {};

        // Write an error telemetry item.
        telemetryClient?.trackError(
          error: exception,
          stackTrace: stackTrace,
          severity: Severity.error,
          additionalProperties: errorProperties,
        );
      } on Object catch (e, t) {
        // Print synchronously here to ensure the output is written in the case we force exit.
        debugPrint('Sending error telemetry failed: $e\r\n$t');
        debugPrint('Original error: $exception');
      }
    } else {
      // Handle error, init method should be called first
      debugPrint('Error: AppInsightsHelper not initialized. Call init method first.');
    }
  }

  /// Tracks a custom event with the provided [event] name.
  ///
  /// Parameters:
  /// - [event]: The name of the custom event to be tracked.
  @override
  Future<void> trackEvent(String event) async {
    telemetryClient?.trackEvent(name: event);
  }
}
