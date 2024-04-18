import 'package:hive_flutter/hive_flutter.dart';
import 'package:vc_product_network/vc_product_network.dart';
import 'package:vc_product_widgets/helper/local_storage/utils/local_storage_adapter.dart';

/// A singleton class providing helper methods for local storage operations using Hive.
class LocalStorageHelper {

  /// The instance of [LocalStorageHelper], following the Singleton pattern.
  static final LocalStorageHelper instance = LocalStorageHelper._instance();

  /// The reference to the Hive box. Define boxes here
  Box? testBox;

  /// Factory constructor to return the singleton instance of [LocalStorageHelper].
  factory LocalStorageHelper() {
    return instance;
  }

  /// Private constructor for the singleton pattern.
  LocalStorageHelper._instance();

  /// Initializes Hive for Flutter applications and sets up necessary adapters.
  Future<void> initHive() async {
    await Hive.initFlutter();
    initAdapters();
    await initBoxes();
  }

  /// Initializes the Hive box.
  Future<void> initBoxes() async {
    testBox = await Hive.openBox('testBox');
  }

  /// Registers the adapter for the specified type (in this case, [Currency]).
  void initAdapters() {
    Hive.registerAdapter(LocalStorageAdapter<Currency>(1));
  }

  /// Puts an object into the specified Hive box with the given field.
  ///
  /// Parameters:
  /// - [box]: The Hive box where the object will be stored.
  /// - [field]: The field (key) under which the object will be stored.
  /// - [obj]: The object to be stored in the box.
  Future<void> put(Box box, String field, obj) async {
    await box.put(field, obj);
  }

  /// Retrieves an object from the specified Hive box using the given field.
  ///
  /// Parameters:
  /// - [box]: The Hive box from which the object will be retrieved.
  /// - [field]: The field (key) under which the object is stored.
  Future<void> get(Box box, String field) async {
    return box.get(field);
  }

}