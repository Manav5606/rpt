import 'package:customer_app/config/gqlConfig.dart';
import 'package:customer_app/controllers/userViewModel.dart';
import 'package:customer_app/data/repositories/new_main_api.dart';
import 'package:customer_app/widgets/snack.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class MyFavRepo {
  static getMyFav() async {
    final myFavQuery = r'''
query($lat:Float,$lng:Float){
  getOrderOnlinePageMyFavoriteStoresData(lat: $lat lng: $lng){
    error
    msg
     data{
    _id  
      name
      online
      store_type
      calculated_distance
      logo
      flag
      distance
      default_welcome_offer
      promotion_welcome_offer_status
      promotion_welcome_offer
     
      default_cashback
      promotion_cashback_status
      promotion_cashback
     
      businesstype{
        _id
      }
      address{
        address
        location{
          lat
          lng
        }
      }
    }
  }
}
  ''';
    try {
      GraphQLClient client = GqlConfig.getClient(UserViewModel.token.value);
      QueryResult result = await client.mutate(
        MutationOptions(
          document: gql(myFavQuery),
          variables: {
            "lat": UserViewModel.currentLocation.value.latitude,
            "lng": UserViewModel.currentLocation.value.longitude
            // "lat": 22.8259892,
            // "lng": 89.5510924
          },
        ),
      );
      bool loginError =
          result.data!['getOrderOnlinePageMyFavoriteStoresData']['error'];

      if (loginError) {
        Snack.top('Error',
            result.data!['getOrderOnlinePageMyFavoriteStoresData']['msg']);
      } else {
        return List<StoreModel>.from(result
            .data!['getOrderOnlinePageMyFavoriteStoresData']['data']
            .map((type) => StoreModel.fromJson(type)));
      }
      return loginError;
    } catch (e) {
      print(e.toString());
      return true;
    }
  }
}
