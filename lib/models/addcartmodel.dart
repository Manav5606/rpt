import 'package:customer_app/app/ui/pages/search/models/getCartId_model.dart';

import '../screens/home/models/GetAllCartsModel.dart';

class AddToCartModel {
  String? sId;
  int? totalItemsCount;
  String? store;
  List<GetCartIdProducts>? products;
  List<GetCartIdProducts>? inventories;
  List<RawItems>? rawitems;

  AddToCartModel({this.sId, this.totalItemsCount, this.store, this.products, this.inventories, this.rawitems});

  AddToCartModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    totalItemsCount = json['total_items_count'];
    store = json['store'];
    if (json['products'] != null) {
      products = <GetCartIdProducts>[];
      json['products'].forEach((v) {
        products!.add(new GetCartIdProducts.fromJson(v));
      });
    }
    if (json['inventories'] != null) {
      inventories = <GetCartIdProducts>[];
      json['inventories'].forEach((v) {
        inventories!.add(new GetCartIdProducts.fromJson(v));
      });
    }
    if (json['rawitems'] != null) {
      rawitems = <RawItems>[];
      json['rawitems'].forEach((v) {
        rawitems!.add(new RawItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['total_items_count'] = this.totalItemsCount;
    data['store'] = this.store;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    if (this.inventories != null) {
      data['inventories'] = this.inventories!.map((v) => v.toJson()).toList();
    }
    if (this.rawitems != null) {
      data['rawitems'] = this.inventories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
