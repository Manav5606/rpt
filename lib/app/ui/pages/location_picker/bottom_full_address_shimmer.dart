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
      onTap: () {
        setState(() {
          if (!isDisabled.value) {
            _selectedTag = index;
          }
        });
      },
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
            decoration: BoxDecoration(
                color: _selectedTag == index
                    ? isDisabled.value
                        ? AppConst.grey
                        : AppConst.kSecondaryTextColor
                    : AppConst.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                    color: isDisabled.value
                        ? AppConst.grey
                        : AppConst.kSecondaryTextColor)),
            child: Row(
              children: [
                Text(
                  "${_tags[index]} ",
                  style: TextStyle(
                      color: _selectedTag != index
                          ? AppConst.kSecondaryTextColor
                          : AppConst.white,
                      fontFamily: 'Poppins',
                      fontSize: SizeUtils.horizontalBlockSize * 4),
                ),
                if (_selectedTag == index)
                  Icon(
                    Icons.verified_outlined,
                    color: AppConst.white,
                    size: SizeUtils.horizontalBlockSize * 3.5,
                  )
              ],
            ),
          ),
          SizedBox(
            width: 1.w,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppConst.white,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 2.h),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Text(
                          "Stores Count ",
                          style: TextStyle(
                            fontSize: SizeUtils.horizontalBlockSize * 5,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Flexible(
                          child: Text(
                            widget.storesCount.toString(),
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: SizeUtils.horizontalBlockSize * 5.5,
                              color: AppConst.kSecondaryTextColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: SizeUtils.horizontalBlockSize * 0.40),
                          child: GestureDetector(
                            onTap: () async {
                              // await _addLocationController.getClaimRewardsPageData();
                              Get.toNamed(AppRoutes.WalletOffer);
                            },
                            child: Text(
                              'Edit',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: SizeUtils.horizontalBlockSize * 5,
                                color: AppConst.kSecondaryColor,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "CashBack Count ",
                        style: TextStyle(
                          fontSize: SizeUtils.horizontalBlockSize * 5,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        widget.cashBackCount.toString(),
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: SizeUtils.horizontalBlockSize * 5.5,
                          color: AppConst.kSecondaryTextColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ShimmerEffect(child: Divider(height: 0)),
            ShimmerEffect(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 1.h),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Enter address details",
                        style: TextStyle(
                          fontSize: SizeUtils.horizontalBlockSize * 5.5,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    IconButton(
                        iconSize: SizeUtils.horizontalBlockSize * 6.33,
                        padding: EdgeInsets.zero,
                        splashRadius: 25,
                        visualDensity: VisualDensity(horizontal: -4),
                        onPressed: () {
                          // widget.notifyParent();
                        },
                        icon: Icon(Icons.close))
                  ],
                ),
              ),
            ),
            ShimmerEffect(child: Divider(height: 0)),
            ShimmerEffect(
              child: Padding(
                padding: EdgeInsets.only(
                  top: 1.h,
                ),
                child: Text(
                  "YOUR LOCATION",
                  style: TextStyle(
                    color: AppConst.grey,
                    fontSize: SizeUtils.horizontalBlockSize * 3.5,
                  ),
                ),
              ),
            ),
            ShimmerEffect(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 0.5.h,
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.verified_outlined,
                      color: AppConst.blue,
                      size: SizeUtils.horizontalBlockSize * 5.10,
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    Expanded(
                      child: Text(
                        widget.address,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: AppConst.black,
                          fontSize: SizeUtils.horizontalBlockSize * 4.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        dynamic value = await showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          useRootNavigator: true,
                          builder: (context) {
                            return AddressModel();
                          },
                        );
                        if (value != null) {
                          widget.notifyParent();
                          widget.getCurrentLocation.call();
                        }
                      },
                      child: Text(
                        "CHANGE",
                        style: TextStyle(
                          color: AppConst.kSecondaryTextColor,
                          fontSize: SizeUtils.horizontalBlockSize * 4.2,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            ShimmerEffect(child: Divider()),
            ShimmerEffect(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 1.h,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Form(
                      key: _key,
                      child: TextFormField(
                        controller: _completeAddressController,
                        onChanged: (val) {
                          setState(() {});
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter valid details';
                          }
                        },
                        style: TextStyle(
                            fontSize: SizeUtils.horizontalBlockSize * 4.5),
                        decoration: InputDecoration(
                          // contentPadding: EdgeInsets.only(bottom: SizeUtils.horizontalBlockSize * 2, top: SizeUtils.horizontalBlockSize * 1.27),
                          isDense: true,
                          hintText: "Complete Address *",
                          hintStyle: isDisabled.value
                              ? TextStyle(
                                  color: AppConst.lightGrey,
                                  fontSize: SizeUtils.horizontalBlockSize * 4.5)
                              : TextStyle(
                                  color: AppConst.grey,
                                  fontSize:
                                      SizeUtils.horizontalBlockSize * 4.5),
                          errorStyle: TextStyle(
                            color: AppConst.kPrimaryColor,
                          ),
                          enabled: !isDisabled.value,
                          // floatingLabelBehavior: FloatingLabelBehavior.always,
                          suffixIconConstraints: BoxConstraints.tightFor(),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: AppConst.kPrimaryColor),
                          ),
                          suffixIcon: _completeAddressController.text.length > 0
                              ? TextFieldClearButton(
                                  onTap: () {
                                    _completeAddressController.clear();
                                    setState(() {});
                                  },
                                )
                              : null,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    TextFormField(
                      onChanged: (val) {
                        setState(() {});
                      },
                      controller: _floorController,
                      style: TextStyle(
                          fontSize: SizeUtils.horizontalBlockSize * 4.5),
                      decoration: InputDecoration(
                        // contentPadding: EdgeInsets.only(bottom: SizeUtils.horizontalBlockSize * 2, top: SizeUtils.horizontalBlockSize * 3.82),
                        isDense: true,
                        hintText: "Floor (Optional)",
                        hintStyle: isDisabled.value
                            ? TextStyle(
                                color: AppConst.lightGrey,
                                fontSize: SizeUtils.horizontalBlockSize * 4.5)
                            : TextStyle(
                                color: AppConst.grey,
                                fontSize: SizeUtils.horizontalBlockSize * 4.5),
                        enabled: !isDisabled.value,
                        // floatingLabelBehavior: FloatingLabelBehavior.always,
                        suffixIconConstraints: BoxConstraints.tightFor(),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: AppConst.kPrimaryColor),
                        ),
                        suffixIcon: _floorController.text.length > 0
                            ? TextFieldClearButton(
                                onTap: () {
                                  _floorController.clear();
                                  setState(() {});
                                },
                              )
                            : null,
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    TextFormField(
                      controller: _howToReachController,
                      onChanged: (val) {
                        setState(() {});
                      },
                      style: TextStyle(
                          fontSize: SizeUtils.horizontalBlockSize * 4.5),
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: "How to reach (Optional)",
                        hintStyle: isDisabled.value
                            ? TextStyle(
                                color: AppConst.lightGrey,
                                fontSize: SizeUtils.horizontalBlockSize * 4.5,
                              )
                            : TextStyle(
                                color: AppConst.grey,
                                fontSize: SizeUtils.horizontalBlockSize * 4.5,
                              ),
                        enabled: !isDisabled.value,
                        // floatingLabelBehavior: FloatingLabelBehavior.always,
                        suffixIconConstraints: BoxConstraints.tightFor(),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: AppConst.kPrimaryColor),
                        ),
                        suffixIcon: _howToReachController.text.length > 0
                            ? TextFieldClearButton(
                                onTap: () {
                                  _howToReachController.clear();
                                  setState(() {});
                                },
                              )
                            : null,
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Text(
                      "Tag this location for later",
                      style: TextStyle(
                        color: AppConst.grey,
                        fontSize: SizeUtils.horizontalBlockSize * 4,
                      ),
                    ),
                    SizedBox(
                      height: 0.5.h,
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
              ),
            ),
            ShimmerEffect(
              child: SizedBox(
                height: 1.h,
              ),
            ),
            ShimmerEffect(
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        primary: isDisabled.value
                            ? AppConst.grey
                            : AppConst.kSecondaryTextColor,
                        padding: EdgeInsets.all(
                            SizeUtils.horizontalBlockSize * 3.31),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              SizeUtils.horizontalBlockSize * 3),
                        ),
                      ),
                      onPressed: () async {
                        _addLocationController.isLoading.value = true;

                        try {
                          if (!isDisabled.value &&
                              (_key.currentState?.validate() ?? false)) {
                            // if (_addLocationController.storesCount.value !=
                            //     _addLocationController.updatedStoresCount.value) {
                            //   print("====>Changes");
                            //
                            //   /// Changes
                            //   await _addLocationController.addMultipleStoreToWallet();
                            // } else {
                            //   print("====> No Changes");
                            //
                            //   /// No Changes
                            //   // await _addLocationController.addMultipleStoreToWallet();
                            // }
                            // await _addLocationController.addCustomerAddress(
                            //   lng: _addLocationController
                            //           .middlePointOfScreenOnMap?.longitude ??
                            //       0,
                            //   lat: _addLocationController
                            //           .middlePointOfScreenOnMap?.latitude ??
                            //       0,
                            //   address: _completeAddressController.text,
                            //   title: _tags[_selectedTag],
                            //   house: _floorController.text,
                            //   apartment: '',
                            //   directionToReach: _howToReachController.text,
                            // );
                          }
                        } catch (e) {
                          _addLocationController.isLoading.value = false;
                        }
                        _addLocationController.isLoading.value = false;
                      },
                      child: Text(
                        "Confirm location",
                        style: TextStyle(
                          fontSize: SizeUtils.horizontalBlockSize * 5,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ShimmerEffect(
              child: SizedBox(
                height: 3.h,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
