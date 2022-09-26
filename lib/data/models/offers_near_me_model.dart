import 'all_offers_model.dart';

class OffersNearMeModel {
  AllOffersModel shopDetails;
  List<Products> products;
  String offer;

  OffersNearMeModel({
    required this.products,
    required this.shopDetails,
    required this.offer,
  });
}

class Products {
  String image;
  String cahsback;
  String description;
  bool isAdded;

  Products({
    required this.image,
    required this.cahsback,
    required this.description,
    required this.isAdded,
  });
}
