import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/app/controller/add_location_controller.dart';
import 'package:customer_app/app/data/model/address_model.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/controllers/userViewModel.dart';
import 'package:customer_app/widgets/textfield_clear_button.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';

class EditAddressScreen extends StatefulWidget {
  @override
  State<EditAddressScreen> createState() => _EditAddressScreenState();
}

class _EditAddressScreenState extends State<EditAddressScreen> {
  RxBool isDisabled = false.obs;

  final TextEditingController _floorController = TextEditingController();
  final TextEditingController _howToReachController = TextEditingController();
  // final TextEditingController _addressController = TextEditingController();
  final TextEditingController _completeAddressController =
      TextEditingController();
  final TextEditingController _otherController = TextEditingController();

  List<String> _tags = ["Home", "Work", "Hotel", "Other"];

  int _selectedTag = 0;
  AddressModel? addressModel;
  bool? isHomeSelected;
  final AddLocationController _addLocationController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Map arg = Get.arguments ?? {};
    addressModel = arg['addresses'];
    isHomeSelected = arg['isHomeSelected'];
    print(isHomeSelected);
    // _addressController.text = addressModel?.address ?? '';
    _completeAddressController.text = addressModel?.apartment ?? '';
    _floorController.text = addressModel?.house ?? '';
    _howToReachController.text = addressModel?.directionReach ?? '';
    var index = _tags.indexWhere((element) =>
        element.toUpperCase() ==
        addressModel?.title?.substring(0, 3).toUpperCase());

    if (addressModel!.title == _tags[0]) {
      _selectedTag = 0;
    } else if (addressModel!.title == _tags[1]) {
      _selectedTag = 1;
    } else if (addressModel!.title == _tags[2]) {
      _selectedTag = 2;
    } else {
      _selectedTag = 3;
      _otherController.text = addressModel!.title!;
    }
    // _selectedTag = index;
  }

  @override
  void dispose() {
    super.dispose();

    _otherController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: LayoutBuilder(builder: (context, constraint) {
      return SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraint.maxHeight),
          child: IntrinsicHeight(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 2.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 3.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "Edit address ",
                              style: TextStyle(
                                fontSize: SizeUtils.horizontalBlockSize * 5,
                                fontWeight: FontWeight.bold,
                                // color: Colors.green
                              ),
                            ),
                            Spacer(),
                            IconButton(
                                iconSize: SizeUtils.horizontalBlockSize * 6.33,
                                padding: EdgeInsets.zero,
                                splashRadius: 25,
                                visualDensity: VisualDensity(horizontal: -4),
                                onPressed: () {
                                  Get.back();
                                },
                                icon: Icon(Icons.close)),
                            SizedBox(
                              width: 2.w,
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Stack(
                        children: [
                          Container(
                            height: 28.h,
                            child: GoogleMap(
                              initialCameraPosition: CameraPosition(
                                target: LatLng(
                                    _addLocationController
                                        .currentPosition.latitude,
                                    _addLocationController
                                        .currentPosition.longitude),
                                zoom: 17,
                              ),
                              myLocationEnabled: false,
                              myLocationButtonEnabled: false,
                              onCameraIdle: _addLocationController.onCameraIdle,
                              zoomControlsEnabled: false,
                              onCameraMove: _addLocationController.onCameraMove,
                              onMapCreated: _addLocationController.onMapCreated,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10.h, left: 45.w),
                            child: Container(
                              height: 7.h,
                              width: 10.w,
                              child: Image.asset('assets/icons/pinsmall.png'),
                            ),
                          ),
                          Container(
                            height: 28.h,
                            width: double.infinity,
                            color: AppConst.transparent,
                          )
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 0, vertical: 1.5.h),
                        child: Container(
                          // decoration: BoxDecoration(
                          //   border: Border.all(color: AppConst.black, width: 0.3),
                          //   borderRadius: BorderRadius.circular(12),
                          // ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on_rounded,
                                    color: AppConst.green,
                                    size: 3.5.h,
                                  ),
                                  SizedBox(
                                    width: 2.w,
                                  ),
                                  Container(
                                    width: 80.w,
                                    // color: AppConst.yellow,
                                    child: Obx(
                                      () => Text(
                                        // "kkhp",
                                        (_addLocationController
                                                        .currentAddress.value !=
                                                    null &&
                                                _addLocationController
                                                        .currentAddress.value !=
                                                    "")
                                            ? _addLocationController
                                                .SortByCharactor(
                                                    _addLocationController
                                                        .currentAddress.value
                                                        .toString(),
                                                    ",")
                                            : "",
                                        // parts[0],
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: TextStyle(
                                          color: AppConst.black,
                                          fontFamily: 'MuseoSans',
                                          fontWeight: FontWeight.w700,
                                          fontStyle: FontStyle.normal,
                                          fontSize:
                                              SizeUtils.horizontalBlockSize *
                                                  4.2,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 2.w, right: 2.w, top: 1.h),
                                child: Container(
                                  width: 80.w,
                                  child: Obx(
                                    () => Text(
                                      (_addLocationController
                                                      .currentAddress.value !=
                                                  null &&
                                              _addLocationController
                                                      .currentAddress.value !=
                                                  "")
                                          ? _addLocationController
                                              .currentAddress.value
                                              .toString()
                                          : "",
                                      // '${addressModel?.address ?? ''}',
                                      maxLines: 1,
                                      overflow: TextOverflow.visible,
                                      style: TextStyle(
                                        fontFamily: 'MuseoSans',
                                        fontWeight: FontWeight.w300,
                                        fontStyle: FontStyle.normal,
                                        color: AppConst.black,
                                        fontSize:
                                            SizeUtils.horizontalBlockSize * 3.2,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Padding(
                      //   padding: EdgeInsets.symmetric(
                      //       horizontal: 0, vertical: 1.h),
                      //   child: Container(
                      //     decoration: BoxDecoration(
                      //       border: Border.all(
                      //           color: AppConst.black, width: 0.3),
                      //       borderRadius: BorderRadius.circular(12),
                      //     ),
                      //     child: Column(
                      //       mainAxisAlignment: MainAxisAlignment.start,
                      //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       children: [
                      //         Row(
                      //           children: [
                      //             Icon(
                      //               Icons.location_on_rounded,
                      //               color: AppConst.green,
                      //               size: 3.5.h,
                      //             ),
                      //             SizedBox(
                      //               width: 2.w,
                      //             ),
                      //             Container(
                      //               width: 80.w,
                      //               // color: AppConst.yellow,
                      //               // child: Text(
                      //               //   _addLocationController
                      //               //       .SortByCharactor(
                      //               //           (addressModel?.address ?? "")
                      //               //               .toString(),
                      //               //           ","),
                      //               //   // parts[0],
                      //               //   overflow: TextOverflow.ellipsis,
                      //               //   maxLines: 1,
                      //               //   style: TextStyle(
                      //               //     color: AppConst.black,
                      //               //     fontFamily: 'MuseoSans',
                      //               //     fontWeight: FontWeight.w700,
                      //               //     fontStyle: FontStyle.normal,
                      //               //     fontSize:
                      //               //         SizeUtils.horizontalBlockSize *
                      //               //             4.2,
                      //               //   ),
                      //               // ),
                      //             ),
                      //           ],
                      //         ),
                      //         Padding(
                      //           padding: EdgeInsets.only(
                      //               left: 2.w, right: 2.w, top: 1.h),
                      //           child: Container(
                      //             width: 80.w,
                      //             child: Text(
                      //               '${addressModel?.address ?? ''}',
                      //               maxLines: 1,
                      //               overflow: TextOverflow.visible,
                      //               style: TextStyle(
                      //                 fontFamily: 'MuseoSans',
                      //                 fontWeight: FontWeight.w300,
                      //                 fontStyle: FontStyle.normal,
                      //                 color: AppConst.black,
                      //                 fontSize:
                      //                     SizeUtils.horizontalBlockSize *
                      //                         3.2,
                      //               ),
                      //             ),
                      //           ),
                      //         ),
                      //         Padding(
                      //           padding:
                      //               EdgeInsets.only(top: 1.h, left: 3.w),
                      //           child: Text(
                      //             "YOUR LOCATION",
                      //             style: TextStyle(
                      //               color: AppConst.grey,
                      //               fontSize:
                      //                   SizeUtils.horizontalBlockSize * 3,
                      //             ),
                      //           ),
                      //         ),
                      //         Padding(
                      //           padding: EdgeInsets.only(
                      //               top: 0.5.h,
                      //               bottom: 1.h,
                      //               left: 3.w,
                      //               right: 2.w),
                      //           child: Row(
                      //             children: [
                      //               Expanded(
                      //                 child: Text(
                      //                   '${addressModel?.address ?? ''}',
                      //                   maxLines: 1,
                      //                   overflow: TextOverflow.ellipsis,
                      //                   style: TextStyle(
                      //                     color: AppConst.grey,
                      //                     fontSize: SizeUtils
                      //                             .horizontalBlockSize *
                      //                         4.5,
                      //                     fontWeight: FontWeight.bold,
                      //                   ),
                      //                 ),
                      //               ),
                      //             ],
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // TextFieldBox(
                          //   controller: _addressController,
                          //   // upperText: "How to reach (Optional)",
                          //   hintText: "Enter address",
                          // ),
                          TextFieldBox(
                            controller: _completeAddressController,
                            hintText: "Apartment / Building /House Name",
                            // upperText: "Floor (Optional)",
                          ),
                          TextFieldBox(
                            controller: _floorController,
                            // upperText: "How to reach (Optional)",
                            hintText: "Floor (Optional)",
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 0, vertical: 1.h),
                            child: Container(
                              // decoration: BoxDecoration(
                              //   border: Border.all(color: AppConst.black, width: 0.3),
                              //   borderRadius: BorderRadius.circular(14),
                              // ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.only(top: 0.7.h, left: 3.w),
                                    child: Text(
                                      "How to Reach (Optional)",
                                      style: TextStyle(
                                        color: AppConst.grey,
                                        fontSize:
                                            SizeUtils.horizontalBlockSize * 3.5,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: 0.5.h, left: 3.w, right: 1.w),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 88.w,
                                          child: TextFormField(
                                            maxLines: 3,
                                            maxLength: 200,
                                            cursorColor: AppConst.black,
                                            controller: _howToReachController,
                                            onChanged: (val) {
                                              setState(() {});
                                            },
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Enter valid details';
                                              }
                                            },
                                            style: TextStyle(
                                                fontSize: SizeUtils
                                                        .horizontalBlockSize *
                                                    4.5),
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.only(
                                                  bottom: SizeUtils
                                                          .horizontalBlockSize *
                                                      2,
                                                  top: SizeUtils
                                                          .horizontalBlockSize *
                                                      1.27),
                                              isDense: true,

                                              hintText: "",
                                              fillColor: AppConst.veryLightGrey,
                                              filled: true,

                                              // "Complete Address Details*",
                                              hintStyle: isDisabled.value
                                                  ? TextStyle(
                                                      color: AppConst.grey,
                                                      fontSize: SizeUtils
                                                              .horizontalBlockSize *
                                                          4.2)
                                                  : TextStyle(
                                                      color: AppConst.grey,
                                                      fontSize: SizeUtils
                                                              .horizontalBlockSize *
                                                          4.2),
                                              errorStyle: TextStyle(
                                                color: AppConst.kPrimaryColor,
                                              ),
                                              enabled: !isDisabled.value,
                                              // floatingLabelBehavior: FloatingLabelBehavior.always,
                                              suffixIconConstraints:
                                                  BoxConstraints.tightFor(),
                                              disabledBorder: InputBorder.none,
                                              border: InputBorder.none,
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: AppConst.green,
                                                    width: 1.5),
                                              ),
                                              suffixIcon: (_howToReachController
                                                          .text.length) >
                                                      0
                                                  ? TextFieldClearButton(
                                                      onTap: () {
                                                        _howToReachController
                                                            .clear();
                                                        setState(() {});
                                                      },
                                                    )
                                                  : null,
                                            ),
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
                            padding: EdgeInsets.only(
                                left: 2.w, bottom: 1.h, top: 1.h),
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
                          (_selectedTag == 3)
                              ? Padding(
                                  padding: EdgeInsets.only(
                                      bottom: 0.h, left: 3.w, right: 2.w),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: TextFormField(
                                          cursorColor: AppConst.black,
                                          controller: _otherController,
                                          onChanged: (val) {
                                            setState(() {});
                                          },
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Enter valid details';
                                            }
                                          },
                                          style: TextStyle(
                                              fontSize: SizeUtils
                                                      .horizontalBlockSize *
                                                  4.5),
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.only(
                                                bottom: SizeUtils
                                                        .horizontalBlockSize *
                                                    2,
                                                top: SizeUtils
                                                        .horizontalBlockSize *
                                                    1.27),
                                            isDense: true,
                                            hintText: "save as ",
                                            // "Complete Address Details*",
                                            hintStyle:
                                                // isDisabled.value

                                                // ? TextStyle(
                                                //     color: AppConst.grey,
                                                //     fontSize: SizeUtils
                                                //             .horizontalBlockSize *
                                                //         4.2)
                                                // :
                                                TextStyle(
                                                    color: AppConst.grey,
                                                    fontSize: SizeUtils
                                                            .horizontalBlockSize *
                                                        4.2),
                                            errorStyle: TextStyle(
                                              color: AppConst.kPrimaryColor,
                                            ),
                                            // enabled: !isDisabled.value,
                                            // floatingLabelBehavior: FloatingLabelBehavior.always,
                                            suffixIconConstraints:
                                                BoxConstraints.tightFor(),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: AppConst.green,
                                                  width: 1.5),
                                            ),
                                            // suffixIcon: (controller?.text.length)! > 0
                                            //     ? TextFieldClearButton(
                                            //         onTap: () {
                                            //           controller?.clear();
                                            //           setState(() {});
                                            //         },
                                            //       )
                                            //     : null,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : SizedBox(),
                          Row(
                            children: _tags
                                .asMap()
                                .entries
                                .map((MapEntry map) => _buildTags(map.key))
                                .toList(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.all(SizeUtils.horizontalBlockSize * 2),
                  child: Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 6.h,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              primary: (_floorController.value.text.isNotEmpty)
                                  ? AppConst.darkGreen
                                  : AppConst.grey,
                              padding: EdgeInsets.all(3.w),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    SizeUtils.horizontalBlockSize * 3),
                              ),
                            ),
                            onPressed: (_completeAddressController
                                        .value.text.isNotEmpty) &&
                                    ((_selectedTag == 3)
                                        ? ((_otherController.value.text.length >
                                                2)
                                            ? true
                                            : false)
                                        : true)
                                ? () {
                                    if (_selectedTag == 0) {
                                      if (isHomeSelected == true) {
                                        Get.showSnackbar(GetSnackBar(
                                          backgroundColor: AppConst.black,
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 12),
                                          snackStyle: SnackStyle.FLOATING,
                                          borderRadius: 12,
                                          duration: Duration(seconds: 2),
                                          message:
                                              "You Have Already Added the Home Address.",
                                          // title: "Amount must be at least \u{20b9}1"
                                        ));
                                      } else {
                                        addressModel?.address =
                                            _addLocationController
                                                .currentAddress.value;

                                        addressModel?.title =
                                            "${_selectedTag == 3 ? "${_otherController.text}" : "${_tags[_selectedTag]}"}";

                                        addressModel?.apartment =
                                            _completeAddressController.text;
                                        addressModel?.house =
                                            _floorController.text;

                                        addressModel?.directionReach =
                                            _howToReachController.text;
                                        // addressModel?.location?.lat =
                                        //     _addLocationController.latitude.value;
                                        // addressModel?.location?.lng =
                                        //     _addLocationController.longitude.value;
                                        _addLocationController
                                            .replaceCustomerAddress(
                                                addressModel);
                                        UserViewModel.setUser(
                                            _addLocationController.userModel!);

                                        if (!((_addLocationController.userModel
                                                        ?.addresses?.length ??
                                                    0) >
                                                1 &&
                                            _addLocationController
                                                    .userAddress.value !=
                                                addressModel?.address)) {
                                          _addLocationController
                                                  .userAddress.value =
                                              _addLocationController
                                                  .currentAddress.value;
                                          _addLocationController
                                                  .userAddressTitle.value =
                                              "${_selectedTag == 3 ? "${_otherController.text}" : "${_tags[_selectedTag]}"}";

                                          _addLocationController.userHouse
                                              .value = _floorController.text;
                                          _addLocationController
                                                  .userAppartment.value =
                                              _completeAddressController.text;

                                          _addLocationController.latitude
                                              .value = _addLocationController
                                                  .middlePointOfScreenOnMap
                                                  ?.latitude ??
                                              0.0;

                                          _addLocationController.longitude
                                              .value = _addLocationController
                                                  .middlePointOfScreenOnMap
                                                  ?.longitude ??
                                              0;
                                        }
                                        Get.back();
                                      }
                                    } else {
                                      addressModel?.address =
                                          _addLocationController
                                              .currentAddress.value;

                                      addressModel?.title =
                                          "${_selectedTag == 3 ? "${_otherController.text}" : "${_tags[_selectedTag]}"}";

                                      addressModel?.apartment =
                                          _completeAddressController.text;
                                      addressModel?.house =
                                          _floorController.text;

                                      addressModel?.directionReach =
                                          _howToReachController.text;
                                      // addressModel?.location?.lat =
                                      //     _addLocationController.latitude.value;
                                      // addressModel?.location?.lng =
                                      //     _addLocationController.longitude.value;
                                      _addLocationController
                                          .replaceCustomerAddress(addressModel);
                                      UserViewModel.setUser(
                                          _addLocationController.userModel!);

                                      if (!((_addLocationController.userModel
                                                      ?.addresses?.length ??
                                                  0) >
                                              1 &&
                                          _addLocationController
                                                  .userAddress.value !=
                                              addressModel?.address)) {
                                        _addLocationController
                                                .userAddress.value =
                                            _addLocationController
                                                .currentAddress.value;
                                        _addLocationController
                                                .userAddressTitle.value =
                                            "${_selectedTag == 3 ? "${_otherController.text}" : "${_tags[_selectedTag]}"}";

                                        _addLocationController.userHouse.value =
                                            _floorController.text;
                                        _addLocationController
                                                .userAppartment.value =
                                            _completeAddressController.text;

                                        _addLocationController.latitude.value =
                                            _addLocationController
                                                    .middlePointOfScreenOnMap
                                                    ?.latitude ??
                                                0.0;

                                        _addLocationController.longitude.value =
                                            _addLocationController
                                                    .middlePointOfScreenOnMap
                                                    ?.longitude ??
                                                0;
                                      }
                                      Get.back();
                                    
                                    }
                                  }
                                : null,
                            child: Text(
                              "Update Address",
                              style: TextStyle(
                                fontSize: SizeUtils.horizontalBlockSize * 5,
                                fontWeight: FontWeight.bold,
                                color: AppConst.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }));
  }

  Padding TextFieldBox(
      {required TextEditingController? controller,
      // required String? upperText,
      required String? hintText}) {
    return Padding(
      padding: EdgeInsets.only(top: 1.5.h, bottom: 1.h),
      child: Container(
        // decoration: BoxDecoration(
        //   border: Border.all(color: AppConst.black, width: 0.3),
        //   borderRadius: BorderRadius.circular(14),
        // ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Padding(
            //   padding: EdgeInsets.only(top: 0.7.h, left: 3.w),
            //   child: Text(
            //     upperText!,
            //     // "Complete Address",
            //     style: TextStyle(
            //       color: AppConst.grey,
            //       fontSize: SizeUtils.horizontalBlockSize * 3.5,
            //     ),
            //   ),
            // ),
            Padding(
              padding: EdgeInsets.only(bottom: 0.h, left: 3.w, right: 2.w),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      cursorColor: AppConst.black,
                      controller: controller,
                      // _completeAddressController,
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
                        contentPadding: EdgeInsets.only(
                            bottom: SizeUtils.horizontalBlockSize * 2,
                            top: SizeUtils.horizontalBlockSize * 1.27),
                        isDense: true,
                        hintText: hintText!,
                        // "Complete Address Details*",
                        hintStyle: isDisabled.value
                            ? TextStyle(
                                color: AppConst.grey,
                                fontSize: SizeUtils.horizontalBlockSize * 4.2)
                            : TextStyle(
                                color: AppConst.grey,
                                fontSize: SizeUtils.horizontalBlockSize * 4.2),
                        errorStyle: TextStyle(
                          color: AppConst.kPrimaryColor,
                        ),
                        enabled: !isDisabled.value,
                        // floatingLabelBehavior: FloatingLabelBehavior.always,
                        suffixIconConstraints: BoxConstraints.tightFor(),
                        focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: AppConst.green, width: 1.5),
                        ),
                        suffixIcon: (controller?.text.length)! > 0
                            ? TextFieldClearButton(
                                onTap: () {
                                  controller?.clear();
                                  setState(() {});
                                },
                              )
                            : null,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTags(int index) {
    print(index);
    print(_selectedTag);
    return GestureDetector(
      onTap: () {
        setState(() {
          // if (!isDisabled.value) {
          _selectedTag = index;
          print(index);
          print(_selectedTag);
          // }
        });
      },
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(
              left: 3.w,
              top: 1.5.h,
              bottom: 1.5.h,
            ),
            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
            decoration: BoxDecoration(
                color: _selectedTag == index
                    // ? isDisabled.value
                    ? AppConst.veryLightGrey
                    : AppConst.white
                // : AppConst.veryLightGrey
                ,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                    width: 1.5,
                    color: _selectedTag != index
                        ? AppConst.grey
                        : AppConst.green)),
            child: Row(
              children: [
                Text(
                  "${_tags[index]} ",
                  style: TextStyle(
                      color: _selectedTag != index
                          ? AppConst.grey
                          : AppConst.green,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      fontSize: SizeUtils.horizontalBlockSize * 4),
                ),
                // if (_selectedTag == index)
                //   Icon(
                //     Icons.verified_outlined,
                //     color: AppConst.yellowText,
                //     size: SizeUtils.horizontalBlockSize * 3.5,
                //   )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
