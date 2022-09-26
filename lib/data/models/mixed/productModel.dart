import 'package:customer_app/data/models/business_types.dart';
import 'package:customer_app/data/repositories/new_main_api.dart';

class GetOrderOnlinePageProductsData {
  GetOrderOnlinePageProductsData({
    this.error,
    this.msg,
    this.data,
  });

  bool? error;
  String? msg;
  ProductData? data;

  factory GetOrderOnlinePageProductsData.fromJson(Map<String, dynamic> json) =>
      GetOrderOnlinePageProductsData(
        error: json["error"],
        msg: json["msg"],
        data: ProductData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "msg": msg,
        "data": data!.toJson(),
      };
}

class ProductData {
  ProductData({
    this.products,
    this.walletAmount,
  });

  List<ProductModel>? products;
  int? walletAmount;

  factory ProductData.fromJson(Map<String, dynamic> json) => ProductData(
        products: List<ProductModel>.from(
            json["products"].map((x) => ProductModel.fromJson(x))),
        walletAmount: json["wallet_amount"],
      );

  Map<String, dynamic> toJson() => {
        "products": List<dynamic>.from(products!.map((x) => x.toJson())),
        "wallet_amount": walletAmount,
      };
}

class RawProduct {
  String? name;
  int? quantity;
  String? productId;

  RawProduct({this.name, this.quantity = 1, this.productId});

  Map<String, dynamic> toJson() => {"item": name, 'quantity': quantity ?? 1};
}

class ProductModel {
  ProductModel(
      {this.id,
      this.name,
      this.logo,
      this.store,
      this.catalog,
      this.mrp,
      this.sellingPrice,
      this.cashback,
      this.cashbackPercentage,
      this.details,
      this.status,
      this.quantity = 1,
      this.createdAt,
      this.updatedAt,
      // this.expireAt,
      this.businessType,
      this.gstAmount});

  String? id;
  String? name;
  String? logo;
  StoreModel? store;
  Catalog? catalog;
  double? mrp;
  double? sellingPrice;
  double? cashback;
  int? cashbackPercentage;
  String? details;
  String? status;
  int? quantity;
  int? gstAmount;
  BusinessType? businessType;
  DateTime? createdAt;
  DateTime? updatedAt;
  // DateTime? expireAt;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["_id"],
        name: json["name"] ?? '',
        logo: json["logo"],
        gstAmount: json["gst_amount"] ?? 0,
        store:
            json['store'] != null ? StoreModel.fromJson(json['store']) : null,
        catalog:
            json["catalog"] == null ? null : Catalog.fromJson(json["catalog"]),
        businessType: json["businesstype"] == null
            ? null
            : BusinessType.fromJson(json["businesstype"]),
        mrp: json["mrp"]?.toDouble(),
        sellingPrice: json["selling_price"]?.toDouble(),
        cashback: json["cashback"]?.toDouble(),
        cashbackPercentage: json["cashback_percentage"],
        details: json["details"],
        status: json["status"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.fromMillisecondsSinceEpoch(int.parse(json["createdAt"])),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.fromMillisecondsSinceEpoch(int.parse(json["updatedAt"])),
        // expireAt: json["expiry_date"] == null
        //     ? null
        //     : DateTime.fromMillisecondsSinceEpoch(
        //         int.parse(json["expiry_date"])),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "mrp": mrp?.toInt(),
        "selling_price": sellingPrice?.toInt(),
        "cashback": cashback?.toInt(),
        'quantity': quantity ?? 1,
        'gst_amount': gstAmount ?? 0,
      };
}

class Catalog {
  Catalog({
    this.name,
    this.id,
    this.img,
  });

  String? name;
  String? id;
  String? img;

  factory Catalog.fromJson(Map<String, dynamic> json) => Catalog(
        name: json["name"] ?? '',
        id: json["_id"],
        img: json["img"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "_id": id,
        "img": img,
      };
}
