import 'package:customer_app/app/ui/pages/signIn/phone_authentication_screen.dart';
import 'package:flutter/material.dart';
import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/app/controller/add_location_controller.dart';
import 'package:customer_app/app/ui/common/shimmer_widget.dart';
import 'package:customer_app/app/ui/pages/location_picker/address_model.dart';
import 'package:customer_app/constants/app_const.dart';

import 'package:customer_app/routes/app_list.dart';
import 'package:customer_app/widgets/textfield_clear_button.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class BottomFullAddressSheetShimmer extends StatefulWidget {
  final Function() notifyParent;
  final Function() getCurrentLocation;
  final String address;
  final int storesCount;
  final int cashBackCount;
  final bool isFullAddesss;

  const BottomFullAddressSheetShimmer(
      {Key? key,
      required this.address,
      required this.notifyParent,
      required this.getCurrentLocation,
      required this.storesCount,
      required this.cashBackCount,
      required this.isFullAddesss})
      : super(key: key);

  @override
  State<BottomFullAddressSheetShimmer> createState() =>
      _BottomFullAddressSheetShimmerState();
}

class _BottomFullAddressSheetShimmerState
    extends State<BottomFullAddressSheetShimmer> {
  final TextEditingController _completeAddressController =
      TextEditingController();
  final TextEditingController _floorController = TextEditingController();
  final TextEditingController _howToReachController = TextEditingController();
  RxBool isDisabled = false.obs;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final AddLocationController _addLocationController = Get.find();

  @override
  void initState() {
    if (widget.storesCount == 0) {
      isDisabled.value = true;
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _completeAddressController.dispose();
    _floorController.dispose();
    _howToReachController.dispose();
  }

  List<String> _tags = ["Home", "Work", "Hotel", "Other"];
  int _selectedTag = 0;

  Widget _buildTags(int index) {
    return GestureDetector(
      child: Row(
        children: [
          ShimmerEffect(
            child: Container(
              margin: EdgeInsets.only(
                left: 3.w,
                top: 1.5.h,
                bottom: 1.5.h,
              ),
              padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
              child: Row(
                children: [
                  Text(
                    "",
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        ShimmerEffect(
          child: Container(
            height: 28.h,
            color: AppConst.black,
          ),
        ),
        Container(
          color: AppConst.white,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 3.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0, vertical: 1.5.h),
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            ShimmerEffect(
                              child: Icon(
                                Icons.location_on_rounded,
                                color: AppConst.green,
                                size: 3.5.h,
                              ),
                            ),
                            SizedBox(
                              width: 2.w,
                            ),
                            ShimmerEffect(
                              child: Text(
                                _addLocationController.SortByCharactor(
                                    _addLocationController.currentAddress.value
                                        .toString(),
                                    ","),
                                // parts[0],
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                  color: AppConst.black,
                                  fontFamily: 'MuseoSans',
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FontStyle.normal,
                                  fontSize: SizeUtils.horizontalBlockSize * 4.2,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 2.w, bottom: 1.h, right: 2.w, top: 1.h),
                          child: ShimmerEffect(
                            child: Text(
                              _addLocationController.currentAddress.value
                                  .toString(),
                              maxLines: 1,
                              overflow: TextOverflow.visible,
                              style: TextStyle(
                                fontFamily: 'MuseoSans',
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.normal,
                                color: AppConst.black,
                                fontSize: SizeUtils.horizontalBlockSize * 3.2,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: 1.h, left: 3.w, right: 1.w, bottom: 1.h),
                      child: ShimmerEffect(
                        child: Container(
                          width: 88.w,
                          height: 5.h,
                          color: AppConst.black,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 1.h,
                        left: 3.w,
                        right: 1.w,
                      ),
                      child: ShimmerEffect(
                        child: Container(
                          width: 88.w,
                          height: 5.h,
                          color: AppConst.black,
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 0, vertical: 1.h),
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 0.7.h, left: 3.w),
                              child: ShimmerEffect(
                                child: Text(
                                  "How to Reach (Optional)",
                                  style: TextStyle(
                                    color: AppConst.grey,
                                    fontSize:
                                        SizeUtils.horizontalBlockSize * 3.5,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 0.5.h, left: 3.w, right: 1.w),
                              child: Row(
                                children: [
                                  ShimmerEffect(
                                    child: Container(
                                      width: 88.w,
                                      height: 12.h,
                                      color: AppConst.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 2.w, top: 2.h),
                      child: ShimmerEffect(
                        child: Text(
                          "Save this address as:",
                          style: TextStyle(
                            color: AppConst.black,
                            fontSize: SizeUtils.horizontalBlockSize * 4,
                            fontFamily: 'MuseoSans',
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: _tags
                          .asMap()
                          .entries
                          .map((MapEntry map) => _buildTags(map.key))
                          .toList(),
                    ),
                  ],
                ),
                SizedBox(
                  height: 1.h,
                ),
                ShimmerEffect(child: BottomWideButton()),
                SizedBox(
                  height: 1.h,
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
