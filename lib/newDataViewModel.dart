import 'package:customer_app/data/models/business_types.dart';
import 'package:customer_app/data/models/mixed/45_model.dart';
import 'package:customer_app/data/models/mixed/productModel.dart';
import 'package:customer_app/screens/home/models/homeFavStoreModel.dart';

class NewDataViewModel {
  static List<BusinessType> businessTypes = [];
  static List<HomeFavModel> homeFavStores = [];
  static List<ProductModel> homeSpecialDataRecent = [];
  static List<ProductModel> homeSpecialDataPharmacy = [];
  static List<ProductModel> homeSpecialDataGrocery = [];
  static List<ProductModel> homeSpecialDataFresh = [];
  static List<ProductModel> homeSpecialDataRestaurant = [];
  static FavPageDataModel grocery = FavPageDataModel();
  static FavPageDataModel fresh = FavPageDataModel();
  static FavPageDataModel restaurant = FavPageDataModel();
  static FavPageDataModel pharmacy = FavPageDataModel();
}
