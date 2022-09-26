import 'package:customer_app/screens/addcart/models/review_cart_model.dart';

class CartLocationModel {
  String? msg;
  List<Addresses>? addresses;
  Addresses? storeAddress;

  CartLocationModel({this.msg, this.addresses, this.storeAddress});

  CartLocationModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['addresses'] != null) {
      addresses = <Addresses>[];
      json['addresses'].forEach((v) {
        addresses!.add(new Addresses.fromJson(v));
      });
    }
    storeAddress = json['storeAddress'] != null
        ? new Addresses.fromJson(json['storeAddress'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    if (this.addresses != null) {
      data['addresses'] = this.addresses!.map((v) => v.toJson()).toList();
    }
    if (this.storeAddress != null) {
      data['storeAddress'] = this.storeAddress!.toJson();
    }
    return data;
  }
}