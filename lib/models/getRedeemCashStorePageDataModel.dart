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
  String? storeType;
  num? earnedCashback;
  String? updatedAt;
  int? distance;
  String? logo;
  String? businesstype;

  RedeemCashInStorePageData(
      {this.name,
        this.sId,
        this.storeType,
        this.earnedCashback,
        this.updatedAt,
        this.distance,
        this.logo,
        this.businesstype});

  RedeemCashInStorePageData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    sId = json['_id'];
    storeType = json['store_type'];
    earnedCashback = json['earned_cashback'];
    updatedAt = json['updatedAt'];
    distance = json['distance'];
    logo = json['logo'];
    businesstype = json['businesstype'];
    // businesstype = json['businesstype'] != null
    //     ? new Businesstype.fromJson(json['businesstype'])
    //     : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['_id'] = this.sId;
    data['store_type'] = this.storeType;
    data['earned_cashback'] = this.earnedCashback;
    data['updatedAt'] = this.updatedAt;
    data['distance'] = this.distance;
    data['logo'] = this.logo;
    data['businesstype'] = this.businesstype;
    // if (this.businesstype != null) {
    //   data['businesstype'] = this.businesstype!.toJson();
    // }
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
