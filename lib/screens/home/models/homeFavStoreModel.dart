import 'package:customer_app/data/models/category_model.dart';

class GetHomePageFavoriteShops {
  bool? error;
  String? msg;
  List<HomeFavModel>? data;
  List<CategoryModel>? keywords;

  GetHomePageFavoriteShops({this.error, this.msg, this.data, this.keywords});

  GetHomePageFavoriteShops.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <HomeFavModel>[];
      json['data'].forEach((v) {
        data!.add(new HomeFavModel.fromJson(v));
      });
    }
    if (json['keywords'] != null) {
      keywords = <CategoryModel>[];
      json['keywords'].forEach((v) {
        keywords!.add(new CategoryModel.fromJson(v));
      });
    }
  }
}

class HomeFavModel {
  HomeFavModel(
      {this.id,
      this.name,
      this.logo,
      this.defaultCashback,
      this.businesstype,
      this.calculateDistance,
      this.storeType,
      this.premium,
      this.bill_discount_offer_amount,
      this.bill_discount_offer_status,
      this.bill_discount_offer_target});

  String? id;
  String? name;
  String? logo;
  String? businesstype;
  String? storeType;
  int? defaultCashback;
  num? calculateDistance;
  bool? premium;
  bool? bill_discount_offer_status;
  int? bill_discount_offer_target;
  int? bill_discount_offer_amount;

  factory HomeFavModel.fromJson(Map<String, dynamic> json) => HomeFavModel(
      id: json["_id"],
      name: json["name"],
      businesstype: json["businesstype"],
      storeType: json["store_type"],
      logo: json["logo"],
      defaultCashback: json["default_cashback"],
      calculateDistance: json["calculated_distance"],
      premium: json["premium"],
      bill_discount_offer_status: json["bill_discount_offer_status"],
      bill_discount_offer_target: json["bill_discount_offer_target"],
      bill_discount_offer_amount: json["bill_discount_offer_amount"]);

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "logo": logo,
        "businesstype": businesstype,
        "store_type": storeType,
        "default_cashback": defaultCashback,
        "calculated_distance": calculateDistance,
        "premium": premium,
        "bill_discount_offer_amount": bill_discount_offer_amount,
        "bill_discount_offer_target": bill_discount_offer_target,
        "bill_discount_offer_status": bill_discount_offer_status
      };
}
