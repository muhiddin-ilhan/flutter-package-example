// ignore_for_file: avoid_shadowing_type_parameters

import 'package:hive_flutter/hive_flutter.dart';
import 'package:vc_product_network/vc_product_network.dart';

/// A generic Hive adapter for objects that extend [LocalStorageModel].
class LocalStorageAdapter<T extends BaseModel> extends TypeAdapter<T> {
  /// Constructor that takes a [typeId] to uniquely identify the type in Hive.
  LocalStorageAdapter(this.typeId);

  @override
  final int typeId;

  /// Reads the object from binary data.
  @override
  T read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };

    // Calls the `fromJson` method to create an instance of the object.
    var instance = fromJson<T>(fields[0], T as T);

    return instance;
  }

  /// Converts the JSON map to an object using the `fromJson` method.
  fromJson<T extends BaseModel>(Map<String, dynamic> json, T obj) {
    return obj.fromJson(json);
  }

  /// Writes the object to binary data.
  @override
  void write(BinaryWriter writer, T obj) {
    writer
      ..writeByte(1) // Number of fields in the object.
      ..writeByte(0) // Index of the first field.
      ..write(obj.toJson()); // Writes the object as JSON.
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) {
    // The default equality check provided by Hive.
    return super == other;
  }
}
