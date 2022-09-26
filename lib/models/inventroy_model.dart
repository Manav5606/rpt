import '../app/ui/pages/search/models/get_near_me_page_data.dart';

class Inventories {
  int? mrp;
  String? name;
  String? sId;
  Stores? store;

  Inventories({this.mrp, this.name, this.sId, this.store});

  Inventories.fromJson(Map<String, dynamic> json) {
    mrp = json['mrp'];
    name = json['name'];
    sId = json['_id'];
    store = json['store'] != null ? new Stores.fromJson(json['store']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mrp'] = this.mrp;
    data['name'] = this.name;
    data['_id'] = this.sId;
    if (this.store != null) {
      data['store'] = this.store!.toJson();
    }
    return data;
  }
}
