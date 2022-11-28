class OrderModel {
  bool? error;
  String? msg;
  List<OrderData>? data;

  OrderModel({this.error, this.msg, this.data});

  OrderModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <OrderData>[];
      json['data'].forEach((v) {
        data!.add(new OrderData.fromJson(v));
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

class OrderData {
  String? Id;
  String? status;
  String? receipt;
  String? orderType;
  int? total;
  num? total_cashback;
  int? cashback_percentage;
  num? wallet_amount;
  String? createdAt;
  String? address;
  LocationCoordinates? location;
  DeliverySlot? deliverySlot;
  Rider? rider;
  List<Products>? products;
  List<RawItems>? rawItems;
  List<InventoriesData>? inventories;
  Store? store;

  OrderData(
      {this.Id,
      this.status,
      this.orderType,
      this.total,
      this.total_cashback,
      this.wallet_amount,
      this.cashback_percentage,
      this.createdAt,
      this.address,
      this.location,
      this.deliverySlot,
      this.rider,
      this.products,
      this.inventories,
      this.store,
      this.rawItems,
      this.receipt});

  OrderData.fromJson(Map<String, dynamic> json) {
    Id = json['_id'];
    status = json['status'];
    receipt = json['receipt'];

    orderType = json['order_type'];
    total = json['total'];
    cashback_percentage = json['cashback_percentage'];
    total_cashback = json['total_cashback'];
    wallet_amount = json['wallet_amount'];
    createdAt = json['createdAt'];
    address = json['address'];
    location = json['LocationCoordinates'] != null
        ? new LocationCoordinates.fromJson(json['LocationCoordinates'])
        : null;
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
    if (json['inventories'] != null) {
      inventories = <InventoriesData>[];
      json['inventories'].forEach((v) {
        inventories!.add(new InventoriesData.fromJson(v));
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
    data['receipt'] = this.receipt;
    data['order_type'] = this.orderType;
    data['total'] = this.total;
    data['cashback_percentage'] = this.cashback_percentage;
    data['total_cashback'] = this.total_cashback;
    data['wallet_amount'] = this.wallet_amount;
    data['createdAt'] = this.createdAt;
    data['rider'] = this.rider;
    data['address'] = this.address;
    if (this.deliverySlot != null) {
      data['delivery_slot'] = this.deliverySlot!.toJson();
    }
    if (this.location != null) {
      data['LocationCoordinates'] = this.location!.toJson();
    }
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    if (this.inventories != null) {
      data['inventories'] = this.inventories!.map((v) => v.toJson()).toList();
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
  String? logo;
  bool? modified;
  bool? deleted;
  String? status;
  String? updatelogo;
  String? updatename;
  num? updatemrp;
  num? updateselling_price;
  int? updatequantity;

  RawItems(
      {this.item,
      this.quantity,
      this.sId,
      this.modified,
      this.logo,
      this.deleted,
      this.status,
      this.updatelogo,
      this.updatemrp,
      this.updatename,
      this.updatequantity,
      this.updateselling_price});

  RawItems.fromJson(Map<String, dynamic> json) {
    item = json['item'];
    quantity = json['quantity'];
    sId = json['_id'];
    modified = json['modified'];
    logo = json['logo'];
    deleted = json['deleted'];
    status = json['status'];
    updatelogo = json['updatelogo'];
    updatemrp = json['updatemrp'];
    updatename = json['updatename'];
    updatequantity = json['updatequantity'];
    updateselling_price = json['updateselling_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['item'] = this.item;
    data['quantity'] = this.quantity;
    data['_id'] = this.sId;
    data['modified'] = this.modified;
    data['logo'] = this.logo;
    data['deleted'] = this.deleted;
    data['status'] = this.status;
    data['updatelogo'] = this.updatelogo;
    data['updatemrp'] = this.updatemrp;
    data['updatename'] = this.updatename;
    data['updatequantity'] = this.updatequantity;
    data['updateselling_price'] = this.updateselling_price;

    return data;
  }
}

class Rider {
  String? mobile;
  String? sId;
  String? firstName;
  String? last_name;
  String? bankDocumentPhoto;

  Rider(
      {this.mobile,
      this.sId,
      this.firstName,
      this.last_name,
      this.bankDocumentPhoto});

  Rider.fromJson(Map<String, dynamic> json) {
    mobile = json['mobile'];
    sId = json['_id'];
    firstName = json['first_name'];
    last_name = json['last_name'];
    bankDocumentPhoto = json['bank_document_photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mobile'] = this.mobile;
    data['_id'] = this.sId;
    data['first_name'] = this.firstName;
    data['last_name'] = this.last_name;
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
  String? id;
  String? name;
  num? mrp;
  num? cashback;
  num? gst_amount;
  int? quantity;
  bool? deleted;
  bool? modified;
  int? sellingPrice;
  String? status;
  String? updatelogo;
  String? updatename;
  num? updatemrp;
  num? updateselling_price;
  int? updatequantity;

  Products(
      {this.name,
      this.quantity,
      this.deleted,
      this.modified,
      this.sellingPrice,
      this.id,
      this.cashback,
      this.gst_amount,
      this.mrp,
      this.status,
      this.updatelogo,
      this.updatemrp,
      this.updatename,
      this.updatequantity,
      this.updateselling_price});

  Products.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    quantity = json['quantity'];
    deleted = json['deleted'];
    modified = json['modified'];
    sellingPrice = json['selling_price'];
    id = json['_id'];
    mrp = json['mrp'];
    cashback = json['cashback'];
    status = json['status'];
    updatelogo = json['updatelogo'];
    updatename = json['updatename'];
    updatemrp = json['updatemrp'];
    updateselling_price = json['updateselling_price'];
    updatequantity = json['updatequantity'];
    gst_amount = json['gst_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['quantity'] = this.quantity;
    data['deleted'] = this.deleted;
    data['modified'] = this.modified;
    data['selling_price'] = this.sellingPrice;
    data['_id'] = this.id;
    data['mrp'] = this.mrp;
    data['cashback'] = this.cashback;
    data['status'] = this.status;
    data['updatelogo'] = this.updatelogo;
    data['updatename'] = this.updatename;
    data['updatemrp'] = this.updatemrp;
    data['updateselling_price'] = this.updateselling_price;
    data['updatequantity'] = this.updatequantity;
    data['gst_amount'] = this.gst_amount;
    return data;
  }
}

class InventoriesData {
  String? id;
  String? name;
  num? mrp;
  num? cashback;
  num? gst_amount;
  int? quantity;
  bool? deleted;
  bool? modified;
  int? sellingPrice;
  String? status;
  String? updatelogo;
  String? updatename;
  num? updatemrp;
  num? updateselling_price;
  int? updatequantity;

  InventoriesData(
      {this.name,
      this.quantity,
      this.deleted,
      this.modified,
      this.sellingPrice,
      this.id,
      this.cashback,
      this.gst_amount,
      this.mrp,
      this.status,
      this.updatelogo,
      this.updatemrp,
      this.updatename,
      this.updatequantity,
      this.updateselling_price});

  InventoriesData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    quantity = json['quantity'];
    deleted = json['deleted'];
    modified = json['modified'];
    sellingPrice = json['selling_price'];
    id = json['_id'];
    mrp = json['mrp'];
    cashback = json['cashback'];
    status = json['status'];
    updatelogo = json['updatelogo'];
    updatename = json['updatename'];
    updatemrp = json['updatemrp'];
    updateselling_price = json['updateselling_price'];
    updatequantity = json['updatequantity'];
    gst_amount = json['gst_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['quantity'] = this.quantity;
    data['deleted'] = this.deleted;
    data['modified'] = this.modified;
    data['selling_price'] = this.sellingPrice;
    data['_id'] = this.id;
    data['mrp'] = this.mrp;
    data['cashback'] = this.cashback;
    data['status'] = this.status;
    data['updatelogo'] = this.updatelogo;
    data['updatename'] = this.updatename;
    data['updatemrp'] = this.updatemrp;
    data['updateselling_price'] = this.updateselling_price;
    data['updatequantity'] = this.updatequantity;
    data['gst_amount'] = this.gst_amount;
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

class LocationCoordinates {
  String? type;
  List<double>? coordinates;
  LocationCoordinates({this.type, this.coordinates});
  LocationCoordinates.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = json['coordinates'].cast<double>();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['coordinates'] = this.coordinates;
    return data;
  }
}

enum OrderCardTag {
  activeOrder,
  allOrder,
}
