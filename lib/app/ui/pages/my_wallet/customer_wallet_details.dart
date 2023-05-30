import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/app/controller/my_wallet_controller.dart';
import 'package:customer_app/app/ui/pages/my_wallet/select_business_type.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/routes/app_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../signIn/signup_screen.dart';

class CustomerWalletDetails extends StatefulWidget {
  const CustomerWalletDetails({Key? key}) : super(key: key);

  @override
  State<CustomerWalletDetails> createState() => _CustomerWalletDetailsState();
}

class _CustomerWalletDetailsState extends State<CustomerWalletDetails> {
  final MyWalletController _myWalletcontroller = Get.put(MyWalletController());

  Color color = Color(0xFF031929);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<MyWalletController>(builder: (controller) {
        if (controller.isCustomerLoading.value == true) {
          return Center(child: CircularProgressIndicator());
        } else {
          return Container(
            height: double.infinity,
            width: double.infinity,
            child: Column(
              children: [
                Container(
                  color: color,
                  width: SizeUtils.screenWidth,
                  height: 45.h,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              height: 45.h,
                              width: Device.screenWidth / 2,
                              // color: Colors.white,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.only(top: 8.h, left: 3.w),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: GestureDetector(
                                        onTap: () {
                                          Get.to(SelectBusinessType());
                                        },
                                        child: Container(
                                          height: 30,
                                          width: 30,
                                          child: Icon(
                                            Icons.close,
                                            size: 35,
                                            color: AppConst.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Stack(
                                      alignment:
                                          AlignmentDirectional.bottomCenter,
                                      children: [
                                        Container(
                                            // color: Colors.white,
                                            height: 25.h,
                                            width: 50.w,
                                            child: Align(
                                                alignment:
                                                    Alignment.bottomRight,
                                                child: Image.asset(
                                                    'assets/images/wallet.png'))),
                                        Padding(
                                          padding: EdgeInsets.only(left: 24.w),
                                          child: Container(
                                              // color: Colors.white,
                                              height: 25.h,
                                              width: 35.w,
                                              child: Align(
                                                  alignment:
                                                      Alignment.bottomLeft,
                                                  child: Image.asset(
                                                      'assets/images/coin.png'))),
                                        ),
                                      ]),
                                ],
                              ),
                            )
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 40.h,
                              width: Device.screenWidth / 2,
                              // color: Colors.red,
                              child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(top: 10.h),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              "₹",
                                              style: TextStyle(
                                                  fontFamily: 'Inter',
                                                  color: AppConst.darkyellow,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 42),
                                            ),
                                            Text(
                                              controller
                                                  .myCustomerWalletModel
                                                  .value!
                                                  .totalWelcomeOfferAmount
                                                  .toString(),
                                              style: TextStyle(
                                                  fontFamily: 'MuseoSans',
                                                  color: AppConst.white,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 42),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 4.w),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Balance available",
                                              style: TextStyle(
                                                  color: Colors.white60,
                                                  fontFamily: 'MuseoSans',
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                            Container(
                              height: 5.h,
                              width: Device.screenWidth / 2,
                              // color: Colors.red,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 12.0),
                                child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            "Claim All Balance",
                                            style: TextStyle(
                                              fontFamily: 'MuseoSans',
                                              color: AppConst.white,
                                              fontSize: 15,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 0.2.h),
                                          child: SizedBox(
                                              height: 30,
                                              width: 30,
                                              child: Icon(
                                                Icons.arrow_forward_ios,
                                                color: Colors.white,
                                              )),
                                        )
                                      ],
                                    )),
                              ),
                            ),
                            // Container()
                          ],
                        ),

                        // Row()
                      ]),
                ),
                SizedBox(
                  height: 3.h,
                ),
                Container(
                  height: 8.h,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          SvgPicture.asset(
                            'assets/icons/location_marker.svg',
                            // height: 20,
                            // width: 20,
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 44.w),
                            child: Text(
                              "Location",
                              style: TextStyle(
                                fontFamily: 'MuseoSans',
                                color: Color(0xff000000),
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                          ),
                          Container(
                              width: 60.w,
                              // color: AppConst.green,
                              child: Text(
                                "ABC Street, area no: 51, ABC Area, City, State, indian etc.",
                                style: TextStyle(
                                  fontFamily: 'MuseoSans',
                                  color: Color(0xff9e9e9e),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.normal,
                                ),
                              )),
                          // Text("Location"),
                        ],
                      ),
                      Column(
                        children: [Icon(Icons.edit)],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 2.h,
                  width: Device.screenWidth / 1.1,
                  child: Divider(
                    thickness: 2,
                    color: AppConst.grey100,
                  ),
                ),
                SizedBox(
                  height: 7.h,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 4.w),
                        child: Row(
                          children: [
                            Text("Offers just for you",
                                style: TextStyle(
                                  fontFamily: 'MuseoSans',
                                  color: Color(0xff000000),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FontStyle.normal,
                                ))
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 4.w),
                        child: Row(
                          children: [
                            Text(
                                "You can claim these offers & credit to your wallet.",
                                style: TextStyle(
                                  fontFamily: 'MuseoSans',
                                  color: Color(0xff3a3a3a),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.normal,
                                ))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    color: AppConst.Lightgrey,
                    height: SizeUtils.screenHeight,
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, childAspectRatio: 0.6),
                      itemCount: controller.category.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: AppConst.white,
                                borderRadius: BorderRadius.circular(15)),
                            child: Center(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      controller.category[index].image,
                                      scale: 1,
                                      width: Device.screenWidth / 3,
                                    )
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(controller.category[index].name,
                                        style: TextStyle(
                                          fontFamily: 'MuseoSans',
                                          color: Color(0xff000000),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          fontStyle: FontStyle.normal,
                                          letterSpacing: -0.48,
                                        ))
                                  ],
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: Device.screenWidth / 2.5,
                                      child:
                                          Text(controller.category[index].title,
                                              style: TextStyle(
                                                fontFamily: 'MuseoSans',
                                                color: Color(0xff3a3a3a),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w300,
                                                fontStyle: FontStyle.normal,
                                              )),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 4.h,
                                ),
                                Container(
                                  height: Device.screenHeight / 22,
                                  width: Device.screenWidth / 2.5,
                                  decoration: BoxDecoration(
                                      color: AppConst.darkGreen,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Get.to(SignUpScreen());
                                        },
                                        child: Text(
                                            controller
                                                .myCustomerWalletModel
                                                .value!
                                                .data![index]
                                                .totalWelcomeOfferByBusinessType
                                                .toString(),
                                            style: TextStyle(
                                              fontFamily: 'MuseoSans',
                                              color: Color(0xffffffff),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              fontStyle: FontStyle.normal,
                                            )),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            )),
                          ),
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
          );
        }
      }),
    );
  }
}
