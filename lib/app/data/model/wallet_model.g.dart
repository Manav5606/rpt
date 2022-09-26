// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WalletAdapter extends TypeAdapter<Wallet> {
  @override
  final int typeId = 4;

  @override
  Wallet read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Wallet(
      recentlyVisited: fields[1] as bool,
      id: fields[2] as String,
      welcomeOffer: fields[3] as int,
      welcomeOfferAmount: fields[4] as int,
      earnedCashback: fields[5] as int,
      user: fields[6] as String,
      password: fields[7] as String,
      name: fields[8] as String,
      premium: fields[9] as bool,
      logo: fields[10] as String,
      defaultCashback: fields[11] as int,
      defaultWelcomeOffer: fields[12] as int,
      promotionCashback: fields[13] as int,
      status: fields[14] as String,
      promotionWelcomeOfferStatus: fields[15] as String,
      promotionCashbackStatus: fields[16] as String,
      flag: fields[17] as Null,
      createdAt: fields[18] as String,
      updatedAt: fields[19] as String,
      storeType: fields[20] as String,
      distance: fields[21] as int,
      online: fields[22] as bool,
      calculatedDistance: fields[23] as double,
      customerWalletAmount: fields[24] as Null,
      lead: fields[25] as bool,
      leadWelcomeOffer: fields[26] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Wallet obj) {
    writer
      ..writeByte(26)
      ..writeByte(1)
      ..write(obj.recentlyVisited)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.welcomeOffer)
      ..writeByte(4)
      ..write(obj.welcomeOfferAmount)
      ..writeByte(5)
      ..write(obj.earnedCashback)
      ..writeByte(6)
      ..write(obj.user)
      ..writeByte(7)
      ..write(obj.password)
      ..writeByte(8)
      ..write(obj.name)
      ..writeByte(9)
      ..write(obj.premium)
      ..writeByte(10)
      ..write(obj.logo)
      ..writeByte(11)
      ..write(obj.defaultCashback)
      ..writeByte(12)
      ..write(obj.defaultWelcomeOffer)
      ..writeByte(13)
      ..write(obj.promotionCashback)
      ..writeByte(14)
      ..write(obj.status)
      ..writeByte(15)
      ..write(obj.promotionWelcomeOfferStatus)
      ..writeByte(16)
      ..write(obj.promotionCashbackStatus)
      ..writeByte(17)
      ..write(obj.flag)
      ..writeByte(18)
      ..write(obj.createdAt)
      ..writeByte(19)
      ..write(obj.updatedAt)
      ..writeByte(20)
      ..write(obj.storeType)
      ..writeByte(21)
      ..write(obj.distance)
      ..writeByte(22)
      ..write(obj.online)
      ..writeByte(23)
      ..write(obj.calculatedDistance)
      ..writeByte(24)
      ..write(obj.customerWalletAmount)
      ..writeByte(25)
      ..write(obj.lead)
      ..writeByte(26)
      ..write(obj.leadWelcomeOffer);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WalletAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
