import 'package:customer_app/data/models/business_types.dart';
import 'package:get/get.dart';

class AutoCompleteProductsByStoreModel {
  String? msg;
  bool? error;
  AutoCompleteProductsByData? data;

  AutoCompleteProductsByStoreModel({this.msg, this.error, this.data});

  AutoCompleteProductsByStoreModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    error = json['error'];
    data = json['data'] != null
        ? new AutoCompleteProductsByData.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    data['error'] = this.error;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class AutoCompleteProductsByData {
  List<Products>? products;
  List<Products>? inventories;

  AutoCompleteProductsByData({this.products, this.inventories});

  AutoCompleteProductsByData.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
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
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    if (this.inventories != null) {
      data['inventories'] = this.inventories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  int? mrp;
  String? name;
  String? sId;
  int? cashback;
  String? img;
  String? logo;
  Store? store;
  RxInt? quntity = 0.obs;
  RxBool? isQunitityAdd = false.obs;
  Products(
      {this.mrp,
      this.name,
      this.sId,
      this.img,
      this.cashback,
      this.logo,
      this.store,
      this.quntity,
      this.isQunitityAdd});

  Products.fromJson(Map<String, dynamic> json) {
    mrp = json['mrp'];
    name = json['name'];
    sId = json['_id'];
    img = json['img'];
    cashback = json['cashback'];
    logo = json['logo'];
    store = json['store'] != null ? new Store.fromJson(json['store']) : null;
    quntity?.value = json['quantity'] != null ? 0 : 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['mrp'] = this.mrp;
    data['name'] = this.name;
    data['_id'] = this.sId;
    // data['cashback'] = this.cashback;
    data['quantity'] = this.quntity!.value;
    // data['logo'] = this.logo;
    // if (this.store != null) {
    //   data['store'] = this.store!.toJson();
    // }
    return data;
  }
}

class Store {
  String? sId;
  String? name;
  String? logo;
  dynamic defaultCashback;
  dynamic calculatedDistance;
  String? storeType;
  String? premium;

  Store(
      {this.sId,
      this.name,
      this.logo,
      this.defaultCashback,
      this.calculatedDistance,
      this.storeType,
      this.premium});

  Store.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    logo = json['logo'];
    defaultCashback = json['default_cashback'];
    calculatedDistance = json['calculated_distance'];
    storeType = json['store_type'];
    premium = json['premium'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['logo'] = this.logo;
    data['default_cashback'] = this.defaultCashback;
    data['calculated_distance'] = this.calculatedDistance;
    data['store_type'] = this.storeType;
    data['premium'] = this.premium;
    return data;
  }
}
