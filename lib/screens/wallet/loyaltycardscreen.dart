import 'package:customer_app/app/controller/account_controller.dart';
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
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LoyaltyCardScreen extends StatefulWidget {
  LoyaltyCardScreen({Key? key}) : super(key: key);

  @override
  State<LoyaltyCardScreen> createState() => _LoyaltyCardScreenState();
}

class _LoyaltyCardScreenState extends State<LoyaltyCardScreen> {
  final HomeController _homeController = Get.find();

  final PaymentController _paymentController = Get.find();
  final MyAccountController _myaccount = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _homeController.checkPermission.listen((p0) async {
      _paymentController.latLng = LatLng(
          UserViewModel.currentLocation.value.latitude,
          UserViewModel.currentLocation.value.longitude);
      await _paymentController.getRedeemCashInStorePage();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Obx(
          () => HomeAppBar(
            onTap: () async {
              dynamic value = await Get.to(AddressModel(
                isHomeScreen: true,
              ));
              _paymentController.latLng = LatLng(
                  UserViewModel.currentLocation.value.latitude,
                  UserViewModel.currentLocation.value.longitude);
              await _paymentController.getRedeemCashInStorePage();
              if (Constants.isAbleToCallApi)
                await _homeController.getAllCartsData();
            },
            isRedDot:
                _homeController.getAllCartsModel.value?.cartItemsTotal != 0
                    ? true
                    : false,
            address: _homeController.userAddress.value,
            balance: (_myaccount.user.balance ?? 0),
            onTapWallet: () {
              Get.toNamed(AppRoutes.Wallet);
            },
          ),
        ),
      ),
      body: SafeArea(
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _homeController.checkPermission.value
                  ? SizedBox()
                  : PermissionRaw(
                      onTap: () async {
                        bool isEnable =
                            await _homeController.getCurrentLocation();
                        if (isEnable) {
                          _paymentController.latLng = LatLng(
                              UserViewModel.currentLocation.value.latitude,
                              UserViewModel.currentLocation.value.longitude);
                          await _paymentController.getRedeemCashInStorePage();
                        }
                      },
                    ),
              SizedBox(
                height: SizeUtils.horizontalBlockSize * 5,
              ),
              Container(
                  height: SizeUtils.horizontalBlockSize * 10,
                  width: SizeUtils.horizontalBlockSize * 65,
                  alignment: Alignment.topLeft,
                  child: FittedBox(
                    child: Text(
                      "Loyalty Cards",
                      style: TextStyle(
                          fontSize: SizeUtils.horizontalBlockSize * 8,
                          fontWeight: FontWeight.bold),
                    ),
                  )),
              SizedBox(
                height: SizeUtils.horizontalBlockSize * 5,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: loyaltyCardList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
