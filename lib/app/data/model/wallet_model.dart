import 'package:hive/hive.dart';

part 'wallet_model.g.dart';

@HiveType(typeId: 4)
class Wallet {
  Wallet({
    required this.recentlyVisited,
    required this.id,
    required this.welcomeOffer,
    required this.welcomeOfferAmount,
    required this.earnedCashback,
    required this.user,
    required this.password,
    required this.name,
    required this.premium,
    required this.logo,
    required this.defaultCashback,
    required this.defaultWelcomeOffer,
    required this.promotionCashback,
    required this.status,
    required this.promotionWelcomeOfferStatus,
    required this.promotionCashbackStatus,
    this.flag,
    required this.createdAt,
    required this.updatedAt,
    required this.storeType,
    required this.distance,
    required this.online,
    required this.calculatedDistance,
    this.customerWalletAmount,
    required this.lead,
    required this.leadWelcomeOffer,
  });
  @HiveField(1)
  late final bool? recentlyVisited;
  @HiveField(2)
  late final String? id;
  @HiveField(3)
  late final int? welcomeOffer;
  @HiveField(4)
  late final int welcomeOfferAmount;
  @HiveField(5)
  late final num? earnedCashback;
  @HiveField(6)
  late final String? user;
  @HiveField(7)
  late final String? password;
  @HiveField(8)
  late final String? name;
  @HiveField(9)
  late final bool? premium;
  @HiveField(10)
  late final String? logo;
  @HiveField(11)
  late final int? defaultCashback;
  @HiveField(12)
  late final int? defaultWelcomeOffer;
  @HiveField(13)
  late final int? promotionCashback;
  @HiveField(14)
  late final String? status;
  @HiveField(15)
  late final String? promotionWelcomeOfferStatus;
  @HiveField(16)
  late final String? promotionCashbackStatus;
  @HiveField(17)
  late final Null flag;
  @HiveField(18)
  late final String? createdAt;
  @HiveField(19)
  late final String? updatedAt;
  @HiveField(20)
  late final String? storeType;
  @HiveField(21)
  late final int? distance;
  @HiveField(22)
  late final bool? online;
  @HiveField(23)
  late final double? calculatedDistance;
  @HiveField(24)
  late final Null customerWalletAmount;
  @HiveField(25)
  late final bool? lead;
  @HiveField(26)
  late final dynamic leadWelcomeOffer;

  Wallet.fromJson(Map<String, dynamic> json) {
    recentlyVisited = json['recently_visited'];
    id = json['id'];
    welcomeOffer = json['welcome_offer'] ?? 0;
    welcomeOfferAmount = json['welcome_offer_amount'] ?? 0;
    earnedCashback = json['earned_cashback'] ?? 0;
    user = json['user'] ?? "";
    password = json['password'] ?? "";
    name = json['name'] ?? "";
    premium = json['premium'];
    logo = json['logo'] ?? "";
    defaultCashback = json['default_cashback'] ?? 0;
    defaultWelcomeOffer = json['default_welcome_offer'] ?? 0;
    promotionCashback = json['promotion_cashback'] ?? 0;
    status = json['status'] ?? "";
    promotionWelcomeOfferStatus = json['promotion_welcome_offer_status'] ?? "";
    promotionCashbackStatus = json['promotion_cashback_status'] ?? "";
    flag = null;
    createdAt = json['createdAt'] ?? "";
    updatedAt = json['updatedAt'] ?? "";
    storeType = json['store_type'] ?? "";
    distance = json['distance'] ?? 0;
    online = json['online'];
    calculatedDistance = json['calculated_distance'] ?? 0.0;
    customerWalletAmount = null;
    lead = json['lead'];
    leadWelcomeOffer = json['lead_welcome_offer'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['recently_visited'] = recentlyVisited;
    _data['id'] = id;
    _data['welcome_offer'] = welcomeOffer;
    _data['welcome_offer_amount'] = welcomeOfferAmount;
    _data['earned_cashback'] = earnedCashback;
    _data['user'] = user;
    _data['password'] = password;
    _data['name'] = name;
    _data['premium'] = premium;
    _data['logo'] = logo;
    _data['default_cashback'] = defaultCashback;
    _data['default_welcome_offer'] = defaultWelcomeOffer;
    _data['promotion_cashback'] = promotionCashback;
    _data['status'] = status;
    _data['promotion_welcome_offer_status'] = promotionWelcomeOfferStatus;
    _data['promotion_cashback_status'] = promotionCashbackStatus;
    _data['flag'] = flag;
    _data['createdAt'] = createdAt;
    _data['updatedAt'] = updatedAt;
    _data['store_type'] = storeType;
    _data['distance'] = distance;
    _data['online'] = online;
    _data['calculated_distance'] = calculatedDistance;
    _data['customer_wallet_amount'] = customerWalletAmount;
    _data['lead'] = lead == null ? false : lead;
    _data['lead_welcome_offer'] = leadWelcomeOffer;
    return _data;
  }
}
