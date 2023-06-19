// import 'package:customer_app/app/constants/responsive.dart';
// import 'package:customer_app/app/controller/signInScreenController.dart';
// import 'package:customer_app/app/data/provider/hive/hive.dart';
// import 'package:customer_app/app/data/provider/hive/hive_constants.dart';
// import 'package:customer_app/app/ui/common/shimmer_widget.dart';
// import 'package:customer_app/app/ui/pages/signIn/phone_authentication_screen.dart';
// import 'package:customer_app/app/ui/pages/signIn/phone_authentication_screen_shimmer.dart';
// import 'package:customer_app/constants/app_const.dart';
// import 'package:customer_app/constants/assets_constants.dart';
// import 'package:customer_app/widgets/signup_feilds.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:sizer/sizer.dart';

// class SignUpScreen extends StatelessWidget {
//   final SignInScreenController _signInController = Get.find();

//   SignUpScreen({Key? key}) : super(key: key);

//   final TextEditingController firstNameController = TextEditingController();
//   final TextEditingController lastNameController = TextEditingController();
//   final TextEditingController mobileNumberController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     final box = Boxes.getCommonBox();
//     final flag = box.get(HiveConstants.REFERID);
//     if (flag?.isNotEmpty ?? false) {
//       _signInController.referralController.text = flag ?? '';
//       _signInController.referral.value = flag ?? '';
//     }
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         automaticallyImplyLeading: false,
//         title: Bloyallogo(),
//         centerTitle: true,
//         // actions: [
//         //   Bloyallogo(),
//         // ],
//       ),
//       body: SingleChildScrollView(
//         child: SafeArea(
//             child: Padding(
//           padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.w),
//           child: Obx(
//             () => _signInController.isLoading.value
//                 ? SignupScreenShimmerEffect()
//                 : Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                         // Row(
//                         //   mainAxisAlignment: MainAxisAlignment.center,
//                         //   children: [
//                         //     Bloyallogo(),
//                         //   ],
//                         // ),
//                         SizedBox(
//                           height: 2.h,
//                         ),
//                         Container(
//                           height: 22.h,
//                           width: MediaQuery.of(context).size.width,
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10),
//                               color: AppConst.lightYellow
//                               // gradient: LinearGradient(
//                               //     begin: Alignment.topCenter,
//                               //     end: Alignment.bottomCenter,
//                               //     colors: [
//                               //       Color(0xff2b0061),
//                               //       Color(0xff6b2bc4),
//                               //       Color(0xff843deb),
//                               //       Color(0xff9146ff)
//                               //     ]),
//                               ),
//                           child: Padding(
//                             padding: EdgeInsets.only(
//                                 left: 3.w, top: 2.h, bottom: 1.h),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 // Row(
//                                 //   children: [
//                                 //     Text(
//                                 //       "Edit Stores near you",
//                                 //       overflow: TextOverflow.ellipsis,
//                                 //       style: TextStyle(
//                                 //           fontSize:
//                                 //               SizeUtils.horizontalBlockSize * 5,
//                                 //           fontWeight: FontWeight.w600,
//                                 //           color: Colors.black),
//                                 //     ),
//                                 //     Spacer(),
//                                 //     Icon(
//                                 //       Icons.arrow_forward_ios,
//                                 //       size: 2.7.h,
//                                 //       color: AppConst.black,
//                                 //     ),
//                                 //     SizedBox(
//                                 //       width: 3.w,
//                                 //     )
//                                 //   ],
//                                 // ),
//                                 SizedBox(
//                                   height: 1.h,
//                                 ),
//                                 Container(
//                                   width: 80.w,
//                                   child: Text(
//                                     "These are the stores with cashback available near you ",
//                                     // ${widget.cashBackCount}
//                                     maxLines: 2,
//                                     style: TextStyle(
//                                         fontSize:
//                                             SizeUtils.horizontalBlockSize * 3.7,
//                                         fontWeight: FontWeight.w500,
//                                         color: AppConst.black),
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: 3.h,
//                                 ),
//                                 Row(
//                                   children: [
//                                     Container(
//                                         height: 5.h,
//                                         width: 12.w,
//                                         child: FittedBox(
//                                             child: Icon(
//                                           Icons.storefront,
//                                         )
//                                             //  Image.asset(
//                                             //   "assets/icons/storelogo.png",
//                                             //   fit: BoxFit.fill,
//                                             // ),
//                                             )),
//                                     SizedBox(
//                                       width: 2.w,
//                                     ),
//                                     Text(
//                                       "12",
//                                       overflow: TextOverflow.ellipsis,
//                                       style: TextStyle(
//                                           fontSize:
//                                               SizeUtils.horizontalBlockSize *
//                                                   5.4,
//                                           fontWeight: FontWeight.w600,
//                                           color: Colors.black),
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(
//                                   height: 2.h,
//                                 ),
//                                 RichText(
//                                     text: TextSpan(
//                                         text: "You Saved   ",
//                                         style: TextStyle(
//                                             fontSize:
//                                                 SizeUtils.horizontalBlockSize *
//                                                     5,
//                                             fontWeight: FontWeight.w600,
//                                             color: Colors.black),
//                                         children: [
//                                       TextSpan(
//                                           text: "\u{20B9} 24",
//                                           style: TextStyle(
//                                               fontWeight: FontWeight.bold,
//                                               fontSize: SizeUtils
//                                                       .horizontalBlockSize *
//                                                   5.5))
//                                     ])),
//                               ],
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           height: 3.h,
//                         ),
//                         Text(
//                           " Sign Up",
//                           style: TextStyle(
//                               fontSize: SizeUtils.horizontalBlockSize * 6.5,
//                               fontWeight: FontWeight.bold,
//                               fontFamily: "MuseoSans_700.otf"),
//                         ),
//                         SizedBox(
//                           height: 3.h,
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Container(
//                               width: 45.w,
//                               child: SignUpFeilds(
//                                 // text: "First Name",
//                                 hinttext: " First name ",
//                                 controller: firstNameController,
//                                 keyboardtype: TextInputType.name,
//                               ),
//                             ),
//                             SizedBox(
//                               width: 3.w,
//                             ),
//                             Container(
//                               width: 45.w,
//                               child: SignUpFeilds(
//                                 // text: "Last Name",
//                                 hinttext: " Last name ",
//                                 controller: lastNameController,
//                                 keyboardtype: TextInputType.name,
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(
//                           height: 2.h,
//                         ),
//                         SignUpFeilds(
//                           // text: "Email",
//                           hinttext: "Enter your  Email ",
//                           keyboardtype: TextInputType.emailAddress,
//                           controller: mobileNumberController,
//                         ),
//                         SizedBox(
//                           height: 2.h,
//                         ),
//                         SignUpFeilds(
//                           hinttext: 'Enter Referral code',
//                           maxlength: 10,
//                           controller: _signInController.referralController,
//                           onChange: (value) {
//                             _signInController.referral.value = value;
//                           },
//                         ),
//                         SizedBox(height: 20.h),
//                         GestureDetector(
//                           onTap: () async {
//                             _signInController.signUpButton(
//                                 firstNameController.text,
//                                 lastNameController.text,
//                                 mobileNumberController.text);
//                           },
//                           child: BottomWideButton(
//                             text: "SIGNUP",
//                           ),
//                         ),
//                       ]),
//           ),
//         )),
//       ),
//     );
//   }
// }

import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/app/controller/signInScreenController.dart';
import 'package:customer_app/app/ui/common/shimmer_widget.dart';
import 'package:customer_app/app/ui/pages/signIn/phone_authentication_screen.dart';
import 'package:customer_app/app/ui/pages/signIn/signup_bs.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/screens/more_stores/all_offers.dart';
import 'package:customer_app/widgets/homescreen_appbar.dart';
import 'package:customer_app/widgets/signup_feilds.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../../screens/new_base_screen.dart';

class Bloyallogo extends StatelessWidget {
  const Bloyallogo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 6.h,
        width: 50.w,
        child: FittedBox(
          child: SvgPicture.asset(
            "assets/icons/logoname1.svg",
            fit: BoxFit.fill,
            color: Color(0xff171e2e),
          ),
        ));
  }
}

class SignupScreenShimmerEffect extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // BackButton(
          //   color: AppConst.black,
          //   onPressed: () {
          //     Get.back();
          //   },
          // ),
          ShimmerEffect(child: Bloyallogo()),
          // SizedBox(
          //   width: 10.w,
          // )
        ],
      ),
      SizedBox(
        height: 3.h,
      ),
      ShimmerEffect(
        child: Text(
          " Sign Up",
          style: TextStyle(
              fontSize: SizeUtils.horizontalBlockSize * 6.5,
              fontWeight: FontWeight.bold,
              fontFamily: "MuseoSans_700.otf"),
        ),
      ),
      SizedBox(
        height: 3.h,
      ),
      SignUpFeildsShimmer(),
      SizedBox(
        height: 2.h,
      ),
      SignUpFeildsShimmer(),
      SizedBox(
        height: 2.h,
      ),
      SignUpFeildsShimmer(),
      // Container(
      //   width: MediaQuery.of(context).size.width,
      //   // height: 9.h,
      //   decoration: BoxDecoration(
      //       borderRadius: BorderRadius.circular(10),
      //       border: Border.all(color: AppConst.black, width: 1.5)),
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       Padding(
      //         padding: EdgeInsets.only(
      //             left: 2.w, top: 0.5.h, bottom: 0.5.h),
      //         child: Text(
      //           "Email",
      //           style: TextStyle(
      //               fontSize: 9.sp, fontWeight: FontWeight.w500),
      //         ),
      //       ),
      //       TextField(
      //         style: TextStyle(fontSize: 14.sp),
      //         textAlign: TextAlign.start,
      //         cursorColor: AppConst.kPrimaryColor,
      //         // maxLength: 10,
      //         // keyboardType: TextInputType.number,
      //         controller: mobileNumberController,
      //         decoration: InputDecoration(
      //           isDense: true,
      //           border: InputBorder.none,
      //           hintText: 'Enter Email',
      //           contentPadding:
      //               EdgeInsets.only(left: 2.w, bottom: 1.h),
      //           hintTextDirection: TextDirection.ltr,
      //           counterText: "",
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
      SizedBox(
        height: 38.h,
      ),
      ShimmerEffect(
        child: BottomWideButton(
          text: "SIGNUP",
        ),
      )
    ]);
  }
}

class SignUpScreen extends StatefulWidget {
 
  SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance?.addPostFrameCallback((_) {
  //     show(context);
  //   });
  // }

  // void show(BuildContext context) {
  //   showModalBottomSheet(
  //       isScrollControlled: true,
  //       enableDrag: false,
  //       context: context,
  //       isDismissible: false,
  //       // useRootNavigator: false,
  //       shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.only(
  //         topLeft: Radius.circular(10),
  //         topRight: Radius.circular(10),
  //       )),
  //       builder: (builder) {
  //         return Padding(
  //             padding: MediaQuery.of(context).viewInsets, child: SignupBs());
  //       });
  // }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
          statusBarColor: AppConst.darkGreen,
          statusBarIconBrightness: Brightness.light),
      child: Scaffold(
        // resizeToAvoidBottomInset: true,
        bottomSheet: Container(
         
            decoration: BoxDecoration(
                color: AppConst.white, borderRadius: BorderRadius.circular(12)),
            child: SignupBs()),
        body: SignUpBackground(),
      ),
    );
  }
}

class SignUpBackground extends StatelessWidget {
  const SignUpBackground({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
            statusBarColor: AppConst.darkGreen,
            statusBarIconBrightness: Brightness.light),
        child: Scaffold(
          backgroundColor: AppConst.darkGreen,
          body: SafeArea(
            child: DefaultTabController(
              length: 3,
              child: Column(
                children: [
                
                  TabBar(
                      isScrollable: true,
                      indicator: BoxDecoration(
                        color: AppConst.white,
                      ),
                      indicatorSize: TabBarIndicatorSize.tab,
                      labelColor: AppConst.darkGreen,
                      unselectedLabelColor: AppConst.white,
                      // labelStyle: TextStyle(fontSize: 16),

                      labelStyle: TextStyle(
                          fontSize: (SizerUtil.deviceType == DeviceType.tablet)
                              ? 10.sp
                              : 13.sp,
                          color: AppConst.white,
                          fontWeight: FontWeight.w500),
                      tabs: [
                        Text("Pay At Store"),
                        Text("Scan"),
                        Text("Order")
                      ]),
                  ClaimMoreButton(),
                  Container(
                    color: AppConst.white,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 4.w, vertical: 1.5.h),
                      child: Container(
                        height: 1,
                        color: AppConst.grey,
                      ),
                    ),
                  ),
                  Flexible(
                      child: TabBarView(children: [
                    DummyPayAtStore(),
                    DummyScanReceiptStores(),
                    DummyScanReceiptStores(),
                    // RecentOrdersAndStores()
                  ]))
                ],
              ),
            ),
          ),
        ));
    // Stack(
    //   children: [
    //     Column(
    //       children: [
    //         Container(
    //           width: double.infinity,
    //           color: AppConst.darkGreen,
    //           child: SafeArea(
    //             bottom: false,
    //             child: HomeAppBar(
    //               onTap: () async {},
    //               isRedDot: false,
    //               address: 'Your Location',
    //               balance: "",
    //               onTapWallet: () {},
    //               isHomeScreen: true,
    //             ),
    //           ),
    //         ),
    //         Container(
    //           height: 35.h,
    //           child: GridView.count(
    //             padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
    //             crossAxisCount: 3,
    //             children: [
    //               Image.asset(
    //                 "assets/images/Fresh.png",
    //               ),
    //               Image.asset(
    //                 "assets/images/groceryImage.png",
    //               ),
    //               Image.asset(
    //                 "assets/images/Nonveg.png",
    //               ),
    //               Image.asset(
    //                 "assets/images/Pickup.png",
    //               ),
    //               Image.asset(
    //                 "assets/images/Premium.png",
    //               ),
    //               Image.asset(
    //                 "assets/images/Medics.png",
    //               ),
    //             ],
    //           ),
    //         ),
    //         Padding(
    //           padding: EdgeInsets.symmetric(vertical: 0.5.h),
    //           child: Container(
    //             height: 1.2.w,
    //             color: AppConst.lightGrey,
    //           ),
    //         ),
    //         AllOffers()
    //       ],
    //     ),
    //     Positioned(
    //         child: Container(
    //       height: 100.h,
    //       width: double.infinity,
    //       color: AppConst.black.withOpacity(0.3),
    //     ))
    //   ],
    // );
  }

  
}

class DummyPayAtStore extends StatelessWidget {
  DummyPayAtStore({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return ListView(
      // controller:
      children: [
        Container(
          decoration: BoxDecoration(color: AppConst.white),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 4.w, top: 1.h, bottom: 2.h),
                child: Text(
                  'Recent Stores',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'MuseoSans',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Container(
                height: 6.h,
                color: AppConst.Lightgrey,
                child: ListView(
                  padding:
                      EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.5.h),
                  scrollDirection: Axis.horizontal,
                  children: [
                    DisplayBusinessType(
                      text: "Grocery",
                    ),
                    SizedBox(
                      width: 3.w,
                    ),
                    DisplayBusinessType(
                      text: "Pet food",
                    ),
                    SizedBox(
                      width: 3.w,
                    ),
                    DisplayBusinessType(
                      text: "Pharmacy",
                    ),
                    SizedBox(
                      width: 3.w,
                    ),
                    DisplayBusinessType(
                      text: "Meat",
                    ),
                    SizedBox(
                      width: 3.w,
                    ),
                    DisplayBusinessType(
                      text: "Meat",
                    ),
                    SizedBox(
                      width: 3.w,
                    ),
                  ],
                ),
              ),
             ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return InkWell(
                           
                            child: DummyListOfAllWallets(
                             
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox();
                        },
                      ),
              
            ],
          ),
        ),
      ],
    );
  }
}

class DummyListOfAllWallets extends StatelessWidget {
 

  DummyListOfAllWallets({
    Key? key,
  
  }) : super(key: key);

  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.5.h, horizontal: 1.w),
      child: Column(
        children: [
          ListViewStoreDetails(
            logo: "",
            // color: color,
            // isDisplayDistance: true,
            // StoreID: "${storeSearchModel.sId ?? ""}",
            StoreName: "robin mall",
            distance: 1,
            balance: 200,
          ),
        ],
      ),
    );
  }
}
class DummyScanReceiptStores extends StatelessWidget {
  DummyScanReceiptStores({
    Key? key,
  }) : super(key: key);
 
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppConst.white,
      child:ListView.separated(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return InkWell(
                        
                        child: DummyListOfAllWallets(
                         
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox();
                    },
                  ),
      
    );
  }
}
