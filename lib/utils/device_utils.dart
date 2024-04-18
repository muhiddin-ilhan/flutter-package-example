import 'package:safe_device/safe_device.dart';

class DeviceUtils {
  /// Singleton instance for the DeviceUtils class
  static final DeviceUtils instance = DeviceUtils._instance();

  /// Private variables to store device-related information
  bool? _isJailBroken;
  bool? _isRealDevice;
  bool? _canMockLocation;
  bool? _isOnExternalStorage;
  bool? _isSafeDevice;
  bool? _isDevelopmentModeEnable;

  /// Singleton constructor for DeviceUtils
  factory DeviceUtils() {
    return instance;
  }

  DeviceUtils._instance();

  Future<bool?> isJailBroken() async {
    _isJailBroken ??= await SafeDevice.isJailBroken;
    return _isJailBroken;
  }

  Future<bool?> isRealDevice() async {
    _isRealDevice ??= await SafeDevice.isRealDevice;
    return _isRealDevice;
  }

  Future<bool?> canMockLocation() async {
    _canMockLocation ??= await SafeDevice.isMockLocation;
    return _canMockLocation;
  }

  Future<bool?> isOnExternalStorage() async {
    _isOnExternalStorage ??= await SafeDevice.isOnExternalStorage;
    return _isOnExternalStorage;
  }

  Future<bool?> isSafeDevice() async {
    _isSafeDevice ??= await SafeDevice.isSafeDevice;
    return _isSafeDevice;
  }

  Future<bool?> isDevelopmentModeEnable() async {
    _isDevelopmentModeEnable ??= await SafeDevice.isDevelopmentModeEnable;
    return _isDevelopmentModeEnable;
  }
}
