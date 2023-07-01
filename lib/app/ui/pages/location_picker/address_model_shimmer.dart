import 'dart:async';
import 'dart:developer';

import 'package:customer_app/app/ui/common/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../../constants/app_const.dart';
import '../../../../constants/string_constants.dart';
import '../../../../controllers/userViewModel.dart';
import '../../../../routes/app_list.dart';
import '../../../../screens/home/controller/home_controller.dart';
import '../../../../widgets/getstorge.dart';
import '../../../../widgets/search_field.dart';
import '../../../constants/responsive.dart';
import '../../../controller/add_location_controller.dart';
import '../signIn/phone_authentication_screen.dart';
import 'address_model.dart';

class AddresShimmer extends StatefulWidget {
  final bool isHomeScreen;
  final bool isSavedAddress;
  final String? page;
  final bool editOrDelete;

  AddresShimmer(
      {Key? key,
      this.isHomeScreen = false,
      this.isSavedAddress = true,
      this.editOrDelete = false,
      this.page})
      : super(key: key);

  @override
  State<AddresShimmer> createState() => _AddresShimmerState();
}

class _AddresShimmerState extends State<AddresShimmer> {
  final HomeController _homeController = Get.find();
  final AddLocationController _addLocationController = Get.find();

  FocusNode focusNode = FocusNode();

  Timer? _debounce;
  bool selected = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        toolbarHeight: 5.5.h,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: AppConst.white,
            statusBarIconBrightness: Brightness.dark),
        centerTitle: true,
        iconTheme: IconThemeData(color: Color(0xff4A4A4A), size: 2.6.h),
        // title: Row(
        //   // mainAxisSize: MainAxisSize.min,
        //   children: [
        //     Text(
        //       (widget.editOrDelete == true) ? "My Addresses" : "Choose address",
        //       style: TextStyle(
        //         color: AppConst.black,
        //         fontFamily: 'MuseoSans',
        //         fontWeight: FontWeight.w700,
        //         fontStyle: FontStyle.normal,
        //         fontSize: SizeUtils.horizontalBlockSize * 4.5,
        //       ),
        //     ),
        //   ],
        // ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        EdgeInsets.only(left: 2.5.w, bottom: 1.2.h, top: 0.h),
                    child: Text(
                      "Search for your location",
                      style: TextStyle(
                        fontFamily: 'MuseoSans',
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal,
                        fontSize: (SizerUtil.deviceType == DeviceType.tablet)
                            ? 8.3.sp
                            : 9.3.sp,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  // Padding(
                  //     padding: EdgeInsets.symmetric(horizontal: 2.w),
                  //     child: ShimmerEffect(
                  //         child: SearchField(
                  //       controller: _addLocationController.searchController,
                  //     ))),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2.w),
                    child: Container(
                      height: 4.6.h,
                      decoration: BoxDecoration(
                          color: AppConst.veryLightGrey,
                          borderRadius: BorderRadius.circular(50)),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.search,
                              size: 2.5.h,
                              color: AppConst.lightGrey,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            ShimmerEffect(
                              child: Container(
                                height: 1.5.h,
                                width: 30.w,
                                decoration: BoxDecoration(
                                    color: AppConst.black,
                                    borderRadius: BorderRadius.circular(50)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: ShimmerEffect(
                child: Container(
                  height: 2.5.h,
                  width: 40.w,
                  decoration: BoxDecoration(
                      color: AppConst.black,
                      borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 4.w, top: 3.5.h, bottom: 1.5.h),
              child: ShimmerEffect(
                child: Container(
                  height: 3.5.h,
                  width: 40.w,
                  decoration: BoxDecoration(
                      color: AppConst.black,
                      borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ),
            ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 8,
              itemBuilder: (context, index) {
                return AddresslistShimmer();
              },
              separatorBuilder: (context, index) {
                return SizedBox();
              },
            ),
            // AddresslistShimmer()
          ],
        ),
      ),
      // ),
    );
  }
}

class AddresslistShimmer extends StatelessWidget {
  const AddresslistShimmer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 4.w, top: 1.h, bottom: 2.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShimmerEffect(
            child: Container(
              height: 3.h,
              width: 7.w,
              decoration: BoxDecoration(
                  color: AppConst.black,
                  borderRadius: BorderRadius.circular(8)),
            ),
          ),
          SizedBox(
            width: 2.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShimmerEffect(
                child: Container(
                  height: 2.h,
                  width: 30.w,
                  decoration: BoxDecoration(
                      color: AppConst.black,
                      borderRadius: BorderRadius.circular(8)),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              ShimmerEffect(
                child: Container(
                  height: 2.h,
                  width: 80.w,
                  decoration: BoxDecoration(
                      color: AppConst.black,
                      borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
