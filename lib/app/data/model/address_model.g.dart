// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AddressModelAdapter extends TypeAdapter<AddressModel> {
  @override
  final int typeId = 1;

  @override
  AddressModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AddressModel(
      address: fields[1] as String?,
      apartment: fields[4] as String?,
      house: fields[3] as String?,
      location: fields[6] as CoordinateModel?,
      status: fields[5] as bool?,
      title: fields[2] as String?,
      directionReach: fields[7] as String?,
      id: fields[0] as String?,
      distance: fields[8] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, AddressModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.address)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.house)
      ..writeByte(4)
      ..write(obj.apartment)
      ..writeByte(5)
      ..write(obj.status)
      ..writeByte(6)
      ..write(obj.location)
      ..writeByte(7)
      ..write(obj.directionReach)
      ..writeByte(8)
      ..write(obj.distance);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddressModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CoordinateModelAdapter extends TypeAdapter<CoordinateModel> {
  @override
  final int typeId = 3;

  @override
  CoordinateModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CoordinateModel(
      lat: fields[0] as double?,
      lng: fields[1] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, CoordinateModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.lat)
      ..writeByte(1)
      ..write(obj.lng);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CoordinateModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
