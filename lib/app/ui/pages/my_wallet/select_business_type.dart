import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../controller/my_wallet_controller.dart';

class SelectBusinessType extends StatefulWidget {
  const SelectBusinessType({Key? key}) : super(key: key);

  @override
  State<SelectBusinessType> createState() => _SelectBusinessTypeState();
}

class _SelectBusinessTypeState extends State<SelectBusinessType> {
  LatLng center = LatLng(20, 20);
  final MyWalletController _myWalletcontroller = Get.put(MyWalletController());
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
          statusBarColor: AppConst.darkGreen,
          statusBarIconBrightness: Brightness.light),
      child: Scaffold(
        backgroundColor: AppConst.white,
        body: SafeArea(
            child: Column(
          children: [
            Container(
              height: 9.h,
              color: AppConst.darkGreen,
              width: Device.screenWidth,
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 5.w),
                        child: Text("Balance available",
                            style: TextStyle(
                              fontFamily: 'MuseoSans',
                              color: AppConst.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.normal,
                              letterSpacing: -0.48,
                            )),
                      ),
                      RichText(
                          text: new TextSpan(children: [
                        new TextSpan(
                            text: "₹",
                            style: TextStyle(
                              fontFamily: 'Inter',
                              color: AppConst.radiumGreen,
                              fontSize: 32,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                            )),
                        new TextSpan(
                            text: "6330",
                            style: TextStyle(
                              fontFamily: 'MuseoSans',
                              color: AppConst.white,
                              fontSize: 32,
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.normal,
                            )),
                      ]))
                    ],
                  )),
            ),
            Container(
              height: 35.h,
              width: Device.screenHeight,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 4.w, right: 4.w, top: 2.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 2.h,
                          width: 50.w,
                          child: Text(
                              "ABC Street, area no: 51, ABC Area, City,  State, india",
                              style: TextStyle(
                                fontFamily: 'MuseoSans',
                                color: AppConst.grey,
                                fontSize: 14,
                                overflow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.normal,
                              )),
                        ),
                        Row(
                          children: [
                            SvgPicture.asset('assets/icons/location.svg'),
                            SizedBox(width: 2.w),
                            Text("Update",
                                style: TextStyle(
                                  fontFamily: 'MuseoSans',
                                  color: AppConst.limegreen,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FontStyle.normal,
                                ))
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 26.h,
                        width: Device.screenWidth / 1.1,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        child: GoogleMap(
                          initialCameraPosition: CameraPosition(
                            target: LatLng(20,
                                20), // Replace latitude and longitude with your desired coordinates
                            zoom: 13.0,
                          ),
                          myLocationEnabled: false,
                          myLocationButtonEnabled: false,
                          zoomControlsEnabled: false,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Container(
              height: 17.h,
              width: Device.screenWidth,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _myWalletcontroller.category.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Container(
                                  height: 10.h,
                                  width: 20.w,
                                  color: AppConst.white,
                                  child: Image.asset(
                                    _myWalletcontroller.category[index].image,
                                    fit: BoxFit.fitWidth,
                                    // scale: 1,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 6.h,
                                right: 0.0,
                                bottom: 0.0,
                                child: Container(
                                  height: 4.h,
                                  width: 5.w,
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 0.5.h,
                          ),
                          Text("Grocery",
                              style: TextStyle(
                                fontFamily: 'MuseoSans',
                                color: AppConst.lightBlack,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.normal,
                              )),
                          SizedBox(
                            height: 0.5.h,
                          ),
                          Text("₹1250",
                              style: TextStyle(
                                fontFamily: 'MuseoSans',
                                color: AppConst.grey,
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.normal,
                              ))
                        ],
                      ),
                    );
                  }),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 4.w,
                right: 4.w,
              ),
              child: Row(
                children: [
                  Text("More Offers",
                      style: TextStyle(
                        fontFamily: 'MuseoSans',
                        color: AppConst.lightBlack,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                      ))
                ],
              ),
            ),
            Expanded(
                child: Stack(
              children: [
                Container(
                  height: 20.h,
                  width: Device.screenWidth,
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding:
                              EdgeInsets.only(left: 4.w, right: 4.w, top: 2.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundImage: AssetImage(
                                        _myWalletcontroller
                                            .category[index].image),
                                  ),
                                  SizedBox(
                                    width: 4.w,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Chicken & Meat",
                                          style: TextStyle(
                                            fontFamily: 'MuseoSans',
                                            color: AppConst.lightBlack,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            fontStyle: FontStyle.normal,
                                            letterSpacing: -0.48,
                                          )),
                                      Text("Do you like Non-veg?",
                                          style: TextStyle(
                                            fontFamily: 'MuseoSans',
                                            color: AppConst.grey,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            fontStyle: FontStyle.normal,
                                          ))
                                    ],
                                  )
                                ],
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  height: 4.h,
                                  width: 20.w,
                                  decoration: BoxDecoration(
                                      color: AppConst.darkGreen,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Center(
                                    child: Text("Select",
                                        style: TextStyle(
                                          fontFamily: 'MuseoSans',
                                          color: AppConst.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                          fontStyle: FontStyle.normal,
                                        )),
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      }),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Container(
                        height: 5.h,
                        width: Device.screenWidth / 1.2,
                        decoration: BoxDecoration(
                            color: AppConst.limegreen,
                            borderRadius: BorderRadius.circular(8)),
                        child: Center(
                          child: Text("Claim All: ₹6330",
                              style: TextStyle(
                                fontFamily: 'MuseoSans',
                                color: AppConst.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                              )),
                        ),
                      )),
                ),
              ],
            ))
          ],
        )),
      ),
    );
  }
}
