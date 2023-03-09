import 'dart:developer';
import 'package:customer_app/app/ui/pages/signIn/phone_authentication_screen.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:customer_app/controllers/userViewModel.dart';
import 'package:customer_app/routes/app_list.dart';
import 'package:get/route_manager.dart';
import 'package:uni_links/uni_links.dart';

class DynamicLinkService {
  // Future handleDynamicLinks() async {
  //   final PendingDynamicLinkData? data = await FirebaseDynamicLinks.instance.getInitialLink();
  //
  //   _handleDeepLink(data);
  //
  //   FirebaseDynamicLinks.instance.onLink(onSuccess: (PendingDynamicLinkData? dynamicLinkData) async {
  //     _handleDeepLink(dynamicLinkData);
  //   }, onError: (OnLinkErrorException e) async {
  //     print('Dynamic Link Failed: ${e.message}');
  //   });
  // }

  // Future<String> createDynamicLink(String _referCode) async {
  //   final DynamicLinkParameters parameters = DynamicLinkParameters(
  //       uriPrefix: "https://recipto.in",
  //       link:
  //           Uri.parse("https://recipto.page.link/refer?refercode=$_referCode"),
  //       androidParameters:
  //           AndroidParameters(packageName: "com.example.customer_app"));
  //
  //   final link = await parameters.buildShortLink();
  //   return (link.shortUrl.origin + link.shortUrl.path);
  // }

  Future<String> createDynamicLink(String _referCode) async {
    log('dynamicUrl : 0.1');
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://rider.page.link',
      link: Uri.parse('https://recipto.in?refercode=$_referCode'),
      androidParameters: AndroidParameters(
        packageName: 'com.recipto.customer_app',
        // minimumVersion: 0,
      ),
      iosParameters: IOSParameters(
        bundleId: 'com.recipto.customerapp',
        minimumVersion: '1',
        appStoreId: '6444468019',
      ),
    );

    final link = await FirebaseDynamicLinks.instance.buildLink(parameters);
    log('link : $link');
    // var dynamicUrl = await parameters.link;
    // log('dynamicUrl : $dynamicUrl');
    log("link data: ${link.data}");
    log("link normalizePath: ${link.normalizePath()}");
    String appUrl = link.toString();
    log('appUrl : $appUrl');
    String decodeUrl = Uri.decodeFull(appUrl);
    log('appUrl : $decodeUrl');
    return decodeUrl;
  }

  Future<void> retrieveDynamicLink() async {
    try {
      final PendingDynamicLinkData? data =
          await FirebaseDynamicLinks.instance.getInitialLink();
      log("data :${data}");
      final Uri? deepLink = data?.link;
      log("deepLink :${deepLink}");
      if (deepLink != null) {
        var referralCode = deepLink.queryParameters['refercode'];
        if (referralCode?.isNotEmpty ?? false) {
          print('referralCode : $referralCode');

          UserViewModel.setRefferralCode(referralCode ?? '');
          await Get.toNamed(AppRoutes.EnterNumberScreen);
          // Get.to(EnterNumberScreen());
        }
      }

      FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) async {
        log("dynamicLinkData :${dynamicLinkData}");
        var isReferralCode = dynamicLinkData.link.query.contains('refercode');
        if (isReferralCode) {
          var getQuery = dynamicLinkData.link.query;
          var getReferralCode = getQuery.split('refercode=');
          if (getReferralCode.isNotEmpty) {
            UserViewModel.setRefferralCode(getReferralCode[1]);
            // Get.to(EnterNumberScreen());
            await Get.toNamed(AppRoutes.EnterNumberScreen);
            // UserViewModel.setRefferralCode('StoreREST8485');
            print('getReferralCode : $getReferralCode');
          }
        }
      }).onError((error) {});
    } catch (e) {
      print(e.toString());
    }
  }
// void _handleDeepLink(PendingDynamicLinkData? data) {
//   final Uri? deepLink = data?.link;
//   if (deepLink != null) {
//     print('_handleDeepLink | deepLink: $deepLink');
//     Get.offNamed(AppRoutes.Authentication);
//   }
// }
}
