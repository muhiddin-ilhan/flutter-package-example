// ignore_for_file: unused_field

abstract class AnalyticsHelper {
  /// Flag to check if the helper has been initialized
  // ignore: prefer_final_fields
  bool _initialized = false;

  /// Initializes the analytics SDK.
  ///
  /// Parameters:
  /// - [secret]: The secret to initialize the SDK.
  /// - [flutterErrorEnable]: Whether to enable Flutter error reporting (default is false).
  Future<bool> init({String? secret, bool flutterErrorEnable = false});

  /// Enables or disables Flutter error reporting.
  ///
  /// Parameters:
  /// - [isEnabled]: Whether to enable or disable Flutter error reporting.
  Future<void> flutterOnError(bool isEnabled);

  /// Activates Flutter error reporting.
  Future<void> flutterOnErrorActivate();

  /// Deactivates Flutter error reporting.
  Future<void> flutterOnErrorDeactivate();

  /// Tracks an exception with the analytics SDK.
  ///
  /// Parameters:
  /// - [exception]: The exception object to be tracked.
  /// - [stackTrace]: The stack trace associated with the exception (default is null).
  Future<void> trackException(Object exception, [StackTrace? stackTrace]);

  /// Tracks a custom event.
  ///
  /// Parameters:
  /// - [event]: The name of the custom event to be tracked.
  Future<void> trackEvent(String event);
}
