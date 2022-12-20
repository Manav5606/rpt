// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_near_me_page_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GetNearMePageDataAdapter extends TypeAdapter<GetNearMePageData> {
  @override
  final int typeId = 5;

  @override
  GetNearMePageData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GetNearMePageData(
      msg: fields[0] as String?,
      data: fields[1] as NearMePageData?,
    );
  }

  @override
  void write(BinaryWriter writer, GetNearMePageData obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.msg)
      ..writeByte(1)
      ..write(obj.data);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GetNearMePageDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class NearMePageDataAdapter extends TypeAdapter<NearMePageData> {
  @override
  final int typeId = 6;

  @override
  NearMePageData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NearMePageData(
      sId: fields[0] as String?,
      products: (fields[1] as List?)?.cast<Products>(),
      stores: (fields[2] as List?)?.cast<Stores>(),
      inventories: (fields[3] as List?)?.cast<Products>(),
    );
  }

  @override
  void write(BinaryWriter writer, NearMePageData obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.sId)
      ..writeByte(1)
      ..write(obj.products)
      ..writeByte(2)
      ..write(obj.stores)
      ..writeByte(3)
      ..write(obj.inventories);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NearMePageDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ProductsAdapter extends TypeAdapter<Products> {
  @override
  final int typeId = 7;

  @override
  Products read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Products(
      sId: fields[0] as String?,
      name: fields[1] as String?,
      logo: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Products obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.sId)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.logo)
      ..writeByte(3)
      ..writeByte(4)
      ..write(obj.store);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

@override
final int typeId = 8;

class StoresAdapter extends TypeAdapter<Stores> {
  @override
  final int typeId = 9;

  @override
  Stores read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Stores(
      name: fields[0] as String?,
      logo: fields[1] as String?,
      businesstype: fields[3] as String?,
      sId: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Stores obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.logo)
      ..writeByte(2)
      ..write(obj.sId)
      ..writeByte(3)
      ..write(obj.businesstype);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StoresAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
