import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:customer_app/app/ui/common/shimmer_widget.dart';
import 'package:customer_app/screens/root/network_check.dart';
import 'package:customer_app/widgets/signup_feilds.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/app/data/provider/hive/hive.dart';
import 'package:customer_app/app/data/provider/hive/hive_constants.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:get/get.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:sizer/sizer.dart';
import '../../../controller/signInScreenController.dart';

class SignInScreen extends StatefulWidget {
  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final SignInScreenController _signInController = Get.find();

// int CurrentIndex = 0;
// late PageController _controller;
// StreamSubscription? _sub;
//   Future<void> initUniLinks() async {
// // check initialLink
// // Attach a listener to the stream
//     _sub = linkStream.listen((String? link) {
// // Parse the link and warn the user, if it is not correct
//       if (link != null) {
//         print('listener is working');
//       } else {
//         print("nolinks");
//       }
//     }, onError: (err) {
// // Handle exception by warning the user their action did not succeed
//     });
// // NOTE: Don't forget to call _sub.cancel() in dispose()
//   }

  @override
  void initState() {
    // initUniLinks();
    print("object");
    // _controller = PageController(initialPage: 0);
    // Timer.periodic(Duration(seconds: 3), (Timer timer) {
    //   if (CurrentIndex < 3) {
    //     _controller.animateToPage(
    //       CurrentIndex,
    //       duration: Duration(milliseconds: 500),
    //       curve: Curves.easeIn,
    //     );
    //     CurrentIndex++;
    //   } else {
    //     CurrentIndex = 3;
    //   }
    //   // super.initState();
    // });
  }

  @override
  void dispose() {
    // _controller.dispose();
    super.dispose();
  }

  final FocusNode _nodeText1 = FocusNode();

  KeyboardActionsConfig _buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
        keyboardActionsPlatform: KeyboardActionsPlatform.IOS,
        keyboardBarColor: Colors.grey[200],
        nextFocus: false,
        actions: [
          KeyboardActionsItem(
            focusNode: _nodeText1,
            toolbarButtons: [
              (node) {
                return GestureDetector(
                  onTap: () => node.unfocus(),
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: AppConst.grey,
                    ),
                    margin: const EdgeInsets.only(right: 4),
                    child: Text(
                      "DONE",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              }
            ],
          ),
        ]);
  }

  @override
  Widget build(BuildContext context) {
    // var currentTabs = [
    //   DisplayAppInfo(
    //       context,
    //       "assets/images/order11.png",
    //       "Order",
    //       " from your Nearby Stores",
    //       "Order from your Nearby Stores Order from your Nearby Stores  "),
    //   DisplayAppInfo(
    //       context,
    //       "assets/images/scan22.png",
    //       "Scan",
    //       " the Receipts",
    //       "Scan the receipts after purchasing the products to get more "),
    //   DisplayAppInfo(
    //       context,
    //       "assets/images/cashback33.png",
    //       "Earn",
    //       " Cashbacks from the Store",
    //       "Get Cashback instantly to your E-Wallet "),
    //   DisplayAppInfo(
    //       context,
    //       "assets/images/redeem44.png",
    //       "Redeem",
    //       " in your next purchase",
    //       " Use your E-Wallet in your next purchase get more Rewards")
    // ];
    Connectivity connectivity = Connectivity();
    SizeUtils().init(context);
    final box = Boxes.getCommonBox();
    final flag = box.get(HiveConstants.REFERID);
    if (flag?.isNotEmpty ?? false) {
      _signInController.referralController.text = flag ?? '';
      _signInController.referral.value = flag ?? '';
    }
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
          statusBarColor: AppConst.transparent,
          statusBarIconBrightness: Brightness.light),
      child: Scaffold(
        backgroundColor: Color(0xff0a3453),
        // resizeToAvoidBottomInset: false,

        bottomSheet: Obx(
          () => _signInController.isLoading.value
              ? SignInBottomShimmer(
                  signInController: _signInController, nodeText1: _nodeText1)
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    StreamBuilder<ConnectivityResult>(
                      stream: connectivity.onConnectivityChanged,
                      builder: (_, snapshot) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 1.h),
                          child: CheckInternetConnectionWidget(
                              snapshot: snapshot,
                              showsnankbar: true,
                              widget: SizedBox()),
                        );
                      },
                    ),
                    Container(
                      height: 24.h,
                      decoration: BoxDecoration(
                          color: AppConst.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(24),
                              topRight: Radius.circular(24))),
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 4.w,
                          right: 4.w,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Sign in",
                              style: TextStyle(
                                color: AppConst.black,
                                fontFamily: "MuseoSans",
                                fontStyle: FontStyle.normal,
                                fontSize: SizeUtils.horizontalBlockSize * 4.2,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Text(
                              "Enter your Mobile Number",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: AppConst.darkGrey,
                                fontFamily: "MuseoSans",
                                fontStyle: FontStyle.normal,
                                fontSize: SizeUtils.horizontalBlockSize * 3.5,
                              ),
                            ),
                            Container(
                              // height: 6.h,
                              color: AppConst.white,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 2.w, vertical: 1.h),

                              child: KeyboardActions(
                                config: _buildConfig(context),
                                autoScroll: false,
                                disableScroll: true,
                                child: Container(
                                  // height: 50,
                                  child: TextFormField(
                                    style: TextStyle(
                                        fontFamily: 'MuseoSans',
                                        color: AppConst.black,
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FontStyle.normal,
                                        fontSize:
                                            SizeUtils.horizontalBlockSize * 4),
                                    textAlignVertical: TextAlignVertical.center,
                                    focusNode: _nodeText1,
                                    textAlign: TextAlign.start,
                                    cursorColor: AppConst.black,
                                    maxLength: 10,
                                    keyboardType: TextInputType.number,
                                    controller:
                                        _signInController.phoneNumberController,
                                    onChanged: (value) {
                                      _signInController.phoneNumber.value =
                                          value;
                                    },
                                    decoration: InputDecoration(
                                      isDense: true,

                                      hintStyle: TextStyle(
                                          color: AppConst.grey,
                                          fontSize:
                                              SizeUtils.horizontalBlockSize *
                                                  4),
                                      // contentPadding:
                                      //     EdgeInsets.only(left: 2.w, bottom: 0.h),
                                      hintTextDirection: TextDirection.ltr,
                                      counterText: "",

                                      prefixIcon: AddPlus91(
                                          signInController: _signInController),
                                      suffixIconConstraints:
                                          BoxConstraints.tightFor(),
                                      disabledBorder: InputBorder.none,
                                      border: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppConst.grey, width: 1),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppConst.green, width: 1.5),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Obx(
                              () => GestureDetector(
                                  onTap: () async {
                                    var isAvialble =
                                        connectivity.checkConnectivity();
                                    if (true) {
                                      if (_signInController
                                                  .phoneNumber.value.length ==
                                              10 &&
                                          _signInController.phoneNumber.value
                                              .isPhoneNumber) {
                                        await _signInController
                                            .submitPhoneNumber();
                                      } else {
                                        Get.showSnackbar(GetSnackBar(
                                          backgroundColor: AppConst.black,
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 12),
                                          snackStyle: SnackStyle.FLOATING,
                                          borderRadius: 12,
                                          duration: Duration(seconds: 2),
                                          message:
                                              "Please Enter the vaild number!",
                                          // title: "Amount must be at least \u{20b9}1"
                                        ));
                                      }
                                    }
                                  },
                                  child: BottomWideButton(
                                    text: "Sign in",
                                    color: _signInController
                                                .phoneNumber.value.length ==
                                            10
                                        ? AppConst.green
                                        : AppConst.green.withOpacity(0.8),
                                    borderColor: _signInController
                                                .phoneNumber.value.length ==
                                            10
                                        ? AppConst.green
                                        : AppConst.green.withOpacity(0.8),
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
        ),
        body:

            // Obx(
            //   () => _signInController.isLoading.value
            //       ? SignInScreenShimmer()
            //       :
            SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/bglogin.png"),
                      fit: BoxFit.fill),
                ),

                height: 75.h,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                          height: 27.h,
                          child: Image(
                              image:
                                  AssetImage("assets/images/loginlogo.png"))),
                      SizedBox(
                        height: 15.h,
                      )
                    ],
                  ),
                ),
                //     child: PageView(
                //       controller: _controller,
                //       children: currentTabs,
                //       onPageChanged: (int index) {
                //         setState(() {
                //           CurrentIndex = index;
                //         });
                //       },
                //     )),
              )
            ],
          ),
        ),
      ),
    );
  }

  // Container DisplayAppInfo(BuildContext context, String image, String text1,
  //     String text2, String subtitle) {
  //   return Container(
  //     width: double.infinity,
  //     decoration: BoxDecoration(
  //       color: AppConst.white,
  //       image: DecorationImage(
  //           image: AssetImage("assets/images/BG.png"), fit: BoxFit.fill),
  //     ),
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.end,
  //       children: [
  //         SizedBox(
  //           height: 4.h,
  //         ),
  //         Bloyallogo(),
  //         SizedBox(
  //           height: 4.h,
  //         ),

  //         Container(
  //           height: 40.h,
  //           width: double.infinity,
  //           child: FittedBox(
  //             child: Center(
  //                 child: Image.asset(
  //               image,
  //               // "assets/images/order1.png",
  //             )),
  //           ),
  //         ),

  //         // SizedBox(),
  //         Container(
  //           height: 15.h,
  //           width: double.infinity,
  //           color: AppConst.white,
  //           child: Padding(
  //             padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
  //             child: Column(
  //               children: [
  //                 SizedBox(
  //                   height: 2.h,
  //                 ),
  //                 RichText(
  //                     text: TextSpan(children: [
  //                   TextSpan(
  //                     style: TextStyle(
  //                         color: AppConst.green,
  //                         fontWeight: FontWeight.w700,
  //                         fontFamily: "MuseoSans",
  //                         fontStyle: FontStyle.normal,
  //                         fontSize: 20),
  //                     text: text1,
  //                     // "Order "
  //                   ),
  //                   TextSpan(
  //                       style: TextStyle(
  //                           color: AppConst.black,
  //                           fontWeight: FontWeight.w700,
  //                           fontFamily: "MuseoSans",
  //                           fontStyle: FontStyle.normal,
  //                           fontSize: 20.0),
  //                       text: text2
  //                       // " from your Nearby Stores"
  //                       )
  //                 ])),
  //                 SizedBox(
  //                   height: 2.h,
  //                 ),
  //                 Text(subtitle,
  //                     // "Order from your Nearby Stores Order from your Nearby Stores  ",
  //                     style: TextStyle(
  //                         color: AppConst.black,
  //                         fontWeight: FontWeight.w500,
  //                         fontFamily: "MuseoSans",
  //                         fontStyle: FontStyle.normal,
  //                         fontSize: SizeUtils.horizontalBlockSize * 3.8),
  //                     textAlign: TextAlign.center),
  //               ],
  //             ),
  //           ),
  //         ),

  //         // Container(
  //         //   color: AppConst.white,
  //         //   child: Row(
  //         //     crossAxisAlignment: CrossAxisAlignment.center,
  //         //     mainAxisAlignment: MainAxisAlignment.spaceAround,
  //         //     children: [
  //         // Container(
  //         //   child: Row(
  //         //     mainAxisAlignment: MainAxisAlignment.center,
  //         //     children:
  //         //         List.generate(4, (index) => buildDot(index, context)),
  //         //   ),
  //         // ),
  //         // CurrentIndex > 0
  //         //     ? GestureDetector(
  //         //         onTap: () {
  //         //           if (CurrentIndex == 4) {}
  //         //           _controller.previousPage(
  //         //               duration: Duration(
  //         //                   milliseconds:
  //         //                       100),
  //         //               curve:
  //         //                   Curves.bounceIn);
  //         //         },
  //         //         child: Icon(
  //         //           Icons.arrow_back,
  //         //           size: 3.2.h,
  //         //         ),
  //         //       )
  //         //     : Container(
  //         //         child: SizedBox(
  //         //         width: 5.w,
  //         //       )),
  //         // Container(
  //         //   child: Row(
  //         //     mainAxisAlignment:
  //         //         MainAxisAlignment.center,
  //         //     children: List.generate(
  //         //         4,
  //         //         (index) => buildDot(
  //         //             index, context)),
  //         //   ),
  //         // ),
  //         // CurrentIndex < 3
  //         //     ? GestureDetector(
  //         //         onTap: () {
  //         //           if (CurrentIndex == 4) {}
  //         //           _controller.nextPage(
  //         //               duration: Duration(
  //         //                   milliseconds:
  //         //                       100),
  //         //               curve:
  //         //                   Curves.bounceIn);
  //         //         },
  //         //         child: Icon(
  //         //           Icons.arrow_forward,
  //         //           size: 3.2.h,
  //         //         ),
  //         //       )
  //         //     : Container(
  //         //         child: SizedBox(
  //         //         width: 5.w,
  //         //       )),
  //         //     ],
  //         //   ),
  //         // ),
  //       ],
  //     ),
  //   );
  // }

  // Container buildDot(int index, BuildContext context) {
  //   return Container(
  //     height: 10,
  //     width: 10,
  //     // CurrentIndex == index ? 25 : 10,
  //     margin: EdgeInsets.only(right: 2.w),
  //     decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(20),
  //         color: CurrentIndex == index ? AppConst.darkGreen : AppConst.lightGrey
  //         // Colors.green
  //         // kSecondaryColor
  //         ),
  //   );
  // }
}

class SignInBottomShimmer extends StatelessWidget {
  const SignInBottomShimmer({
    Key? key,
    required SignInScreenController signInController,
    required FocusNode nodeText1,
  })  : _signInController = signInController,
        _nodeText1 = nodeText1,
        super(key: key);

  final SignInScreenController _signInController;
  final FocusNode _nodeText1;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24.h,
      decoration: BoxDecoration(
          color: AppConst.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24), topRight: Radius.circular(24))),
      child: Padding(
        padding: EdgeInsets.only(
          left: 4.w,
          right: 4.w,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ShimmerEffect(
            // child:
            Text(
              "Sign in",
              style: TextStyle(
                color: AppConst.grey,
                fontFamily: "MuseoSans",
                fontStyle: FontStyle.normal,
                fontSize: SizeUtils.horizontalBlockSize * 4.2,
                fontWeight: FontWeight.bold,
              ),
            ),
            // ),
            SizedBox(
              height: 1.h,
            ),
            // ShimmerEffect(
            // child:
            ShimmerEffect(
              child: Text(
                "Enter your Mobile Number",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: AppConst.darkGrey,
                  fontFamily: "MuseoSans",
                  fontStyle: FontStyle.normal,
                  fontSize: SizeUtils.horizontalBlockSize * 3.5,
                ),
                // ),
              ),
            ),
            Container(
              color: AppConst.white,
              padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
              child: ShimmerEffect(
                child: TextFormField(
                  textAlignVertical: TextAlignVertical.center,
                  controller: _signInController.phoneNumberController,
                  focusNode: _nodeText1,
                  textAlign: TextAlign.start,
                  cursorColor: AppConst.black,
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    isDense: true,

                    hintStyle: TextStyle(
                        color: AppConst.grey,
                        fontSize: SizeUtils.horizontalBlockSize * 4),
                    // contentPadding:
                    //     EdgeInsets.only(left: 2.w, bottom: 0.h),
                    hintTextDirection: TextDirection.ltr,
                    counterText: "",

                    prefixIcon: AddPlus91(signInController: _signInController),
                    suffixIconConstraints: BoxConstraints.tightFor(),
                    disabledBorder: InputBorder.none,
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppConst.grey, width: 1),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppConst.grey, width: 1.5),
                    ),
                  ),
                ),
              ),
            ),
            ShimmerEffect(
              child: BottomWideButton(
                text: "Sign in",
                color: _signInController.phoneNumber.value.length == 10
                    ? AppConst.darkGreen
                    : AppConst.darkGreen,
                borderColor: _signInController.phoneNumber.value.length == 10
                    ? AppConst.darkGreen
                    : AppConst.darkGreen,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BottomWideButton extends StatelessWidget {
  final Color color;
  final Color Textcolor;
  final Color borderColor;
  BottomWideButton(
      {Key? key,
      this.text,
      this.borderColor = AppConst.darkGreen,
      this.color = AppConst.darkGreen,
      this.Textcolor = AppConst.white})
      : super(key: key);
  String? text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 1.h),
      height: 6.h,
      decoration: BoxDecoration(
          color: color,
          border: Border.all(width: 1.5, color: borderColor),
          borderRadius: BorderRadius.circular(10)),
      child: Center(
        child: Text(
          text ?? "LOGIN",
          style: TextStyle(
            fontFamily: 'MuseoSans',
            fontWeight: FontWeight.w600,
            fontStyle: FontStyle.normal,
            fontSize: SizeUtils.horizontalBlockSize * 4,
            color: Textcolor,
          ),
        ),
      ),
    );
  }
}

// class EnterNumberScreen extends StatelessWidget {
//   final SignInScreenController _signInController = Get.find();

//   EnterNumberScreen({Key? key}) : super(key: key);

//   final FocusNode _nodeText1 = FocusNode();

//   KeyboardActionsConfig _buildConfig(BuildContext context) {
//     return KeyboardActionsConfig(
//         keyboardActionsPlatform: KeyboardActionsPlatform.IOS,
//         keyboardBarColor: Colors.grey[200],
//         nextFocus: false,
//         actions: [
//           KeyboardActionsItem(
//             focusNode: _nodeText1,
//             toolbarButtons: [
//               (node) {
//                 return GestureDetector(
//                   onTap: () => node.unfocus(),
//                   child: Container(
//                     padding: EdgeInsets.all(8.0),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(4),
//                       color: AppConst.grey,
//                     ),
//                     margin: const EdgeInsets.only(right: 4),
//                     child: Text(
//                       "DONE",
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                 );
//               }
//             ],
//           ),
//         ]);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final box = Boxes.getCommonBox();
//     final flag = box.get(HiveConstants.REFERID);
//     if (flag?.isNotEmpty ?? false) {
//       _signInController.referralController.text = flag ?? '';
//       _signInController.referral.value = flag ?? '';
//     }
//     return AnnotatedRegion<SystemUiOverlayStyle>(
//       value: SystemUiOverlayStyle(
//           statusBarColor: AppConst.transparent,
//           statusBarIconBrightness: Brightness.dark),
//       child: Scaffold(
//         // appBar: AppBar(
//         //   elevation: 0,
//         //   automaticallyImplyLeading: false,
//         //   title: Bloyallogo(),
//         //   centerTitle: true,
//         //   // actions: [
//         // Bloyallogo(),
//         //   // ],
//         // ),

//         body: Obx(
//           () => _signInController.isLoading.value
//               ? SignInShimmerEffect()
//               : SingleChildScrollView(
//                   child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Container(
//                             height: 70.h,
//                             width: double.infinity,
//                             decoration: BoxDecoration(
//                               color: AppConst.white,
//                               image: DecorationImage(
//                                   image: AssetImage("assets/images/BG.png"),
//                                   fit: BoxFit.fill),
//                             ),
//                             child: FittedBox(
//                               child: Center(
//                                   child: Image.asset(
//                                 "assets/images/order1.png",
//                                 fit: BoxFit.contain,
//                               )),
//                             )),
//                         // Row(
//                         //   mainAxisAlignment: MainAxisAlignment.center,
//                         //   children: [
//                         //     // BackButton(
//                         //     //   color: AppConst.black,
//                         //     //   onPressed: () {
//                         //     //     Get.back();
//                         //     //   },
//                         //     // ),
//                         //     Bloyallogo(),
//                         //     // SizedBox(
//                         //     //   width: 10.w,
//                         //     // )
//                         //   ],
//                         // ),
//                         // SizedBox(
//                         //   height: 5.h,
//                         // ),

//                         Padding(
//                           padding:
//                               EdgeInsets.only(left: 4.w, right: 4.w, top: 6.h),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 "Sign in",
//                                 style: TextStyle(
//                                   color: AppConst.black,
//                                   fontFamily: "MuseoSans",
//                                   fontStyle: FontStyle.normal,
//                                   fontSize: SizeUtils.horizontalBlockSize * 4.5,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               SizedBox(
//                                 height: 1.h,
//                               ),
//                               Text(
//                                 "Enter your Mobile Number",
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.w500,
//                                   color: AppConst.grey,
//                                   fontFamily: "MuseoSans",
//                                   fontStyle: FontStyle.normal,
//                                   fontSize: SizeUtils.horizontalBlockSize * 3.5,
//                                 ),
//                               ),
//                               Container(
//                                 // height: 6.h,
//                                 child: KeyboardActions(
//                                   config: _buildConfig(context),
//                                   autoScroll: false,
//                                   disableScroll: true,
//                                   child: Container(
//                                     // height: 50,
//                                     child: SignUpFeilds(
//                                       prefixIcon: AddPlus91(
//                                           signInController: _signInController),
//                                       focusNode: _nodeText1,
//                                       hinttext: "",
//                                       keyboardtype: TextInputType.number,
//                                       maxlength: 10,
//                                       controller: _signInController
//                                           .phoneNumberController,
//                                       onChange: (value) {
//                                         _signInController.phoneNumber.value =
//                                             value;
//                                       },
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               Obx(
//                                 () => GestureDetector(
//                                     onTap: () async {
//                                       if (_signInController
//                                                   .phoneNumber.value.length ==
//                                               10 &&
//                                           _signInController.phoneNumber.value
//                                               .isPhoneNumber) {
//                                         await _signInController
//                                             .submitPhoneNumber();
//                                       } else {
//                                         Get.showSnackbar(GetSnackBar(
//                                           backgroundColor: AppConst.black,
//                                           margin: EdgeInsets.symmetric(
//                                               horizontal: 10, vertical: 12),
//                                           snackStyle: SnackStyle.FLOATING,
//                                           borderRadius: 12,
//                                           duration: Duration(seconds: 2),
//                                           message:
//                                               "Please Enter the vaild number!",
//                                           // title: "Amount must be at least \u{20b9}1"
//                                         ));
//                                       }
//                                     },

//                                     // ? () {
//                                     //     log("aavoooo :0");
//                                     //     try {
//                                     //       _signInController
//                                     //           .submitPhoneNumber();
//                                     //     } catch (e) {
//                                     //       print(e);
//                                     //     }
//                                     //     log("aavoooo :1");
//                                     //   }
//                                     // : () {
//                                     // ScaffoldMessenger.of(Get.context!)
//                                     //     .showSnackBar(SnackBar(
//                                     //         content: Text(
//                                     //             "Invalid OTP : Please Enter Valid OTP")));
//                                     //   },
//                                     child: BottomWideButton(
//                                       text: "Sign in",
//                                       color: _signInController
//                                                   .phoneNumber.value.length ==
//                                               10
//                                           ? AppConst.darkGreen
//                                           : AppConst.grey,
//                                       borderColor: _signInController
//                                                   .phoneNumber.value.length ==
//                                               10
//                                           ? AppConst.darkGreen
//                                           : AppConst.grey,
//                                     )),
//                               ),
//                             ],
//                           ),
//                         ),
//                         // SizedBox(
//                         //   height: 27.h,
//                         // ),
//                         // Container(
//                         //   width: MediaQuery.of(context).size.width,
//                         //   // height: 9.h,
//                         //   decoration: BoxDecoration(
//                         //       borderRadius: BorderRadius.circular(10),
//                         //       border: Border.all(color: AppConst.black, width: 1.5)),
//                         //   child: Column(
//                         //     crossAxisAlignment: CrossAxisAlignment.start,
//                         //     children: [
//                         //       Padding(
//                         //         padding: EdgeInsets.only(
//                         //             left: 2.w, top: 0.5.h, bottom: 0.5.h),
//                         //         child: Text(
//                         //           "Mobile",
//                         //           style: TextStyle(
//                         //               fontSize: 9.sp, fontWeight: FontWeight.w500),
//                         //         ),
//                         //       ),
//                         //       TextField(
//                         //         style: TextStyle(fontSize: 14.sp),
//                         //         textAlign: TextAlign.start,
//                         //         cursorColor: AppConst.kPrimaryColor,
//                         //         maxLength: 10,
//                         //         keyboardType: TextInputType.number,
//                         //         controller: _signInController.phoneNumberController,
//                         //         decoration: InputDecoration(
//                         //           isDense: true,
//                         //           border: InputBorder.none,
//                         //           hintText: 'Enter Phone Number',
//                         //           contentPadding:
//                         //               EdgeInsets.only(left: 2.w, bottom: 1.h),
//                         //           hintTextDirection: TextDirection.ltr,
//                         //           counterText: "",
//                         //         ),
//                         // onChanged: (value) {
//                         //   _signInController.phoneNumber.value = value;
//                         // },
//                         //       ),
//                         //     ],
//                         //   ),
//                         // ),
//                         // SizedBox(
//                         //   height: 2.h,
//                         // ),
//                         // Container(
//                         //   width: MediaQuery.of(context).size.width,
//                         //   // height: 9.h,
//                         //   decoration: BoxDecoration(
//                         //       borderRadius: BorderRadius.circular(10),
//                         //       border: Border.all(color: AppConst.black, width: 1.5)),
//                         //   child: Column(
//                         //     crossAxisAlignment: CrossAxisAlignment.start,
//                         //     children: [
//                         //       Padding(
//                         //         padding: EdgeInsets.only(
//                         //             left: 2.w, top: 0.5.h, bottom: 0.5.h),
//                         //         child: Text(
//                         //           "Referral code",
//                         //           style: TextStyle(
//                         //               fontSize: 9.sp, fontWeight: FontWeight.w500),
//                         //         ),
//                         //       ),
//                         //       TextField(
//                         //         style: TextStyle(fontSize: 14.sp),
//                         //         textAlign: TextAlign.start,
//                         //         cursorColor: AppConst.kPrimaryColor,
//                         //         maxLength: 10,
//                         //         controller: _signInController.referralController,
//                         //         decoration: InputDecoration(
//                         //           isDense: true,
//                         //           border: InputBorder.none,
//                         //           hintText: 'Enter Referral code',
//                         //           contentPadding:
//                         //               EdgeInsets.only(left: 2.w, bottom: 1.h),
//                         //           hintTextDirection: TextDirection.ltr,
//                         //           counterText: "",
//                         //         ),
//                         // onChanged: (value) {
//                         //   _signInController.referral.value = value;
//                         // },
//                         //       ),
//                         //     ],
//                         //   ),
//                         // ),
//                         // SizedBox(
//                         //   height: 2.h,
//                         // ),
//                       ]),
//                 ),
//         ),
//       ),
//     );
//   }
// }

class AddPlus91 extends StatelessWidget {
  const AddPlus91({
    Key? key,
    required SignInScreenController signInController,
  })  : _signInController = signInController,
        super(key: key);

  final SignInScreenController _signInController;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20.w,
      child: Row(
        children: [
          SizedBox(
            width: 2.w,
          ),
          Icon(
            Icons.call,
            size: 3.h,
            color: _signInController.phoneNumber.value.length == 10
                ? AppConst.darkGreen
                : AppConst.grey,
          ),
          SizedBox(
            width: 3.w,
          ),
          Text(
            "+91",
            style: TextStyle(
                fontFamily: 'MuseoSans',
                color: AppConst.black,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.normal,
                fontSize: SizeUtils.horizontalBlockSize * 4),
          )
        ],
      ),
    );
  }
}

class SignInShimmerEffect extends StatelessWidget {
  final SignInScreenController _signInController = Get.find();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(
          height: 35.h,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShimmerEffect(
              child: Text(
                " Sign in ",
                style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: "MuseoSans_700.otf"),
              ),
            ),
            SizedBox(
              height: 4.h,
            ),
            ShimmerEffect(
              child: SignUpFeilds(
                hinttext: "Enter mobile number",
                keyboardtype: TextInputType.number,
                maxlength: 10,
                controller: _signInController.phoneNumberController,
                onChange: (value) {
                  _signInController.phoneNumber.value = value;
                },
              ),
            ),
          ],
        ),
        SizedBox(
          height: 27.h,
        ),
        ShimmerEffect(
          child: BottomWideButton(
            text: "Sign in",
            color: _signInController.phoneNumber.value.length == 10
                ? AppConst.kSecondaryColor
                : AppConst.grey,
          ),
        ),
      ]),
    );
  }
}
