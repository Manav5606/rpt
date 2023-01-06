import 'package:customer_app/constants/assets_constants.dart';
import 'package:customer_app/screens/addcart/controller/addcart_controller.dart';
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
  String page;

  BottomFullAddressSheet(
      {Key? key,
      required this.address,
      required this.notifyParent,
      required this.getCurrentLocation,
      required this.storesCount,
      required this.cashBackCount,
      required this.isFullAddesss,
      required this.page})
      : super(key: key);

  @override
  State<BottomFullAddressSheet> createState() => _BottomFullAddressSheetState();
}

class _BottomFullAddressSheetState extends State<BottomFullAddressSheet> {
  final TextEditingController _completeAddressController =
      TextEditingController();
  final TextEditingController _floorController = TextEditingController();
  final TextEditingController _howToReachController = TextEditingController();
  final TextEditingController _otherController = TextEditingController();
  RxBool isDisabled = false.obs;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final AddLocationController _addLocationController = Get.find();
  final AddCartController _addCartController = Get.put(AddCartController());

  @override
  void initState() {
    if (widget.storesCount == 0) {
      isDisabled.value = false;
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _completeAddressController.dispose();
    _floorController.dispose();
    _howToReachController.dispose();
    _otherController.dispose();
  }

  List<String> _tags = ["Home", "Work", "Hotel", "Other"];
  int _selectedTag = 0;

  Widget _buildTags(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          // if (!isDisabled.value) {
          _selectedTag = index;
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

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: AppConst.white,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          (widget.storesCount != 0)
              ? InkWell(
                  onTap: () async {
                    await _addLocationController.getClaimRewardsPageData();
                    Get.toNamed(AppRoutes.WalletOffer);
                  },
                  child: Container(
                    height: 8.h,
                    decoration: BoxDecoration(color: Color(0xfff0e6fa)),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 3.w,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                    "\u{20B9}${widget.cashBackCount} Cashback. Want to know?",
                                    style: TextStyle(
                                      fontFamily: 'MuseoSans',
                                      color: Color(0xff2b0064),
                                      fontSize:
                                          SizeUtils.horizontalBlockSize * 4,
                                      fontWeight: FontWeight.w700,
                                      fontStyle: FontStyle.normal,
                                    )),
                                RichText(
                                    text: TextSpan(children: [
                                  TextSpan(
                                      text:
                                          "Earn \u{20B9}${widget.cashBackCount} from the ",
                                      style: TextStyle(
                                        fontFamily: 'MuseoSans',
                                        color: Color(0xff2b0064),
                                        fontSize:
                                            SizeUtils.horizontalBlockSize * 3.2,
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FontStyle.normal,
                                      )),
                                  TextSpan(
                                      text: "${widget.storesCount} Stores",
                                      style: TextStyle(
                                        fontFamily: 'MuseoSans',
                                        color: Color(0xff2b0064),
                                        fontSize:
                                            SizeUtils.horizontalBlockSize * 3.2,
                                        fontWeight: FontWeight.w700,
                                        fontStyle: FontStyle.normal,
                                      )),
                                  TextSpan(
                                      text: " near your location",
                                      style: TextStyle(
                                        fontFamily: 'MuseoSans',
                                        color: Color(0xff2b0064),
                                        fontSize:
                                            SizeUtils.horizontalBlockSize * 3.2,
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FontStyle.normal,
                                      )),
                                ]))
                              ],
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward,
                            size: 3.h,
                            color: Color(0xff2b0064),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              : SizedBox(),
          SizedBox(
            height: (widget.storesCount != 0) ? 20.h : 28.h,
          ),
          Container(
            color: AppConst.white,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // SizedBox(
                  //   height: 2.h,
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   children: [
                  //     IconButton(
                  //         iconSize: SizeUtils.horizontalBlockSize * 6.33,
                  //         padding: EdgeInsets.zero,
                  //         splashRadius: 25,
                  //         visualDensity: VisualDensity(horizontal: -4),
                  //         onPressed: () {
                  //           widget.notifyParent();
                  //         },
                  //         icon: Icon(Icons.arrow_back)),
                  //     SizedBox(
                  //       width: 3.w,
                  //     ),
                  //     Text(
                  //       "Confirm Location",
                  //       style: TextStyle(
                  //         fontSize: SizeUtils.horizontalBlockSize * 5,
                  //         fontWeight: FontWeight.bold,
                  //         // color: Colors.green
                  //       ),
                  //     ),
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
                  //   ],
                  // ),

                  // SizedBox(
                  //   height: 1.h,
                  // ),
                  // Padding(
                  //   padding: EdgeInsets.symmetric(horizontal: 2.w),
                  //   child: InkWell(
                  //     highlightColor: AppConst.grey,
                  //     onTap: () async {
                  //       await _addLocationController.getClaimRewardsPageData();
                  //       Get.toNamed(AppRoutes.WalletOffer);
                  //     },
                  //     child: Container(
                  //       height: 26.h,
                  //       width: MediaQuery.of(context).size.width,
                  //       decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(10),
                  //           color: AppConst.lightYellow
                  //           // gradient: LinearGradient(
                  //           //     begin: Alignment.topCenter,
                  //           //     end: Alignment.bottomCenter,
                  //           //     colors: [
                  //           //       Color(0xff2b0061),
                  //           //       Color(0xff6b2bc4),
                  //           //       Color(0xff843deb),
                  //           //       Color(0xff9146ff)
                  //           //     ]),
                  //           ),
                  //       child: Padding(
                  //         padding:
                  //             EdgeInsets.only(left: 3.w, top: 2.h, bottom: 1.h),
                  //         child: Column(
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: [
                  //             Row(
                  //               children: [
                  //                 Text(
                  //                   "Edit Stores near you",
                  //                   //  ${widget.storesCount}
                  //                   overflow: TextOverflow.ellipsis,
                  //                   style: TextStyle(
                  //                       fontSize:
                  //                           SizeUtils.horizontalBlockSize * 5,
                  //                       fontWeight: FontWeight.w600,
                  //                       color: Colors.black),
                  //                 ),
                  //                 Spacer(),
                  //                 Icon(
                  //                   Icons.arrow_forward_ios,
                  //                   size: 2.7.h,
                  //                   color: AppConst.black,
                  //                 ),
                  //                 SizedBox(
                  //                   width: 3.w,
                  //                 )
                  //               ],
                  //             ),
                  //             SizedBox(
                  //               height: 1.h,
                  //             ),
                  //             Container(
                  //               width: 80.w,
                  //               child: Text(
                  //                 "These are the stores with cashback available near you ",
                  //                 // ${widget.cashBackCount}
                  //                 maxLines: 2,
                  //                 style: TextStyle(
                  //                     fontSize:
                  //                         SizeUtils.horizontalBlockSize * 3.7,
                  //                     fontWeight: FontWeight.w500,
                  //                     color: AppConst.black),
                  //               ),
                  //             ),
                  //             SizedBox(
                  //               height: 2.h,
                  //             ),

                  //             Row(
                  //               children: [
                  //                 Container(
                  //                     height: 5.h,
                  //                     width: 12.w,
                  //                     child: FittedBox(
                  //                         child: Icon(
                  //                       Icons.storefront,
                  //                     )
                  //                         //  Image.asset(
                  //                         //   "assets/icons/storelogo.png",
                  //                         //   fit: BoxFit.fill,
                  //                         // ),
                  //                         )),
                  //                 SizedBox(
                  //                   width: 2.w,
                  //                 ),
                  //                 Text(
                  //                   "${widget.storesCount}",
                  //                   overflow: TextOverflow.ellipsis,
                  //                   style: TextStyle(
                  //                       fontSize:
                  //                           SizeUtils.horizontalBlockSize * 5.4,
                  //                       fontWeight: FontWeight.w600,
                  //                       color: Colors.black),
                  //                 ),
                  //               ],
                  //             ),
                  //             SizedBox(
                  //               height: 1.h,
                  //             ),
                  //             RichText(
                  //                 text: TextSpan(
                  //                     text: "You Saved   ",
                  //                     style: TextStyle(
                  //                         fontSize:
                  //                             SizeUtils.horizontalBlockSize *
                  //                                 4.8,
                  //                         fontWeight: FontWeight.w600,
                  //                         color: Colors.black),
                  //                     children: [
                  //                   TextSpan(
                  //                       text:
                  //                           "\u{20B9} ${widget.cashBackCount}",
                  //                       style: TextStyle(
                  //                           fontWeight: FontWeight.bold,
                  //                           fontSize:
                  //                               SizeUtils.horizontalBlockSize *
                  //                                   5))
                  //                 ])),
                  //             //  Text(
                  //             //       "You Saved ",
                  //             //       overflow: TextOverflow.ellipsis,
                  //             //       style: TextStyle(
                  //             //           fontSize:
                  //             //               SizeUtils.horizontalBlockSize * 5.4,
                  //             //           fontWeight: FontWeight.w600,
                  //             //           color: Colors.white),
                  //             //     ),
                  //             // FittedBox(
                  //             //   child: SizedBox(
                  //             //     height: 3.5.h,
                  //             //     child: ElevatedButton(
                  //             //       child: Text(
                  //             //         'Edit',
                  //             //         style: TextStyle(
                  //             //             fontSize:
                  //             //                 SizeUtils.horizontalBlockSize * 3.5,
                  //             //             color: AppConst.black,
                  //             //             fontWeight: FontWeight.bold),
                  //             //       ),
                  //             //       onPressed: () async {
                  //             //         await _addLocationController
                  //             //             .getClaimRewardsPageData();
                  //             //         Get.toNamed(AppRoutes.WalletOffer);
                  //             //       },
                  //             //       style: ElevatedButton.styleFrom(
                  //             //           primary: AppConst.orange,
                  //             //           shape: RoundedRectangleBorder(
                  //             //               borderRadius:
                  //             //                   BorderRadius.circular(15))),
                  //             //     ),
                  //             //   ),
                  //             // ),
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),

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
                                child: Text(
                                  _addLocationController.SortByCharactor(
                                      widget.address.toString(), ","),
                                  // parts[0],
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                    color: AppConst.black,
                                    fontFamily: 'MuseoSans',
                                    fontWeight: FontWeight.w700,
                                    fontStyle: FontStyle.normal,
                                    fontSize:
                                        SizeUtils.horizontalBlockSize * 4.2,
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
                              child: Text(
                                widget.address,
                                maxLines: 1,
                                overflow: TextOverflow.visible,
                                style: TextStyle(
                                  fontFamily: 'MuseoSans',
                                  fontWeight: FontWeight.w300,
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
                        padding:
                            EdgeInsets.only(left: 2.w, bottom: 2.h, top: 1.h),
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
                                            bottom:
                                                SizeUtils.horizontalBlockSize *
                                                    2,
                                            top: SizeUtils.horizontalBlockSize *
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

                  SizedBox(
                    height: 1.h,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 6.h,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              primary: (_completeAddressController
                                      .value.text.isNotEmpty)
                                  ? AppConst.darkGreen
                                  : AppConst.darkGrey,
                              padding: EdgeInsets.all(3.w),
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
                                      if (widget.storesCount != 0 &&
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
                                                address: widget.address,
                                                title:
                                                    "${_selectedTag == 3 ? "${_otherController.text}" : "${_tags[_selectedTag]}"}",
                                                house: _floorController.text,
                                                apartment:
                                                    _completeAddressController
                                                        .text,
                                                directionToReach:
                                                    _howToReachController.text,
                                                page: widget.page);

                                        _addLocationController
                                            .userAddress.value = widget.address;

                                        _addLocationController
                                                .userAddressTitle.value =
                                            "${_selectedTag == 3 ? _otherController.text : "${_tags[_selectedTag]}"}";

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

                                        if (widget.page == "review") {
                                          await _addCartController
                                              .getCartLocation(
                                                  storeId: _addCartController
                                                          .store.value?.sId ??
                                                      "",
                                                  cartId: _addCartController
                                                      .cartId.value);

                                          _addCartController
                                              .SelectedAddressForCart();
                                        }

                                        _addLocationController
                                            .bottomFullAddressLoading
                                            .value = false;
                                      } else {
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
                                                address: widget.address,
                                                title:
                                                    "${_tags[_selectedTag]}${_selectedTag == 3 ? "${_otherController.text}" : ""}",
                                                house: _floorController.text,
                                                apartment:
                                                    _completeAddressController
                                                        .text,
                                                directionToReach:
                                                    _howToReachController.text,
                                                page: widget.page);

                                        _addLocationController
                                            .userAddress.value = widget.address;
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

                                        if (widget.page == "review") {
                                          await _addCartController
                                              .getCartLocation(
                                                  storeId: _addCartController
                                                          .store.value?.sId ??
                                                      "",
                                                  cartId: _addCartController
                                                      .cartId.value);

                                          _addCartController
                                              .SelectedAddressForCart();
                                        }

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
                  SizedBox(
                    height: 2.h,
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
}
