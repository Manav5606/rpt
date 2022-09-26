import 'package:hive/hive.dart';

part 'recentProductsData.g.dart';

@HiveType(typeId: 10)
class RecentProductsDataModel {
  @HiveField(0)
  List<RecentProductsData>? recentProductsData;

  RecentProductsDataModel({
    this.recentProductsData = const [],
  });

  RecentProductsDataModel.fromJson(Map<String, dynamic> json) {
    recentProductsData = json['recentProductsData'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['recentProductsData'] = this.recentProductsData;

    return data;
  }
}

@HiveType(typeId: 11)
class RecentProductsData {
  @HiveField(0)
  String? logo;
  @HiveField(1)
  String? name;
  @HiveField(2)
  bool? isStore;
  @HiveField(3)
  String? sId;

  RecentProductsData({
    this.logo,
    this.name,
    this.isStore,
    this.sId,
  });

  RecentProductsData.fromJson(Map<String, dynamic> json) {
    logo = json['logo'];
    name = json['name'];
    isStore = json['isStore'];
    sId = json['sId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.logo;
    data['name'] = this.name;
    data['isStore'] = this.isStore;
    data['sId'] = this.sId;
    return data;
  }
}
