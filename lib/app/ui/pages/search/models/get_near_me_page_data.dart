import 'package:customer_app/models/inventroy_model.dart';
import 'package:hive/hive.dart';

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
    data = json['data'] != null ? new NearMePageData.fromJson(json['data']) : null;
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
  List<Stores>? stores;
  @HiveField(3)
  List<Inventories>? inventories;

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
      stores = <Stores>[];
      json['stores'].forEach((v) {
        stores!.add(new Stores.fromJson(v));
      });
    }
    if (json['inventories'] != null) {
      inventories = <Inventories>[];
      json['inventories'].forEach((v) {
        inventories!.add(new Inventories.fromJson(v));
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

@HiveType(typeId: 7)
class Products {
  @HiveField(0)
  String? sId;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? logo;
  @HiveField(3)
  Catalog? catalog;
  @HiveField(4)
  Stores? store;

  Products({this.sId, this.name, this.logo, this.catalog, this.store});

  Products.fromJson(Map<String, dynamic> json) {
    sId = json['_id'] ?? '';
    name = json['name'] ?? '';
    logo = json['logo'] ?? '';
    store = json['store'] != null ? new Stores.fromJson(json['store']) : null;
    catalog = json['catalog'] != null ? new Catalog.fromJson(json['catalog']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['logo'] = this.logo;
    data['store'] = this.store;
    if (this.catalog != null) {
      data['catalog'] = this.catalog!.toJson();
    }
    if (this.store != null) {
      data['store'] = this.store!.toJson();
    }
    return data;
  }
}

@HiveType(typeId: 8)
class Catalog {
  @HiveField(0)
  String? name;
  @HiveField(1)
  String? sId;

  Catalog({this.name, this.sId});

  Catalog.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? '';
    sId = json['_id'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['_id'] = this.sId;
    return data;
  }
}

@HiveType(typeId: 9)
class Stores {
  @HiveField(0)
  String? name;
  @HiveField(1)
  String? logo;
  @HiveField(2)
  String? sId;
  @HiveField(3)
  String? businesstype;

  Stores({this.name, this.logo, this.businesstype, this.sId});

  Stores.fromJson(Map<String, dynamic> json) {
    sId = json['_id'] ?? '';
    name = json['name'] ?? '';
    sId = json['_id'] ?? '';
    logo = json['logo'] ?? '';
    businesstype = json['businesstype'] ?? '';
    // businesstype = json['businesstype'] != null
    //     ? new Catalog.fromJson(json['businesstype'])
    //     : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['_id'] = this.sId;
    data['logo'] = this.logo;
    data['businesstype'] = this.businesstype;
    // if (this.businesstype != null) {
    //   data['businesstype'] = this.businesstype!.toJson();
    // }
    return data;
  }
}
