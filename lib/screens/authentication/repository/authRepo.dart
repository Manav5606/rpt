import 'package:customer_app/app/data/model/user_model.dart';
import 'package:customer_app/config/gqlConfig.dart';
import 'package:customer_app/controllers/userViewModel.dart';
import 'package:customer_app/widgets/snack.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class AuthRepo {
  static requestLogin(String mobile) async {
    print(mobile);
    final mutationAuth = r'''
  mutation($mobile: String){
    customerLoginOrSignUp(mobile: $mobile){
      error
      msg
      token
      data{
        _id
        first_name
        last_name
        mobile
        email
        type
        status
        addresses{
          _id
          title
          address
          house
          apartment
          location{
            lat
            lng
          }
          status
        }
        balance
        logo
        date_of_birth
        male_or_female
        rank
      }
    }
  }
  ''';
    try {
      GraphQLClient client = GqlConfig.getClient();
      QueryResult result = await client.mutate(MutationOptions(document: gql(mutationAuth), variables: {'mobile': '88' + mobile}));

      bool loginError = result.data!['customerLoginOrSignUp']['error'];

      if (loginError) {
        Snack.top('Error', result.data!['customerLoginOrSignUp']['msg']);
      } else {
        UserViewModel.setToken(result.data!['customerLoginOrSignUp']['token']);
        UserViewModel.setStreamToken(result.data!['customerLoginOrSignUp']['streamChatToken']);
        UserViewModel.setSignupFlag(result.data!['customerLoginOrSignUp']['signup']);
        UserViewModel.setBonus(result.data!['customerLoginOrSignUp']['bonus']);
        UserViewModel.setUser(UserModel.fromJson(result.data!['customerLoginOrSignUp']['data']));
        UserViewModel.changeUserStatus(UserStatus.LOGGED_IN);
        // await NewApi.addFirebaseToken(FCMHandler.fcmToken);

        //todo: handle chat seperately
        // try {
        //   await SConfig.client.connectUser(
        //       User(id: UserViewModel.user.value.id, extraData: {
        //         'name': UserViewModel.user.value.firstName == '' &&
        //                 UserViewModel.user.value.lastName == ''
        //             ? 'John Doe'
        //             : UserViewModel.user.value.firstName +
        //                 ' ' +
        //                 UserViewModel.user.value.lastName,
        //         'image': UserViewModel.user.value.logo == null ||
        //                 UserViewModel.user.value.logo == ''
        //             ? 'https://bellfund.ca/wp-content/uploads/2018/03/demo-user.jpg'
        //             : UserViewModel.user.value.logo,
        //         'userType': 'customer'
        //       }),
        //       SConfig.client.devToken(UserViewModel.user.value.id));
        // } catch (e) {
        //   print(e.toString());
        //   print('stream set user failed');
        //   return true;
        // }
        //
        // /// also need to update info if there is any
        // /// otherwise setUser will only set according to id,
        // /// it wont replace any info
        // try {
        //   await SConfig.client
        //       .updateUser(User(id: UserViewModel.user.value.id, extraData: {
        //     'name': UserViewModel.user.value.firstName == '' &&
        //             UserViewModel.user.value.lastName == ''
        //         ? 'John Doe'
        //         : UserViewModel.user.value.firstName +
        //             ' ' +
        //             UserViewModel.user.value.lastName,
        //     'image': UserViewModel.user.value.logo == null ||
        //             UserViewModel.user.value.logo == ''
        //         ? 'https://bellfund.ca/wp-content/uploads/2018/03/demo-user.jpg'
        //         : UserViewModel.user.value.logo,
        //     'userType': 'customer'
        //   }));
        // } catch (e) {
        //   print(e.toString());
        //   print('stream update user failed');
        //   return true;
        // }
      }
      return loginError;
    } catch (e) {
      return true;
    }
  }
}
