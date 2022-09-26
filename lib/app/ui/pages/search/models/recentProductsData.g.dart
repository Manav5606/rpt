// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recentProductsData.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecentProductsDataModelAdapter
    extends TypeAdapter<RecentProductsDataModel> {
  @override
  final int typeId = 10;

  @override
  RecentProductsDataModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RecentProductsDataModel(
      recentProductsData: (fields[0] as List?)?.cast<RecentProductsData>(),
    );
  }

  @override
  void write(BinaryWriter writer, RecentProductsDataModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.recentProductsData);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecentProductsDataModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class RecentProductsDataAdapter extends TypeAdapter<RecentProductsData> {
  @override
  final int typeId = 11;

  @override
  RecentProductsData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RecentProductsData(
      logo: fields[0] as String?,
      name: fields[1] as String?,
      isStore: fields[2] as bool?,
      sId: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, RecentProductsData obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.logo)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.isStore)
      ..writeByte(3)
      ..write(obj.sId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecentProductsDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
