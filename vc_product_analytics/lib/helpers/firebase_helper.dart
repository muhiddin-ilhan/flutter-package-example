// ignore_for_file: override_on_non_overriding_member

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:vc_product_analytics/helpers/analytics_helper.dart';

import '../configurations/firebase_options.dart';

class FirebaseHelper extends AnalyticsHelper {
  /// Singleton instance of FirebaseHelper
  static final FirebaseHelper instance = FirebaseHelper._instance();

  /// Unique identifier for the app instance
  String? appInstanceId;

  /// Analytics session ID
  int? analyticsSessionId;

  /// Indicates whether analytics is supported
  bool? isAnalyticsSupported;

  /// Indicates whether Crashlytics collection is enabled
  bool? isCrashlyticsCollectionEnabled;

  /// Factory constructor to return the singleton instance
  factory FirebaseHelper() {
    return instance;
  }

  /// Private constructor for the singleton instance
  FirebaseHelper._instance();

  /// Flag to check if the FirebaseHelper has been initialized
  @override
  bool _initialized = false;

  /// Initializes Firebase SDK with the provided secret.
  /// Optionally, enables Flutter error reporting.
  ///
  /// Parameters:
  /// - [flutterErrorEnable]: Whether to enable Flutter error reporting (default is false).
  @override
  Future<bool> init({String? secret, bool flutterErrorEnable = false}) async {
    if (!_initialized) {
      try {
        await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        );

        await FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);
        await FirebaseCrashlytics.instance
            .setCrashlyticsCollectionEnabled(true);
        // appInstanceId = await FirebaseAnalytics.instance.appInstanceId;
        // analyticsSessionId = await FirebaseAnalytics.instance.getSessionId();
        // isAnalyticsSupported = await FirebaseAnalytics.instance.isSupported();
        isCrashlyticsCollectionEnabled =
            FirebaseCrashlytics.instance.isCrashlyticsCollectionEnabled;
        await flutterOnError(flutterErrorEnable);
        _initialized = true;
      } catch (e) {
        debugPrint("Failed to initialize Firebase: $e");
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
      await FirebaseCrashlytics.instance.recordFlutterError(details);
    };
  }

  /// Deactivates Flutter error reporting.
  @override
  Future<void> flutterOnErrorDeactivate() async {
    FlutterError.onError = (final details) async {};
  }

  /// Tracks an exception with Firebase Crashlytics.
  ///
  /// Parameters:
  /// - [exception]: The exception object to be tracked.
  /// - [stackTrace]: The stack trace associated with the exception (default is null).
  @override
  Future<void> trackException(Object exception,
      [StackTrace? stackTrace]) async {
    if (_initialized) {
      await FirebaseCrashlytics.instance.recordError(exception, stackTrace);
    } else {
      /// Handle error, init method should be called first
      debugPrint(
          'Error: FirebaseHelper not initialized. Call init method first.');
    }
  }

  /// Tracks a custom event with the provided [event] name using Firebase Analytics.
  ///
  /// Parameters:
  /// - [event]: The name of the custom event to be tracked.
  @override
  Future<void> trackEvent(String event) async {
    await FirebaseAnalytics.instance.logEvent(name: event);
  }
}
