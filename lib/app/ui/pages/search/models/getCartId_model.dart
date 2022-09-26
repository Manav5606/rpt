import 'package:customer_app/screens/home/models/GetAllCartsModel.dart';

class GetCartIDModel {
  String? sId;
  int? totalItemsCount;
  List<GetCartIdProducts>? products;
  List<GetCartIdProducts>? inventories;
  List<RawItems>? rawitems;
  GetCartIDModel(
      {this.sId, this.totalItemsCount, this.products, this.inventories ,this.rawitems});

  GetCartIDModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    totalItemsCount = json['total_items_count'];
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
    }  if (json['rawitems'] != null) {
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

class GetCartIdProducts {
  String? sId;
  String? name;
  int? cashback;
  int? quantity;
  int? gstAmount;

  GetCartIdProducts(
      {this.sId, this.name, this.cashback, this.quantity, this.gstAmount});

  GetCartIdProducts.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    cashback = json['cashback'];
    quantity = json['quantity'];
    gstAmount = json['gst_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['cashback'] = this.cashback;
    data['quantity'] = this.quantity;
    data['gst_amount'] = this.gstAmount;
    return data;
  }
}
