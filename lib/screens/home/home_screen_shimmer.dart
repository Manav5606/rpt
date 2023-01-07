import 'package:customer_app/app/controller/add_location_controller.dart';
import 'package:customer_app/widgets/all_offers_listview_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/app/data/provider/firebase/firebase_notification.dart';
import 'package:customer_app/app/ui/common/shimmer_widget.dart';
import 'package:customer_app/app/ui/pages/stores/InStoreScreen.dart';
import 'package:customer_app/app/ui/pages/stores/storedetailscreen.dart';
import 'package:customer_app/constants/app_const.dart';

import 'package:customer_app/constants/string_constants.dart';
import 'package:customer_app/data/models/category_model.dart';
import 'package:customer_app/routes/app_list.dart';
import 'package:customer_app/screens/home/controller/home_controller.dart';
import 'package:customer_app/screens/more_stores/all_offers_listview.dart';
import 'package:customer_app/theme/styles.dart';
import 'package:customer_app/screens/more_stores/all_offers.dart';
import 'package:customer_app/widgets/cartWidget.dart';
import 'package:customer_app/widgets/category_card.dart';
import 'package:customer_app/widgets/yourStores.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class HomeScreenShimmer extends StatefulWidget {
  const HomeScreenShimmer({Key? key}) : super(key: key);

  @override
  _HomeScreenShimmerState createState() => _HomeScreenShimmerState();
}

class _HomeScreenShimmerState extends State<HomeScreenShimmer>
    with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;
  late ScrollController _categoryController;

  late AnimationController _hideFabAnimController;

  late double percent;
  int currentItems = 4;
  bool last = false;
  final HomeController _homeController = Get.put(HomeController());
  final AddLocationController _addLocationController = Get.find();

  @override
  void initState() {
    super.initState();
    percent = .50;
    _scrollController = ScrollController();
    _categoryController = ScrollController();
    _hideFabAnimController = AnimationController(
      vsync: this,
      duration: kThemeAnimationDuration,
      value: 1,
    );

    _scrollController.addListener(() {
      switch (_scrollController.position.userScrollDirection) {
        case ScrollDirection.forward:
          _hideFabAnimController.forward();
          break;
        case ScrollDirection.reverse:
          _hideFabAnimController.reverse();
          break;
        case ScrollDirection.idle:
          break;
      }
    });

    _categoryController.addListener(_scrollListener);

    // Notification
    FireBaseNotification().localNotificationRequestPermissions();
    FireBaseNotification().configureDidReceiveLocalNotificationSubject();
    FireBaseNotification().configureSelectNotificationSubject();
  }

  _scrollListener() {
    setState(() {
      if (_categoryController.position.pixels > 200) {
        setState(() {
          last = true;
        });
      } else {
        setState(() {
          last = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _hideFabAnimController.dispose();
    FireBaseNotification().localNotificationDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShimmerEffect(
                child: Container(
                  width: 100.w,
                  height: 6.h,
                  color: AppConst.black,
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              Container(
                height: 35.h,
                child: GridView(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 1.w,
                      mainAxisSpacing: 2.h),
                  children: [
                    ShimmerEffect(
                      child: Image.asset(
                        "assets/images/Fresh.png",
                      ),
                    ),
                    ShimmerEffect(
                      child: Image.asset(
                        "assets/images/groceryImage.png",
                      ),
                    ),
                    ShimmerEffect(
                      child: Image.asset(
                        "assets/images/Nonveg.png",
                      ),
                    ),
                    ShimmerEffect(
                      child: Image.asset(
                        "assets/images/Pickup.png",
                      ),
                    ),
                    ShimmerEffect(
                      child: Image.asset(
                        "assets/images/Premium.png",
                      ),
                    ),
                    ShimmerEffect(
                      child: Image.asset(
                        "assets/images/Medics.png",
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ShimmerEffect(
                  child: AllOffersListViewShimmer(
                      // controller: _scrollController,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
