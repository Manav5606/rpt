import 'package:customer_app/constants/string_constants.dart';
import 'package:customer_app/data/models/all_offers_model.dart';
import 'package:customer_app/data/models/offers_near_me_model.dart';

List<OffersNearMeModel> offersNearMe = [
  OffersNearMeModel(
      offer: "1%",
      shopDetails: AllOffersModel(
          distance: 0.9,
          name: "Publix",
          image: "assets/images/image4.png",
          pickup: StringContants.pickUp,
          delivery: StringContants.delivery,
          storePrices: "In-Stores proces"),
      products: [
        Products(
            image: "assets/images/product1.png",
            cahsback: "3.00",
            description: "Britannia Toastea Premium Bake Rusk",
            isAdded: true),
        Products(
            image: "assets/images/product2.png",
            cahsback: "4.00",
            description: "Haldiram's Bhujia (1 kg) Namkeen",
            isAdded: false),
      ]),
  OffersNearMeModel(
      offer: "3%",
      shopDetails: AllOffersModel(
          distance: 18.0,
          name: "Sprout Farmer Market",
          image: "assets/images/image2.png",
          pickup: StringContants.pickUp,
          delivery: StringContants.delivery,
          storePrices: "In-Stores proces"),
      products: [
        Products(
            image: "assets/images/product1.png",
            cahsback: "1.00",
            description: "Product 1",
            isAdded: false),
        Products(
            image: "assets/images/product2.png",
            cahsback: "4.00",
            description: "Product 2",
            isAdded: true),
        Products(
            image: "assets/images/product1.png",
            cahsback: "6.10",
            description: "Product 3",
            isAdded: false),
        Products(
            image: "assets/images/product2.png",
            cahsback: "1.00",
            description: "Product 4",
            isAdded: false),
        Products(
            image: "assets/images/product1.png",
            cahsback: "5.00",
            description: "Product 5",
            isAdded: false),
        Products(
            image: "assets/images/product2.png",
            cahsback: "3.00",
            description: "Product 6",
            isAdded: false),
      ]),
  OffersNearMeModel(
      offer: "0.5%",
      shopDetails: AllOffersModel(
          distance: 0.9,
          name: "Costco",
          image: "assets/images/image1.png",
          pickup: StringContants.pickUp,
          delivery: StringContants.delivery,
          storePrices: "In-Stores proces"),
      products: [
        Products(
            image: "assets/images/product1.png",
            cahsback: "1.00",
            description: "Product 1",
            isAdded: true),
        Products(
            image: "assets/images/product2.png",
            cahsback: "4.00",
            description: "Product 2",
            isAdded: false),
        Products(
            image: "assets/images/product1.png",
            cahsback: "6.10",
            description: "Product 3",
            isAdded: false),
        Products(
            image: "assets/images/product2.png",
            cahsback: "1.00",
            description: "Product 4",
            isAdded: false),
        Products(
            image: "assets/images/product1.png",
            cahsback: "5.00",
            description: "Product 5",
            isAdded: false),
        Products(
            image: "assets/images/product2.png",
            cahsback: "3.00",
            description: "Product 6",
            isAdded: false),
      ]),
];
