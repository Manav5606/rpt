import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/app/data/model/my_wallet_model.dart';
import 'package:customer_app/app/data/model/order_model.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/screens/history/history_order_tracking_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

class OrderSucessScreen extends StatefulWidget {
  final OrderData? order;
  final String? type;

  OrderSucessScreen({Key? key, this.order, this.type = "order"})
      : super(key: key);

  @override
  State<OrderSucessScreen> createState() => _OrderSucessScreenState();
}

class _OrderSucessScreenState extends State<OrderSucessScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      Future.delayed(Duration(seconds: (widget.type == "order") ? 2 : 3), () {
        (widget.type == "order")
            ? Get.off(
                OrderSucessScreen2(
                  order: widget.order,
                ),
                transition: Transition.fadeIn)
            : Get.off(
                HistoryOrderTrackingScreen(
                  // displayHour: _addCartController.displayHour.value,
                  order: widget.order,
                ),
                transition: Transition.fade);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
          statusBarColor: AppConst.white,
          statusBarIconBrightness: Brightness.dark),
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            color: AppConst.white,
          ),
          height: double.infinity,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Lottie.asset('assets/lottie/paymentdone.json'),
              ),
              Text(
                (widget.type == "order")
                    ? "Order Placed "
                    : (widget.type == "scan")
                        ? "Scan Receipt "
                        : "Refunded",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: SizeUtils.horizontalBlockSize * 7,
                    fontFamily: 'MuseoSans',
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1),
              ),
              Text(
                "Successfully",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: SizeUtils.horizontalBlockSize * 5,
                    fontFamily: 'MuseoSans',
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class OrderFailScreen extends StatefulWidget {
  final OrderData? order;
  final String? type;

  OrderFailScreen({Key? key, this.order, this.type = "order"})
      : super(key: key);

  @override
  State<OrderFailScreen> createState() => _OrderFailScreenState();
}

class _OrderFailScreenState extends State<OrderFailScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      Future.delayed(Duration(seconds: 3), () {
        Get.off(
            HistoryOrderTrackingScreen(
              // displayHour: _addCartController.displayHour.value,
              order: widget.order,
            ),
            transition: Transition.fade);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
          statusBarColor: AppConst.white,
          statusBarIconBrightness: Brightness.dark),
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            color: AppConst.white,
          ),
          height: double.infinity,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Lottie.asset('assets/lottie/paymentfail.json'),
              ),
              Text(
                (widget.type == "order")
                    ? "Order Placed "
                    : (widget.type == "scan")
                        ? "Scan Receipt "
                        : "Refunded",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: SizeUtils.horizontalBlockSize * 7,
                    fontFamily: 'MuseoSans',
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1),
              ),
              Text(
                "UnSuccessful",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: SizeUtils.horizontalBlockSize * 5,
                    fontFamily: 'MuseoSans',
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class OrderSucessScreen2 extends StatefulWidget {
  final OrderData? order;

  OrderSucessScreen2({
    Key? key,
    this.order,
  }) : super(key: key);

  @override
  State<OrderSucessScreen2> createState() => _OrderSucessScreen2State();
}

class _OrderSucessScreen2State extends State<OrderSucessScreen2> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      Future.delayed(Duration(seconds: 2), () {
        // Get.toNamed(AppRoutes.Root);

        Get.off(
            HistoryOrderTrackingScreen(
              // displayHour: _addCartController.displayHour.value,
              order: widget.order,
            ),
            transition: Transition.fade);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
          statusBarColor: AppConst.white,
          statusBarIconBrightness: Brightness.dark),
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            color: AppConst.white,
            // image: DecorationImage(
            //     image: AssetImage("assets/images/splashbg.png"),
            //     fit: BoxFit.fill),
          ),
          height: double.infinity,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Lottie.asset(
                  'assets/lottie/gift.json',
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                  text: "\u{20B9}",
                  style: TextStyle(
                    color: Color(0xffFFCF1F),
                    fontSize: SizeUtils.horizontalBlockSize * 12,
                    fontFamily: 'MuseoSans',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextSpan(
                  text:
                      "${widget.order?.final_payable_wallet_amount?.toStringAsFixed(2) ?? 0}",
                  style: TextStyle(
                    color: AppConst.black,
                    fontSize: SizeUtils.horizontalBlockSize * 12,
                    fontFamily: 'MuseoSans',
                    fontWeight: FontWeight.w700,
                  ),
                )
              ])),
              SizedBox(
                height: 1.h,
              ),
              Text(
                "Cashback",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: SizeUtils.horizontalBlockSize * 7,
                    fontFamily: 'MuseoSans',
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1),
              ),
              Text(
                "Earned",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: SizeUtils.horizontalBlockSize * 5,
                    fontFamily: 'MuseoSans',
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1),
              ),
              SizedBox(
                height: 7.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
