class BusinessType {
  String? id;
  String? name;
  int? count;
  int? productCount;
  String? image;

  BusinessType({
    this.id,
    this.name,
    this.count,
    this.productCount,
    this.image,
  });

  factory BusinessType.fromJson(Map<String, dynamic> json) => BusinessType(
      id: json["_id"] ?? '',
      name: json["name"] ?? '_',
      count: json["stores_count"] ?? 0,
      productCount: json["products_count"] ?? 0,
      image: json['image']);

  Map<String, dynamic> toJson() =>
      {"_id": id == null ? null : id, "name": name};
}
