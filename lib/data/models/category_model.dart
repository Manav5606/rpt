class CategoryModel {
  String image;
  String name;
  String subtitle;
  String keywordHelper;
  String id;
  bool isProductAvailable;
  String title;

  CategoryModel(
      {required this.image,
      required this.name,
      required this.subtitle,
      required this.id,
      required this.keywordHelper,
      required this.isProductAvailable,
      required this.title});

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        name: json["name"] ?? '',
        keywordHelper: json["keyword_helper"] ?? '',
        image: json["image"] ?? '',
        subtitle: json["subtitle"] ?? '',
        title: json["title"] ?? '',
        id: json["_id"] ?? '',
        isProductAvailable: json["isProductAvailable"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "keyword_helper": keywordHelper,
        "image": image,
        "title": title,
        "subtitle": subtitle,
        "isProductAvailable": isProductAvailable,
        "_id": id,
      };
}

List<CategoryModel> category = [
  CategoryModel(
      id: "61f960000a984e3d1c8f9ecb",
      name: "Fruits and Veg",
      title: "Fruits and Veg stores Near you",
      subtitle: "new",
      keywordHelper: "business_type",
      image: "assets/images/Fresh.png",
      isProductAvailable: true),
  CategoryModel(
      id: "61f95fcd0a984e3d1c8f9ec9",
      name: "Grocery",
      title: "Grocery  stores Near you",
      subtitle: "new",
      keywordHelper: "business_type",
      image: "assets/images/groceryImage.png",
      isProductAvailable: true),
  CategoryModel(
      id: "624e503dbd7079a799ffc9e1",
      name: "Meat and Eggs",
      title: "Meat stores Near you",
      subtitle: "new",
      keywordHelper: "business_type",
      image: "assets/images/Nonveg.png",
      isProductAvailable: true),
  CategoryModel(
      id: "",
      name: "30 mins",
      title: "Delivery within 30 mins",
      subtitle: "new",
      keywordHelper: "",
      image: "assets/images/Pickup.png",
      isProductAvailable: false),
  CategoryModel(
      id: "63a689eff5416c5c5b0ab0a4",
      name: "PetFood",
      title: "",
      subtitle: "",
      keywordHelper: "business_type",
      image: "assets/images/petfood.png",
      isProductAvailable: false),
  CategoryModel(
      id: "63a68a03f5416c5c5b0ab0a5",
      name: "Medics",
      title: "Delivery within 30 mins",
      subtitle: "new",
      keywordHelper: "business_type",
      image: "assets/images/Medics.png",
      isProductAvailable: false),
];
