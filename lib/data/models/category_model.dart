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

List<CategoryModel> category = [
  CategoryModel(
      id: "61f960000a984e3d1c8f9ecb",
      name: "Fruits and Veg",
      subtitle: "new",
      keywordHelper: "business_type",
      image: "assets/images/Fresh.png",
      isProductAvailable: true),
  CategoryModel(
      id: "61f95fcd0a984e3d1c8f9ec9",
      name: "Grocery",
      subtitle: "new",
      keywordHelper: "business_type",
      image: "assets/images/groceryImage.png",
      isProductAvailable: true),
  CategoryModel(
      id: "624e503dbd7079a799ffc9e1",
      name: "Meat and Eggs",
      subtitle: "new",
      keywordHelper: "business_type",
      image: "assets/images/Nonveg.png",
      isProductAvailable: true),
  CategoryModel(
      id: "",
      name: "30 mins",
      subtitle: "new",
      keywordHelper: "",
      image: "assets/images/Pickup.png",
      isProductAvailable: false),
  CategoryModel(
      id: "",
      name: "Premium",
      subtitle: "",
      keywordHelper: "",
      image: "assets/images/Premium.png",
      isProductAvailable: false),
  CategoryModel(
      id: "",
      name: "30 mins",
      subtitle: "new",
      keywordHelper: "",
      image: "assets/images/Medics.png",
      isProductAvailable: false),
];
