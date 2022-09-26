import 'package:customer_app/data/models/mixed/productModel.dart';
import 'package:customer_app/data/repositories/new_main_api.dart';

class FavPageDataModel {
  FavPageDataModel({
    this.id,
    this.itemCount,
    this.catalogs,
    this.products,
    this.stores,
  });

  String? id;
  int? itemCount;
  List<CatalogModel>? catalogs;
  List<ProductModel>? products;
  List<StoreModel>? stores;

  factory FavPageDataModel.fromJson(Map<String, dynamic> json) {
    return FavPageDataModel(
      id: json["_id"],
      itemCount: json["item_count"] ?? 0,
      catalogs: List<CatalogModel>.from(
          json["catalogs"].map((x) => CatalogModel.fromJson(x))),
      products: List<ProductModel>.from(
          json["products"].map((x) => ProductModel.fromJson(x))),
      stores: List<StoreModel>.from(
          json["stores"].map((x) => StoreModel.fromJson(x))),
    );
  }
}

class CatalogModel {
  CatalogModel({
    this.id,
    this.name,
    this.img,
  });

  String? id;
  String? name;
  String? img;

  factory CatalogModel.fromJson(Map<String, dynamic> json) => CatalogModel(
        id: json["_id"],
        name: json["name"],
        img: json["img"],
      );
}

// class OfferDateModel {
//   OfferDateModel({
//     this.startDate,
//     this.endDate,
//   });

//   DateTime? startDate;
//   DateTime? endDate;

//   factory OfferDateModel.fromJson(Map<String, dynamic> json) => OfferDateModel(
//         startDate: json["start_date"] == null
//             ? null
//             : DateTime.fromMillisecondsSinceEpoch(
//                 int.parse(json["start_date"])),
//         endDate: json["end_date"] == null
//             ? null
//             : DateTime.fromMillisecondsSinceEpoch(int.parse(json["end_date"])),
//       );
// }
