import 'package:get/get.dart';

class HomePageRemoteConfigData {
  bool? error;
  String? msg;
  List<Data>? data;

  HomePageRemoteConfigData({this.error, this.msg, this.data});

  HomePageRemoteConfigData.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
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

class Data {
  String? sId;
  String? name;
  String? logo;
  num? defaultCashback;
  num? calculatedDistance;
  String? storeType;
  String? businesstype;
  bool? premium;
  List<Products>? products;

  Data(
      {this.sId,
      this.name,
      this.logo,
      this.defaultCashback,
      this.calculatedDistance,
      this.businesstype,
      this.storeType,
      this.premium,
      this.products});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    logo = json['logo'];
    defaultCashback = json['default_cashback'] ?? 0.0;
    calculatedDistance = json['calculated_distance'] ?? 0.0;
    storeType = json['store_type'];
    businesstype = json['businesstype'];
    premium = json['premium'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['logo'] = this.logo;
    data['businesstype'] = this.businesstype;
    data['default_cashback'] = this.defaultCashback;
    data['calculated_distance'] = this.calculatedDistance;
    data['store_type'] = this.storeType;
    data['premium'] = this.premium;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  String? sId;
  String? name;
  String? logo;
  int? cashback;
  RxInt? quntity = 0.obs;
  RxBool? isQunitityAdd = false.obs;

  Products(
      {this.sId,
      this.name,
      this.logo,
      this.cashback,
      this.quntity,
      this.isQunitityAdd});

  Products.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    logo = json['logo'];
    cashback = json['cashback'];
    quntity?.value = json['quantity'] != null ? 0 : 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    // data['logo'] = this.logo;
    data['cashback'] = this.cashback;
    data['quantity'] = this.quntity!.value;

    return data;
  }
}
