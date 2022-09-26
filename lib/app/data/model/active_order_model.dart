class ActiveOrderModel {
  bool? error;
  String? msg;
  List<ActiveOrderData>? data;

  ActiveOrderModel({this.error, this.msg, this.data});

  ActiveOrderModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <ActiveOrderData>[];
      json['data'].forEach((v) {
        data!.add(new ActiveOrderData.fromJson(v));
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

class ActiveOrderData {
  String? Id;
  String? status;
  String? orderType;
  int? total;
  num? total_cashback;
  num? wallet_amount;
  String? createdAt;
  String? address;
  DeliverySlot? deliverySlot;
  Rider? rider;
  List<Products>? products;
  List<RawItems>? rawItems;
  Store? store;

  ActiveOrderData({
    this.Id,
    this.status,
    this.orderType,
    this.total,
    this.total_cashback,
    this.wallet_amount,
    this.createdAt,
    this.address,
    this.deliverySlot,
    this.rider,
    this.products,
    this.store,
  });

  ActiveOrderData.fromJson(Map<String, dynamic> json) {
    Id = json['_id'];
    status = json['status'];
    orderType = json['order_type'];
    total = json['total'];
    total_cashback = json['total_cashback'];
    wallet_amount = json['wallet_amount'];
    createdAt = json['createdAt'];
    address = json['address'];
    deliverySlot = json['delivery_slot'] != null
        ? new DeliverySlot.fromJson(json['delivery_slot'])
        : null;
    rider = json['rider'] != null ? new Rider.fromJson(json['rider']) : null;
    if (json['rawitems'] != null) {
      rawItems = <RawItems>[];
      json['rawitems'].forEach((v) {
        rawItems!.add(new RawItems.fromJson(v));
      });
    }
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
    store = json['store'] != null ? new Store.fromJson(json['store']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.Id;
    data['status'] = this.status;
    data['order_type'] = this.orderType;
    data['total'] = this.total;
    data['total_cashback'] = this.total_cashback;
    data['wallet_amount'] = this.wallet_amount;
    data['createdAt'] = this.createdAt;
    data['rider'] = this.rider;
    data['address'] = this.address;
    if (this.deliverySlot != null) {
      data['delivery_slot'] = this.deliverySlot!.toJson();
    }
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    if (this.store != null) {
      data['store'] = this.store!.toJson();
    }
    if (this.rawItems != null) {
      data['rawitems'] = this.rawItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RawItems {
  String? item;
  int? quantity;
  String? sId;
  bool? modified;

  RawItems({this.item, this.quantity, this.sId, this.modified});

  RawItems.fromJson(Map<String, dynamic> json) {
    item = json['item'];
    quantity = json['quantity'];
    sId = json['_id'];
    modified = json['modified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['item'] = this.item;
    data['quantity'] = this.quantity;
    data['_id'] = this.sId;
    data['modified'] = this.modified;
    return data;
  }
}

class Rider {
  String? mobile;
  String? sId;
  String? firstName;
  String? bankDocumentPhoto;

  Rider({this.mobile, this.sId, this.firstName, this.bankDocumentPhoto});

  Rider.fromJson(Map<String, dynamic> json) {
    mobile = json['mobile'];
    sId = json['_id'];
    firstName = json['first_name'];
    bankDocumentPhoto = json['bank_document_photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mobile'] = this.mobile;
    data['_id'] = this.sId;
    data['first_name'] = this.firstName;
    data['bank_document_photo'] = this.bankDocumentPhoto;
    return data;
  }
}

class DeliverySlot {
  StartTime? startTime;
  StartTime? endTime;
  int? day;

  DeliverySlot({this.startTime, this.endTime});

  DeliverySlot.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    startTime = json['start_time'] != null
        ? new StartTime.fromJson(json['start_time'])
        : null;
    endTime = json['end_time'] != null
        ? new StartTime.fromJson(json['end_time'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['day'] = this.day;
    if (this.startTime != null) {
      data['start_time'] = this.startTime!.toJson();
    }
    if (this.endTime != null) {
      data['end_time'] = this.endTime!.toJson();
    }
    return data;
  }
}

class StartTime {
  int? hour;
  int? minute;

  StartTime({this.hour, this.minute});

  StartTime.fromJson(Map<String, dynamic> json) {
    hour = json['hour'];
    minute = json['minute'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hour'] = this.hour;
    data['minute'] = this.minute;
    return data;
  }
}

class Products {
  String? name;
  int? quantity;
  bool? deleted;
  bool? modified;
  int? sellingPrice;

  Products(
      {this.name,
      this.quantity,
      this.deleted,
      this.modified,
      this.sellingPrice});

  Products.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    quantity = json['quantity'];
    deleted = json['deleted'];
    modified = json['modified'];
    sellingPrice = json['selling_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['quantity'] = this.quantity;
    data['deleted'] = this.deleted;
    data['modified'] = this.modified;
    data['selling_price'] = this.sellingPrice;
    return data;
  }
}

class Store {
  String? sId;
  String? mobile;
  String? name;
  Address? address;
  String? logo;

  Store({this.sId, this.mobile, this.name, this.address, this.logo});

  Store.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    mobile = json['mobile'];
    name = json['name'];
    logo = json['logo'];
    address =
        json['address'] != null ? new Address.fromJson(json['address']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['mobile'] = this.mobile;
    data['name'] = this.name;
    data['logo'] = this.logo;

    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    return data;
  }
}

class Address {
  String? address;

  Address({this.address});

  Address.fromJson(Map<String, dynamic> json) {
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    return data;
  }
}
