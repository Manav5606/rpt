class GetRedeemCashInStorePageData {
  bool? error;
  String? msg;
  List<RedeemCashInStorePageData>? data;

  GetRedeemCashInStorePageData({this.error, this.msg, this.data});

  GetRedeemCashInStorePageData.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <RedeemCashInStorePageData>[];
      json['data'].forEach((v) {
        data!.add(new RedeemCashInStorePageData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RedeemCashInStorePageData {
  String? name;
  String? sId;
  bool? deactivated;
  Store? store;
  int? earnedCashback;
  int? welcomeOffer;
  int? welcomeOfferAmount;

  RedeemCashInStorePageData(
      {this.name,
      this.sId,
      this.deactivated,
      this.store,
      this.earnedCashback,
      this.welcomeOffer,
      this.welcomeOfferAmount});

  RedeemCashInStorePageData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    sId = json['_id'];
    deactivated = json['deactivated'];
    store = json['store'] != null ? new Store.fromJson(json['store']) : null;
    earnedCashback = json['earned_cashback'];
    welcomeOffer = json['welcome_offer'];
    welcomeOfferAmount = json['welcome_offer_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['_id'] = this.sId;
    data['deactivated'] = this.deactivated;
    if (this.store != null) {
      data['store'] = this.store!.toJson();
    }
    data['earned_cashback'] = this.earnedCashback;
    data['welcome_offer'] = this.welcomeOffer;
    data['welcome_offer_amount'] = this.welcomeOfferAmount;

    return data;
  }
}

class Store {
  String? storeType;
  Null? premium;
  int? actualCashback;
  int? distance;
  String? logo;
  String? businesstype;

  Store(
      {this.storeType,
      this.premium,
      this.actualCashback,
      this.distance,
      this.logo,
      this.businesstype});

  Store.fromJson(Map<String, dynamic> json) {
    storeType = json['store_type'];
    premium = json['premium'];
    actualCashback = json['actual_cashback'];
    distance = json['distance'];
    logo = json['logo'];
    businesstype = json['businesstype'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['store_type'] = this.storeType;
    data['premium'] = this.premium;
    data['actual_cashback'] = this.actualCashback;
    data['distance'] = this.distance;
    data['logo'] = this.logo;
    data['businesstype'] = this.businesstype;
    return data;
  }
}

class Businesstype {
  String? sId;
  String? image;

  Businesstype({this.sId, this.image});

  Businesstype.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['image'] = this.image;
    return data;
  }
}
