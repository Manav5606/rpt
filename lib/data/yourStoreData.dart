import 'package:customer_app/constants/string_constants.dart';
import 'package:customer_app/data/yourStoreModel.dart';

List<YourStoresModel> yourStores = [
  YourStoresModel(
      name: 'Sprouts farmer Market',
      image:
          'https://image.freepik.com/free-vector/shop-with-sign-we-are-open_23-2148547718.jpg',
      distance: 20,
      category1: 'Organic ',
      category2: 'Grocery ',
      category3: 'Butcher Shop ',
      pickup: StringContants.pickUp,
      delivery: StringContants.delivery),
  YourStoresModel(
      name: 'Safeway',
      image:
          'https://image.freepik.com/free-vector/facade-bakery-shop_23-2147542589.jpg',
      distance: 10,
      category1: 'Grocery ',
      category2: 'Bakery ',
      category3: 'Deli ',
      pickup: '',
      delivery: StringContants.delivery),
  YourStoresModel(
      name: 'Costco',
      image:
          'https://image.freepik.com/free-vector/food-shop-logo-design-template_145155-1248.jpg',
      distance: 0.5,
      category1: 'Groceries ',
      category2: '',
      category3: '',
      pickup: '',
      delivery: StringContants.delivery),
];
