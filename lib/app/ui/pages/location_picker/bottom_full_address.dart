import 'package:customer_app/constants/assets_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/app/controller/add_location_controller.dart';
import 'package:customer_app/app/ui/pages/location_picker/address_model.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/routes/app_list.dart';
import 'package:customer_app/widgets/textfield_clear_button.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class BottomFullAddressSheet extends StatefulWidget {
  final Function() notifyParent;
  final Function() getCurrentLocation;
  final String address;
  final int storesCount;
  final int cashBackCount;
  final bool isFullAddesss;

  BottomFullAddressSheet(
      {Key? key,
      required this.address,
      required this.notifyParent,
      required this.getCurrentLocation,
      required this.storesCount,
      required this.cashBackCount,
      required this.isFullAddesss})
      : super(key: key);

  @override
  State<BottomFullAddressSheet> createState() => _BottomFullAddressSheetState();
}

class _BottomFullAddressSheetState extends State<BottomFullAddressSheet> {
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
            margin: EdgeInsets.only(
              left: 3.w,
              top: 1.5.h,
              bottom: 1.5.h,
            ),
            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
            decoration: BoxDecoration(
                color: _selectedTag == index
                    ? isDisabled.value
                        ? AppConst.veryLightGrey
                        : AppConst.white
                    : AppConst.veryLightGrey,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                    color: _selectedTag != index
                        ? AppConst.grey
                        : AppConst.yellowText)),
            child: Row(
              children: [
                Text(
                  "${_tags[index]} ",
                  style: TextStyle(
                      color: _selectedTag != index
                          ? AppConst.grey
                          : AppConst.yellowText,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      fontSize: SizeUtils.horizontalBlockSize * 4),
                ),
                if (_selectedTag == index)
                  Icon(
                    Icons.verified_outlined,
                    color: AppConst.yellowText,
                    size: SizeUtils.horizontalBlockSize * 3.5,
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppConst.white,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          SizedBox(
            height: 2.h,
          ),
          Container(
            color: AppConst.white,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 2.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                          iconSize: SizeUtils.horizontalBlockSize * 6.33,
                          padding: EdgeInsets.zero,
                          splashRadius: 25,
                          visualDensity: VisualDensity(horizontal: -4),
                          onPressed: () {
                            widget.notifyParent();
                          },
                          icon: Icon(Icons.arrow_back)),
                      SizedBox(
                        width: 3.w,
                      ),
                      Text(
                        "Confirm Location",
                        style: TextStyle(
                          fontSize: SizeUtils.horizontalBlockSize * 5,
                          fontWeight: FontWeight.bold,
                          // color: Colors.green
                        ),
                      ),
                      // Spacer(),
                      // InkWell(
                      //   onTap: () {
                      //     widget.notifyParent();
                      //   },
                      //   child: Container(
                      //     padding: EdgeInsets.all(1.w),
                      //     margin: EdgeInsets.only(
                      //       bottom: 1.5.h,
                      //     ),
                      //     decoration: BoxDecoration(
                      //         shape: BoxShape.circle,
                      //         color: AppConst.white,
                      //         border: Border.all(
                      //             color: kPrimaryColor,
                      //             width: SizeUtils.horizontalBlockSize - 2.92),
                      //         boxShadow: [AppConst.shadowBasic]),
                      //     child: Icon(
                      //       Icons.close,
                      //       color: kSecondaryTextColor,
                      //       size: SizeUtils.horizontalBlockSize * 6.5,
                      //     ),
                      //   ),
                      // ),
                      // IconButton(
                      //     iconSize: SizeUtils.horizontalBlockSize * 6.33,
                      //     padding: EdgeInsets.zero,
                      //     splashRadius: 25,
                      //     visualDensity: VisualDensity(horizontal: -4),
                      //     onPressed: () {
                      //       widget.notifyParent();
                      //     },
                      //     icon: Icon(Icons.close)),
                      // SizedBox(
                      //   width: 2.w,
                      // )
                    ],
                  ),

                  SizedBox(
                    height: 1.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2.w),
                    child: InkWell(
                      highlightColor: AppConst.grey,
                      onTap: () async {
                        await _addLocationController.getClaimRewardsPageData();
                        Get.toNamed(AppRoutes.WalletOffer);
                      },
                      child: Container(
                        height: 26.h,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppConst.lightYellow
                            // gradient: LinearGradient(
                            //     begin: Alignment.topCenter,
                            //     end: Alignment.bottomCenter,
                            //     colors: [
                            //       Color(0xff2b0061),
                            //       Color(0xff6b2bc4),
                            //       Color(0xff843deb),
                            //       Color(0xff9146ff)
                            //     ]),
                            ),
                        child: Padding(
                          padding:
                              EdgeInsets.only(left: 3.w, top: 2.h, bottom: 1.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Edit Stores near you",
                                    //  ${widget.storesCount}
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize:
                                            SizeUtils.horizontalBlockSize * 5,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    size: 2.7.h,
                                    color: AppConst.black,
                                  ),
                                  SizedBox(
                                    width: 3.w,
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              Container(
                                width: 80.w,
                                child: Text(
                                  "These are the stores with cashback available near you ",
                                  // ${widget.cashBackCount}
                                  maxLines: 2,
                                  style: TextStyle(
                                      fontSize:
                                          SizeUtils.horizontalBlockSize * 3.7,
                                      fontWeight: FontWeight.w500,
                                      color: AppConst.black),
                                ),
                              ),
                              SizedBox(
                                height: 3.h,
                              ),

                              Row(
                                children: [
                                  Container(
                                      height: 5.h,
                                      width: 12.w,
                                      child: FittedBox(
                                          child: Icon(
                                        Icons.storefront,
                                      )
                                          //  Image.asset(
                                          //   "assets/icons/storelogo.png",
                                          //   fit: BoxFit.fill,
                                          // ),
                                          )),
                                  SizedBox(
                                    width: 2.w,
                                  ),
                                  Text(
                                    "${widget.storesCount}",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize:
                                            SizeUtils.horizontalBlockSize * 5.4,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              RichText(
                                  text: TextSpan(
                                      text: "You Saved   ",
                                      style: TextStyle(
                                          fontSize:
                                              SizeUtils.horizontalBlockSize * 5,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black),
                                      children: [
                                    TextSpan(
                                        text:
                                            "\u{20B9} ${widget.cashBackCount}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize:
                                                SizeUtils.horizontalBlockSize *
                                                    5.5))
                                  ])),
                              //  Text(
                              //       "You Saved ",
                              //       overflow: TextOverflow.ellipsis,
                              //       style: TextStyle(
                              //           fontSize:
                              //               SizeUtils.horizontalBlockSize * 5.4,
                              //           fontWeight: FontWeight.w600,
                              //           color: Colors.white),
                              //     ),
                              // FittedBox(
                              //   child: SizedBox(
                              //     height: 3.5.h,
                              //     child: ElevatedButton(
                              //       child: Text(
                              //         'Edit',
                              //         style: TextStyle(
                              //             fontSize:
                              //                 SizeUtils.horizontalBlockSize * 3.5,
                              //             color: AppConst.black,
                              //             fontWeight: FontWeight.bold),
                              //       ),
                              //       onPressed: () async {
                              //         await _addLocationController
                              //             .getClaimRewardsPageData();
                              //         Get.toNamed(AppRoutes.WalletOffer);
                              //       },
                              //       style: ElevatedButton.styleFrom(
                              //           primary: AppConst.orange,
                              //           shape: RoundedRectangleBorder(
                              //               borderRadius:
                              //                   BorderRadius.circular(15))),
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Padding(
                  //   padding: EdgeInsets.symmetric(vertical: 2.h),
                  //   child: Row(
                  //     children: [
                  //       Expanded(
                  //         child: Row(
                  //           children: [
                  //             Text(
                  //               "Stores Count ",
                  //               style: TextStyle(
                  //                 fontSize: SizeUtils.horizontalBlockSize * 5,
                  //                 fontWeight: FontWeight.w700,
                  //               ),
                  //             ),
                  //             Flexible(
                  //               child: Text(
                  //                 widget.storesCount.toString(),
                  //                 overflow: TextOverflow.ellipsis,
                  //                 style: TextStyle(
                  //                   fontSize: SizeUtils.horizontalBlockSize * 5.5,
                  //                   color: kSecondaryTextColor,
                  //                   fontWeight: FontWeight.w700,
                  //                 ),
                  //               ),
                  //             ),
                  //             Text(
                  //               "(\u20b9",
                  //               style: TextStyle(
                  //                 fontSize: SizeUtils.horizontalBlockSize * 6,
                  //                 fontWeight: FontWeight.w700,
                  //               ),
                  //             ),
                  //             Text(
                  //               "${widget.cashBackCount.toString()}",
                  //               overflow: TextOverflow.ellipsis,
                  //               style: TextStyle(
                  //                 fontSize: SizeUtils.horizontalBlockSize * 5.5,
                  //                 color: kSecondaryTextColor,
                  //                 fontWeight: FontWeight.w700,
                  //               ),
                  //             ),
                  //             Text(
                  //               " You save",
                  //               style: TextStyle(
                  //                 fontSize: SizeUtils.horizontalBlockSize * 5,
                  //                 fontWeight: FontWeight.w700,
                  //               ),
                  //             ),
                  //             Text(
                  //               ")",
                  //               style: TextStyle(
                  //                 fontSize: SizeUtils.horizontalBlockSize * 6,
                  //                 fontWeight: FontWeight.w700,
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //       Row(
                  //         children: [
                  //           Padding(
                  //             padding: EdgeInsets.only(
                  //                 left: SizeUtils.horizontalBlockSize * 0.40),
                  //             child: GestureDetector(
                  //               onTap: () async {
                  // await _addLocationController.getClaimRewardsPageData();
                  //                 Get.toNamed(AppRoutes.WalletOffer);
                  //               },
                  //               child: Text(
                  //                 'Edit',
                  //                 style: TextStyle(
                  //                   decoration: TextDecoration.underline,
                  //                   fontSize: SizeUtils.horizontalBlockSize * 5,
                  //                   color: kSecondaryColor,
                  //                   fontWeight: FontWeight.w700,
                  //                 ),
                  //               ),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // Divider(height: 0),
                  // Padding(
                  //   padding: EdgeInsets.symmetric(vertical: 1.h),
                  //   child: Row(
                  //     children: [
                  //       Expanded(
                  //         child: Text(
                  //           "Enter address details",
                  //           style: TextStyle(
                  //             fontSize: SizeUtils.horizontalBlockSize * 5.5,
                  //             fontWeight: FontWeight.w700,
                  //           ),
                  //         ),
                  //       ),
                  // IconButton(
                  //     iconSize: SizeUtils.horizontalBlockSize * 6.33,
                  //     padding: EdgeInsets.zero,
                  //     splashRadius: 25,
                  //     visualDensity: VisualDensity(horizontal: -4),
                  //     onPressed: () {
                  //       widget.notifyParent();
                  //     },
                  //     icon: Icon(Icons.close))
                  //     ],
                  //   ),
                  // ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 0, vertical: 1.5.h),
                    child: Container(
                      // decoration: BoxDecoration(
                      //   border: Border.all(color: AppConst.black, width: 0.3),
                      //   borderRadius: BorderRadius.circular(12),
                      // ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 3.w),
                            child: Text(
                              "Your Address ",
                              style: TextStyle(
                                  color: AppConst.yellowText,
                                  fontSize: SizeUtils.horizontalBlockSize * 3.5,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 1.h, left: 3.w, right: 2.w),
                            child: Row(
                              children: [
                                Container(
                                  width: 85.w,
                                  child: Text(
                                    widget.address,
                                    maxLines: 2,
                                    overflow: TextOverflow.visible,
                                    style: TextStyle(
                                      color: AppConst.black,
                                      fontSize:
                                          SizeUtils.horizontalBlockSize * 4,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                // InkWell(
                                //   onTap: () async {
                                //     dynamic value = await Get.to(AddressModel(
                                //       isSavedAddress: false,
                                //     ));
                                //     // dynamic value =
                                //     //     await showModalBottomSheet(
                                //     //   isScrollControlled: true,
                                //     //   context: context,
                                //     //   useRootNavigator: true,
                                //     //   builder: (context) {
                                //     //     return AddressModel(
                                //     //       isSavedAddress: false,
                                //     //     );
                                //     //   },
                                //     // );
                                //     if (value != null) {
                                //       widget.notifyParent();
                                //       widget.getCurrentLocation.call();
                                //     }
                                //   },
                                //   child: Text(
                                //     "s",
                                //     style: TextStyle(
                                //       color: Colors.green,
                                //       fontSize:
                                //           SizeUtils.horizontalBlockSize * 4,
                                //       fontWeight: FontWeight.bold,
                                //     ),
                                //   ),
                                // )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Form(
                        key: _key,
                        child: TextFieldBox(
                            // upperText: "Complete Addressnj Details",
                            hintText: "Apartment / Building /House Name",
                            controller: _completeAddressController),
                      ),
                      TextFieldBox(
                        controller: _floorController,
                        hintText: "Floor (Optional)",
                        // upperText: "Floor (Optional)",
                      ),
                      // TextFieldBox(
                      //   controller: _howToReachController,
                      //   // upperText: "How to reach (Optional)",
                      //   hintText: "",
                      // ),

                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 0, vertical: 1.h),
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
                                padding: EdgeInsets.only(top: 0.7.h, left: 3.w),
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
                                          if (value == null || value.isEmpty) {
                                            return 'Enter valid details';
                                          }
                                        },
                                        style: TextStyle(
                                            fontSize:
                                                SizeUtils.horizontalBlockSize *
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
                                          focusedBorder: UnderlineInputBorder(
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
                      // TextFormField(
                      //   onChanged: (val) {
                      //     setState(() {});
                      //   },
                      //   controller: _floorController,
                      //   style: TextStyle(
                      //       fontSize: SizeUtils.horizontalBlockSize * 4.5),
                      //   decoration: InputDecoration(
                      //     contentPadding: EdgeInsets.only(
                      //         bottom: SizeUtils.horizontalBlockSize * 2,
                      //         top: SizeUtils.horizontalBlockSize * 3.82),
                      //     isDense: true,
                      //     hintText: "Floor (Optional)",
                      //     hintStyle: isDisabled.value
                      //         ? TextStyle(
                      //             color: Colors.grey.shade400,
                      //             fontSize: SizeUtils.horizontalBlockSize * 4.5)
                      //         : TextStyle(
                      //             color: Colors.grey,
                      //             fontSize: SizeUtils.horizontalBlockSize * 4.5),
                      //     enabled: !isDisabled.value,
                      //     // floatingLabelBehavior: FloatingLabelBehavior.always,
                      //     suffixIconConstraints: BoxConstraints.tightFor(),
                      //     focusedBorder: UnderlineInputBorder(
                      //       borderSide: BorderSide(color: Colors.pink),
                      //     ),
                      //     suffixIcon: _floorController.text.length > 0
                      //         ? TextFieldClearButton(
                      //             onTap: () {
                      //               _floorController.clear();
                      //               setState(() {});
                      //             },
                      //           )
                      //         : null,
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 1.h,
                      // ),
                      // TextFormField(
                      //   controller: _howToReachController,
                      //   onChanged: (val) {
                      //     setState(() {});
                      //   },
                      //   style: TextStyle(
                      //       fontSize: SizeUtils.horizontalBlockSize * 4.5),
                      //   decoration: InputDecoration(
                      //     isDense: true,
                      //     hintText: "How to reach (Optional)",
                      //     hintStyle: isDisabled.value
                      //         ? TextStyle(
                      //             color: Colors.grey.shade400,
                      //             fontSize: SizeUtils.horizontalBlockSize * 4.5,
                      //           )
                      //         : TextStyle(
                      //             color: Colors.grey,
                      //             fontSize: SizeUtils.horizontalBlockSize * 4.5,
                      //           ),
                      //     enabled: !isDisabled.value,
                      //     // floatingLabelBehavior: FloatingLabelBehavior.always,
                      //     suffixIconConstraints: BoxConstraints.tightFor(),
                      //     focusedBorder: UnderlineInputBorder(
                      //       borderSide: BorderSide(color: Colors.pink),
                      //     ),
                      //     suffixIcon: _howToReachController.text.length > 0
                      //         ? TextFieldClearButton(
                      //             onTap: () {
                      //               _howToReachController.clear();
                      //               setState(() {});
                      //             },
                      //           )
                      //         : null,
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 2.h,
                      // ),
                      // Text(
                      //   "Tag this location for later",
                      //   style: TextStyle(
                      //     color: Colors.grey,
                      //     fontSize: SizeUtils.horizontalBlockSize * 4,
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 1.h,
                      // ),
                      Padding(
                        padding: EdgeInsets.only(left: 2.w),
                        child: Text(
                          "Save this address as:",
                          style: TextStyle(
                            color: AppConst.black,
                            fontSize: SizeUtils.horizontalBlockSize * 4,
                            fontWeight: FontWeight.w500,
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
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 7.h,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              primary: isDisabled.value
                                  ? AppConst.darkGrey
                                  : AppConst.kSecondaryColor,
                              padding: EdgeInsets.all(
                                  SizeUtils.horizontalBlockSize * 3),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    SizeUtils.horizontalBlockSize * 3),
                              ),
                            ),
                            onPressed: (_completeAddressController
                                    .value.text.isNotEmpty)
                                ? () async {
                                    _addLocationController
                                        .bottomFullAddressLoading.value = true;

                                    try {
                                      if (!isDisabled.value &&
                                          (_key.currentState?.validate() ??
                                              false)) {
                                        if (_addLocationController
                                                .storesCount.value !=
                                            _addLocationController
                                                .updatedStoresCount.value) {
                                          print("====>Changes");

                                          /// Changes
                                          await _addLocationController
                                              .addMultipleStoreToWallet();
                                        } else {
                                          print("====> No Changes");

                                          /// No Changes
                                          await _addLocationController
                                              .addMultipleStoreToWallet();
                                        }
                                        await _addLocationController
                                            .addCustomerAddress(
                                          lng: _addLocationController
                                                  .middlePointOfScreenOnMap
                                                  ?.longitude ??
                                              0,
                                          lat: _addLocationController
                                                  .middlePointOfScreenOnMap
                                                  ?.latitude ??
                                              0,
                                          address:
                                              _completeAddressController.text,
                                          title: _tags[_selectedTag],
                                          house: _floorController.text,
                                          apartment: '',
                                          directionToReach:
                                              _howToReachController.text,
                                        );
                                        _addLocationController
                                            .bottomFullAddressLoading
                                            .value = false;
                                      }
                                    } catch (e) {
                                      _addLocationController
                                          .bottomFullAddressLoading
                                          .value = false;
                                    }
                                    _addLocationController.isLoading.value =
                                        false;
                                  }
                                : null,
                            child: Text(
                              "Confirm location",
                              style: TextStyle(
                                fontSize: SizeUtils.horizontalBlockSize * 5,
                                fontWeight: FontWeight.bold,
                                color: isDisabled.value
                                    ? AppConst.darkGrey
                                    : AppConst.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Padding TextFieldBox(
      {required TextEditingController? controller,
      // required String? upperText,
      required String? hintText}) {
    return Padding(
      padding: EdgeInsets.only(top: 3.h),
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
}
