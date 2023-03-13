class GetClaimRewardsModel {
  List<Stores>? stores;

  GetClaimRewardsModel({this.stores});

  GetClaimRewardsModel.fromJson(Map<String, dynamic> json) {
    if (json['stores'] != null) {
      stores = <Stores>[];
      json['stores'].forEach((v) {
        stores!.add(new Stores.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.stores != null) {
      data['stores'] = this.stores!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Stores {
  String? sId;
  String? user;
  String? password;
  String? name;
  bool? premium;
  bool? online;
  String? storeType;
  num? calculatedDistance;
  String? logo;
  String? flag;
  int? distance;
  int? defaultWelcomeOffer;
  int? actualWelcomeOffer;
  String? promotionWelcomeOfferStatus;
  int? promotionWelcomeOffer;
  int? actualCashback;
  // PromotionWelcomeOfferDate? promotionWelcomeOfferDate;
  int? defaultCashback;
  String? promotionCashbackStatus;
  int? promotionCashback;
  // PromotionWelcomeOfferDate? promotionCashbackDate;
  String? businesstype;
  Address? address;

  Stores(
      {this.sId,
      this.user,
      this.password,
      this.name,
      this.premium,
      this.online,
      this.storeType,
      this.actualCashback,
      this.calculatedDistance,
      this.logo,
      this.flag,
      this.distance,
      this.defaultWelcomeOffer,
      this.actualWelcomeOffer,
      this.promotionWelcomeOfferStatus,
      this.promotionWelcomeOffer,
      // this.promotionWelcomeOfferDate,
      this.defaultCashback,
      this.promotionCashbackStatus,
      this.promotionCashback,
      // this.promotionCashbackDate,
      this.businesstype,
      this.address});

  Stores.fromJson(Map<String, dynamic> json) {
    actualCashback = json['actual_cashback'];
    sId = json['_id'];
    user = json['user'];
    password = json['password'];
    name = json['name'];
    premium = json['premium'];
    online = json['online'];
    storeType = json['store_type'];
    calculatedDistance = json['calculated_distance'];
    logo = json['logo'];
    flag = json['flag'];
    distance = json['distance'];
    defaultWelcomeOffer = json['default_welcome_offer'];
    actualWelcomeOffer = json['actual_welcome_offer'];
    promotionWelcomeOfferStatus = json['promotion_welcome_offer_status'];
    promotionWelcomeOffer = json['promotion_welcome_offer'];
    // promotionWelcomeOfferDate = json['promotion_welcome_offer_date'] != null
    //     ? new PromotionWelcomeOfferDate.fromJson(
    //         json['promotion_welcome_offer_date'])
    //     : null;
    defaultCashback = json['default_cashback'];
    promotionCashbackStatus = json['promotion_cashback_status'];
    promotionCashback = json['promotion_cashback'];
    businesstype = json['businesstype'];
    // promotionCashbackDate = json['promotion_cashback_date'] != null
    //     ? new PromotionWelcomeOfferDate.fromJson(
    //         json['promotion_cashback_date'])
    //     : null;
    // businesstype = json['businesstype'] != null
    //     ? new Businesstype.fromJson(json['businesstype'])
    //     : null;
    address =
        json['address'] != null ? new Address.fromJson(json['address']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['actual_cashback'] = this.actualCashback;
    data['user'] = this.user;
    data['password'] = this.password;
    data['name'] = this.name;
    data['premium'] = this.premium;
    data['online'] = this.online;
    data['store_type'] = this.storeType;
    data['calculated_distance'] = this.calculatedDistance;
    data['logo'] = this.logo;
    data['flag'] = this.flag;
    data['distance'] = this.distance;
    data['default_welcome_offer'] = this.defaultWelcomeOffer;
    data['actual_welcome_offer'] = this.actualWelcomeOffer;

    data['promotion_welcome_offer_status'] = this.promotionWelcomeOfferStatus;
    data['promotion_welcome_offer'] = this.promotionWelcomeOffer;
    // data['promotion_welcome_offer_date'] = this.promotionWelcomeOfferDate;
    data['default_cashback'] = this.defaultCashback;
    data['promotion_cashback_status'] = this.promotionCashbackStatus;
    data['promotion_cashback'] = this.promotionCashback;
    data['businesstype'] = this.businesstype;
    // data['promotion_cashback_date'] = this.promotionCashbackDate;
    // if (this.businesstype != null) {
    //   data['businesstype'] = this.businesstype!.toJson();
    // }
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    return data;
  }
}

// class PromotionWelcomeOfferDate {
//   DateTime? startDate;
//   DateTime? endDate;

//   PromotionWelcomeOfferDate({this.startDate, this.endDate});

//   factory PromotionWelcomeOfferDate.fromJson(Map<String, dynamic> json) =>
//       PromotionWelcomeOfferDate(
//         startDate: json["start_date"] == null
//             ? null
//             : DateTime.fromMillisecondsSinceEpoch(
//                 int.parse(json["start_date"])),
//         endDate: json["end_date"] == null
//             ? null
//             : DateTime.fromMillisecondsSinceEpoch(int.parse(json["end_date"])),
//       );
// }

class Businesstype {
  String? sId;

  Businesstype({this.sId});

  Businesstype.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    return data;
  }
}

class Address {
  String? address;
  Location? location;

  Address({this.address, this.location});

  Address.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    return data;
  }
}

class Location {
  num? lat;
  num? lng;

  Location({this.lat, this.lng});

  Location.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}
