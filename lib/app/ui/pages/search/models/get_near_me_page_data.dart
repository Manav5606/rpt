import 'package:hive/hive.dart';
import 'package:customer_app/app/ui/pages/search/models/autoCompleteProductsByStoreModel.dart';

part 'get_near_me_page_data.g.dart';

@HiveType(typeId: 5)
class GetNearMePageData {
  @HiveField(0)
  String? msg;
  @HiveField(1)
  NearMePageData? data;

  GetNearMePageData({this.msg, this.data});

  GetNearMePageData.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    data =
        json['data'] != null ? new NearMePageData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

@HiveType(typeId: 6)
class NearMePageData {
  @HiveField(0)
  String? sId;
  @HiveField(1)
  List<Products>? products;
  @HiveField(2)
  List<Store>? stores;
  @HiveField(3)
  List<Products>? inventories;

  NearMePageData({this.sId, this.products, this.stores, this.inventories});

  NearMePageData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'] ?? '';
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
    if (json['stores'] != null) {
      stores = <Store>[];
      json['stores'].forEach((v) {
        stores!.add(new Store.fromJson(v));
      });
    }
    if (json['inventories'] != null) {
      inventories = <Products>[];
      json['inventories'].forEach((v) {
        inventories!.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    if (this.stores != null) {
      data['stores'] = this.stores!.map((v) => v.toJson()).toList();
    }
    if (this.inventories != null) {
      data['inventories'] = this.stores!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

// class Stores {
//   @HiveField(0)
//   String? name;
//   @HiveField(1)
//   String? logo;
//   @HiveField(2)
//   String? sId;
//   @HiveField(3)
//   String? businesstype;

//   Stores({this.name, this.logo, this.businesstype, this.sId});

//   Stores.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'] ?? '';
//     name = json['name'] ?? '';
//     sId = json['_id'] ?? '';
//     logo = json['logo'] ?? '';
//     businesstype = json['businesstype'] ?? '';
//     // businesstype = json['businesstype'] != null
//     //     ? new Catalog.fromJson(json['businesstype'])
//     //     : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_id'] = this.sId;
//     data['name'] = this.name;
//     data['_id'] = this.sId;
//     data['logo'] = this.logo;
//     data['businesstype'] = this.businesstype;
//     // if (this.businesstype != null) {
//     //   data['businesstype'] = this.businesstype!.toJson();
//     // }
//     return data;
//   }
// }
