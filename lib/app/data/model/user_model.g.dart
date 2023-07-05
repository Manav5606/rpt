// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 0;

  @override
  UserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModel(
      id: fields[0] as String?,
      firstName: fields[1] as String?,
      wallet: (fields[11] as List?)?.cast<Wallet>(),
      lastName: fields[2] as String?,
      mobile: fields[3] as String?,
      email: fields[4] as String?,
      addresses: (fields[5] as List?)?.cast<AddressModel>(),
      balance: fields[6] as double?,
      logo: fields[7] as String?,
      dateOfBirth: fields[8] as String?,
      maleOrFemale: fields[9] as String?,
      rank: fields[10] as int?,
      restoreID: fields[12] as String?,
      deactivated: fields[13] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.firstName)
      ..writeByte(2)
      ..write(obj.lastName)
      ..writeByte(3)
      ..write(obj.mobile)
      ..writeByte(4)
      ..write(obj.email)
      ..writeByte(5)
      ..write(obj.addresses)
      ..writeByte(6)
      ..write(obj.balance)
      ..writeByte(7)
      ..write(obj.logo)
      ..writeByte(8)
      ..write(obj.dateOfBirth)
      ..writeByte(9)
      ..write(obj.maleOrFemale)
      ..writeByte(10)
      ..write(obj.rank)
      ..writeByte(11)
      ..write(obj.wallet)
      ..writeByte(12)
      ..write(obj.restoreID)
      ..writeByte(13)
      ..write(obj.deactivated);
  }

  @override
  int get hashCode => typeId.hashCode;
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
