class CategoryModel {
  String image;
  String name;
  String subtitle;
  String keywordHelper;
  String id;
  bool isProductAvailable;

  CategoryModel(
      {required this.image,
      required this.name,
      required this.subtitle,
      required this.id,
      required this.keywordHelper,
      required this.isProductAvailable});

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        name: json["name"] ?? '',
        keywordHelper: json["keyword_helper"] ?? '',
        image: json["image"] ?? '',
        subtitle: json["subtitle"] ?? '',
        id: json["_id"] ?? '',
        isProductAvailable: json["isProductAvailable"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "keyword_helper": keywordHelper,
        "image": image,
        "subtitle": subtitle,
        "isProductAvailable": isProductAvailable,
        "_id": id,
      };
}
