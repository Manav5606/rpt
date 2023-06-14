import 'package:customer_app/app/controller/account_controller.dart';
import 'package:customer_app/app/controller/add_location_controller.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/routes/app_list.dart';
import 'package:flutter/material.dart';
import 'package:customer_app/app/constants/app_constants.dart';
import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/app/ui/pages/location_picker/address_model.dart';
import 'package:customer_app/constants/string_constants.dart';
import 'package:customer_app/controllers/userViewModel.dart';
import 'package:customer_app/screens/home/controller/home_controller.dart';
import 'package:customer_app/screens/wallet/controller/paymentController.dart';
import 'package:customer_app/screens/wallet/loyaltyCardList.dart';
import 'package:customer_app/theme/styles.dart';

import 'package:customer_app/widgets/backButton.dart';
import 'package:customer_app/widgets/homescreen_appbar.dart';
import 'package:customer_app/widgets/permission_raw.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';

class LoyaltyCardScreen extends StatefulWidget {
  LoyaltyCardScreen({Key? key}) : super(key: key);

  @override
  State<LoyaltyCardScreen> createState() => _LoyaltyCardScreenState();
}

class _LoyaltyCardScreenState extends State<LoyaltyCardScreen> {
  final HomeController _homeController = Get.find();

  final PaymentController _paymentController = Get.find();
  final MyAccountController _myaccount = Get.find();
  final AddLocationController _addLocationController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _addLocationController.checkPermission.listen((p0) async {
      _paymentController.latLng = LatLng(
          UserViewModel.currentLocation.value.latitude,
          UserViewModel.currentLocation.value.longitude);
      await _paymentController.getRedeemCashInStorePage();
    });
  }
   Future<bool> handleBackPressed() async {
    Get.offAllNamed(AppRoutes.BaseScreen);
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop:handleBackPressed,
      child: Scaffold(
        appBar: AppBar(
          elevation: 1,
          automaticallyImplyLeading: false,
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: AppConst.white,
              statusBarIconBrightness: Brightness.dark),
          // backgroundColor: Color(0xff005b41),
          title: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoutes.BaseScreen);
                },
                child: Icon(
                  Icons.arrow_back,
                  size: 3.h,
                  color: AppConst.black,
                ),
              ),
              Spacer(),
              SizedBox(
                height: 3.5.h,
                child: Image(
                  image: AssetImage(
                    'assets/images/Redeem.png',
                  ),
                ),
              ),
              SizedBox(
                width: 4.w,
              ),
              Text("Pay To Store",
                  style: TextStyle(
                    fontFamily: 'MuseoSans',
                    color: AppConst.black,
                    fontSize: SizeUtils.horizontalBlockSize * 4.5,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                  )),
              Spacer(),
              InkWell(
                  onTap: () async {
                    dynamic value = await Get.to(AddressModel(
                      isHomeScreen: false,
                      page: "redeem",
                    ));
                    _paymentController.latLng = LatLng(
                        UserViewModel.currentLocation.value.latitude,
                        UserViewModel.currentLocation.value.longitude);
                    await _paymentController.getScanReceiptPageNearMeStoresData();
                    // if (Constants.isAbleToCallApi)
                    //   await _homeController.getAllCartsData();
                  },
                  child: SizedBox(
                    width: 10.w,
                    child: Icon(
                      Icons.location_on,
                      size: 3.h,
                    ),
                  ))
            ],
          ),
          // title: Obx(
          //   () => HomeAppBar(
          //     onTap: () async {
          //       dynamic value = await Get.to(AddressModel(
          //         isHomeScreen: true,
          //       ));
          //       _paymentController.latLng = LatLng(
          //           UserViewModel.currentLocation.value.latitude,
          //           UserViewModel.currentLocation.value.longitude);
          //       await _paymentController.getRedeemCashInStorePage();
          //       if (Constants.isAbleToCallApi)
          //         await _homeController.getAllCartsData();
          //     },
          //     isRedDot:
          //         _homeController.getAllCartsModel.value?.cartItemsTotal != 0
          //             ? true
          //             : false,
          //     address: _homeController.userAddress.value,
          //     balance: (_myaccount.user.balance ?? 0),
          //     onTapWallet: () {
          //       Get.toNamed(AppRoutes.Wallet);
          //     },
          //   ),
          // ),
        ),
        body:
            // Obx(
            //   () =>
            Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 1.w),
                child: Text(
                    "The cashback you have earned from each stores are shown below. ",
                    style: TextStyle(
                      fontFamily: 'MuseoSans',
                      color: AppConst.black,
                      fontSize: SizeUtils.horizontalBlockSize * 4,
                      fontWeight: FontWeight.w300,
                      fontStyle: FontStyle.normal,
                    )),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: loyaltyCardList(),
                ),
              ),
            ],
          ),
        ),
        // ),
      ),
    );
  }
}
