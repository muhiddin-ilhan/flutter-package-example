// Import helper classes for App Center, Firebase, and App Insights
import 'helpers/app_insights_helper.dart';
import 'helpers/appcenter_helper.dart';
import 'helpers/firebase_helper.dart';

// Export helper classes for external use
export 'helpers/appcenter_helper.dart';
export 'helpers/firebase_helper.dart';
export 'helpers/app_insights_helper.dart';

class VCProductAnalytics {
  /// Singleton instance of VCProductAnalytics
  static final VCProductAnalytics instance = VCProductAnalytics._instance();

  /// Factory constructor to return the singleton instance
  factory VCProductAnalytics() {
    return instance;
  }

  /// Private constructor for the singleton instance
  VCProductAnalytics._instance();

  /// Flags to track initialization status for each analytics service
  bool appCenterInitialized = false;
  bool firebaseInitialized = false;
  bool appInsightsInitialized = false;

  /// Initializes the analytics services.
  ///
  /// Parameters:
  /// - [flutterErrorEnable]: Whether to enable Flutter error reporting (default is false).
  /// - [isFirebaseActive]: Whether Firebase analytics is active (default is false).
  /// - [appCenterSecretKey]: The secret key for initializing App Center analytics (optional).
  /// - [appInsightsInstrumentationKey]: The instrumentation key for initializing App Insights analytics (optional).
  Future<void> init({bool flutterErrorEnable = false, bool isFirebaseActive = false, String? appCenterSecretKey, String? appInsightsInstrumentationKey}) async {
    if(isFirebaseActive){
      firebaseInitialized = await FirebaseHelper.instance.init(flutterErrorEnable: flutterErrorEnable);
    }
    if(appCenterSecretKey is String){
      appCenterInitialized = await AppcenterHelper.instance.init(
          secret: appCenterSecretKey, flutterErrorEnable: flutterErrorEnable);
    }
    if(appInsightsInstrumentationKey is String){
      appInsightsInitialized = await AppInsightsHelper.instance.init(
          secret: appInsightsInstrumentationKey, flutterErrorEnable: flutterErrorEnable);
    }
  }

  /// Tracks an exception across all initialized analytics services.
  ///
  /// Parameters:
  /// - [exception]: The exception object to be tracked.
  /// - [stackTrace]: The stack trace associated with the exception (default is null).
  Future<void> trackException(Object exception, [StackTrace? stackTrace]) async {
    if(appCenterInitialized){
      await AppcenterHelper.instance.trackException(exception, stackTrace);
    }
    if(firebaseInitialized){
      await FirebaseHelper.instance.trackException(exception, stackTrace);
    }
    if(appInsightsInitialized){
      await AppInsightsHelper.instance.trackException(exception, stackTrace);
    }
  }

  /// Tracks a custom event across all initialized analytics services.
  ///
  /// Parameters:
  /// - [event]: The name of the custom event to be tracked.
  Future<void> trackEvent(String event) async {
    if(appCenterInitialized){
      await AppcenterHelper.instance.trackEvent(event);
    }
    if(firebaseInitialized){
      await FirebaseHelper.instance.trackEvent(event);
    }
    if(appInsightsInitialized){
      await AppInsightsHelper.instance.trackEvent(event);
    }
  }
}
