import 'package:customer_app/app/constants/colors.dart';
import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/app/controller/account_controller.dart';
import 'package:customer_app/app/controller/add_location_controller.dart';
import 'package:customer_app/app/controller/my_wallet_controller.dart';
import 'package:customer_app/app/data/model/my_wallet_model.dart';
import 'package:customer_app/app/data/repository/hive_repository.dart';
import 'package:customer_app/app/ui/common/loader.dart';
import 'package:customer_app/app/ui/common/shimmer_widget.dart';
import 'package:customer_app/app/ui/pages/chat/freshchat_controller.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/controllers/userViewModel.dart';
import 'package:customer_app/models/getRedeemCashStorePageDataModel.dart';
import 'package:customer_app/routes/app_list.dart';
import 'package:customer_app/screens/addcart/controller/addcart_controller.dart';
import 'package:customer_app/screens/history/history_screen.dart';
import 'package:customer_app/screens/home/controller/home_controller.dart';
import 'package:customer_app/screens/home/home_screen.dart';
import 'package:customer_app/screens/more_stores/all_offers_listview.dart';
import 'package:customer_app/screens/more_stores/morestore_controller.dart';
import 'package:customer_app/screens/root/network_check.dart';
import 'package:customer_app/screens/wallet/controller/paymentController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import '../app/data/repository/my_account_repository.dart';
import '../app/ui/pages/search/controller/exploreContoller.dart';

class NewBaseScreen extends StatefulWidget {
  const NewBaseScreen({Key? key}) : super(key: key);

  @override
  _NewBaseScreenState createState() => _NewBaseScreenState();
}

class _NewBaseScreenState extends State<NewBaseScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Connectivity connectivity = Connectivity();
    return Scaffold(
      body: StreamBuilder<ConnectivityResult>(
        stream: connectivity.onConnectivityChanged,
        builder: (_, snapshot) {
          return CheckInternetConnectionWidget(
            snapshot: snapshot,
            showsnankbar: false,
            widget: SignInWalletScreen(),
          );
        },
      ),
    );
  }
}

class SignInWalletScreen extends StatefulWidget {
  const SignInWalletScreen({Key? key}) : super(key: key);

  @override
  State<SignInWalletScreen> createState() => _SignInWalletScreenState();
}

class _SignInWalletScreenState extends State<SignInWalletScreen> {
  final MyWalletController _myWalletController = Get.find();
  final HomeController _homeController = Get.put(HomeController())
    ..getAllCartsData();

  final PaymentController _paymentController = Get.put(PaymentController());
  final AddCartController _addCartController = Get.put(AddCartController());
  final MyAccountController _myAccountController =
      Get.put(MyAccountController(MyAccountRepository(), HiveRepository()))
        ..getActiveOrders();
  final freshChatController _freshChat = Get.put(freshChatController());
  final UserViewModel userViewModel = Get.put(UserViewModel());
  final MoreStoreController _moreStoreController =
      Get.put(MoreStoreController());

  @override
  Widget build(BuildContext context) {
    var balance = _myWalletController.StoreTotalWelcomeAmount();
    return Obx(
      () => _myWalletController.isLoading.value
          ? shimmer()
          : AnnotatedRegion<SystemUiOverlayStyle>(
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
                        Obx(
                          () => DisplayAmountAndSkipButton(
                            walletAmount: _myWalletController
                                .walletbalanceOfBusinessType.value,
                          ),
                        ),
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
                                fontSize:
                                    (SizerUtil.deviceType == DeviceType.tablet)
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
                          PayAtStore(),
                          ScanReceiptStores(),
                          RecentOrdersAndStores()
                        ]))
                      ],
                    ),
                  ),
                ),
              )),
    );
  }

  Widget shimmer() {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
          statusBarColor: AppConst.white,
          statusBarIconBrightness: Brightness.light),
      child: Scaffold(
        backgroundColor: AppConst.white,
        body: SafeArea(
          child: Column(
            children: [
              DisplayAmountAndSkipButtonShimmer(
                walletAmount:
                    _myWalletController.walletbalanceOfBusinessType.value,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ShimmerEffect(
                    child: Container(
                      height: 20,
                      width: 80,
                      color: AppConst.grey,
                    ),
                  ),
                  ShimmerEffect(
                    child: Container(
                      height: 20,
                      width: 80,
                      color: AppConst.grey,
                    ),
                  ),
                  ShimmerEffect(
                    child: Container(
                      height: 20,
                      width: 80,
                      color: AppConst.grey,
                    ),
                  )
                ],
              ),
              ClaimMoreButtonShimmer(),
              ShimmerEffect(
                child: Container(
                  height: 6.h,
                  // color: AppConst.Lightgrey,
                  child: ListView(
                    padding:
                        EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.5.h),
                    scrollDirection: Axis.horizontal,
                    children: [
                      DisplayBusinessType(
                        text: "Grocery ",
                      ),
                      SizedBox(
                        width: 3.w,
                      ),
                      DisplayBusinessType(
                        text: "Grocery ",
                      ),
                      SizedBox(
                        width: 3.w,
                      ),
                      DisplayBusinessType(
                        text: "Grocery ",
                      ),
                      SizedBox(
                        width: 3.w,
                      ),
                      DisplayBusinessType(
                        text: "Grocery ",
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
              ),
              Expanded(
                child: Container(
                    height: MediaQuery.of(context).size.height,
                    child: ListView.separated(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {},
                          child: ListOfAllWalletsShimmer(),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox();
                      },
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ScanReceiptStores extends StatelessWidget {
  ScanReceiptStores({
    Key? key,
  }) : super(key: key);
  final MyWalletController _myWalletController = Get.find();
  final ExploreController _exploreController = Get.put(ExploreController());

  final PaymentController _paymentController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppConst.white,
      child: Obx(
        () => _myWalletController.isLoading.value
            ? Container(height: 90.h, child: LoadingWidget())
            : (_myWalletController.myWalletModel.value?.data == null ||
                    _myWalletController.myWalletModel.value?.data?.length == 0)
                ? EmptyHistoryPage(
                    text1: "You Don't have any stores yet",
                    text2: "Add stores to get the Cashback",
                    text3: "",
                    icon: Icons.currency_rupee_sharp,
                  )
                : ListView.separated(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: _myWalletController.myWalletModel.value?.data
                            ?.where((c) => c.deactivated == false)
                            .toList()
                            .length ??
                        0,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () async {
                          _paymentController.isLoading.value = true;
                          await _exploreController.getStoreData(
                              id: _myWalletController
                                      .myWalletModel.value!.data![index].sId ??
                                  "",
                              isScanFunction: true);

                          RedeemCashInStorePageData ScanReceiptData =
                              RedeemCashInStorePageData(
                                  name: _myWalletController
                                      .myWalletModel.value!.data![index].name,
                                  sId: _myWalletController
                                      .myWalletModel.value!.data![index].sId,
                                  // storeType: _myWalletController.myWalletModel
                                  //     .value!.data![index].storeType,
                                  // earnedCashback: _myWalletController
                                  //     .myWalletModel
                                  //     .value!
                                  //     .data![index]
                                  //     .earnedCashback,
                                  // updatedAt: _myWalletController.myWalletModel
                                  //     .value!.data![index].updatedAt,
                                  // distance: _myWalletController.myWalletModel
                                  //     .value!.data![index].distance,
                                  // logo: _myWalletController
                                  //     .myWalletModel.value!.data![index].logo,
                                  // // businesstype: _myWalletController.myWalletModel.value!.data![index].storeType,
                                  // actual_cashback: _myWalletController
                                  //     .myWalletModel
                                  //     .value!
                                  //     .data![index]
                                  //     .earnedCashback,
                                  // premium: _myWalletController.myWalletModel
                                  //     .value!.data![index].premium,
                                  welcomeOfferAmount: _myWalletController
                                      .myWalletModel
                                      .value!
                                      .data![index]
                                      .welcomeOfferAmount);
                          _paymentController.redeemCashInStorePageDataIndex
                              .value = ScanReceiptData;

                          _paymentController.isLoading.value = false;
                        },
                        child: ListOfAllWallets(
                          walletData: _myWalletController
                              .myWalletModel.value!.data!
                              .where((c) => c.deactivated == false)
                              .toList()[index],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox();
                    },
                  ),
      ),
    );
  }
}

class RecentOrdersAndStores extends StatefulWidget {
  RecentOrdersAndStores({
    Key? key,
  }) : super(key: key);

  @override
  State<RecentOrdersAndStores> createState() => _RecentOrdersAndStoresState();
}

class _RecentOrdersAndStoresState extends State<RecentOrdersAndStores> {
  final MyWalletController _myWalletController = Get.find();

  final MoreStoreController _moreStoreController = Get.find();

  final MyAccountController _myAccountController = Get.find();

  final HomeController _homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    RxInt recentCount = ((_myAccountController.activeOrderCount.value) +
            (_homeController.cartsCount.value))
        .obs;
    return SingleChildScrollView(
      child: Container(
        color: AppConst.white,
        child: Obx(
          () => _myWalletController.isLoading.value
              ? Container(height: 90.h, child: LoadingWidget())
              : Column(
                  children: [
                    ((_myAccountController.activeOrdersModel.value?.data
                                        ?.length ??
                                    0) >
                                0) ||
                            ((_homeController.getAllCartsModel.value?.carts
                                        ?.length) ??
                                    0) >
                                0
                        ? Container(
                            height: 20.h,
                            decoration: BoxDecoration(color: Color(0xfff2f3f7)),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: 2.w, top: 1.h, right: 1.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Recent Orders",
                                          style: TextStyle(
                                            fontFamily: 'MuseoSans',
                                            color: AppConst.black,
                                            fontSize:
                                                SizeUtils.horizontalBlockSize *
                                                    4.5,
                                            fontWeight: FontWeight.w700,
                                            fontStyle: FontStyle.normal,
                                          )),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  Container(
                                    height: 14.h,
                                    color: AppConst.Lightgrey,
                                    width: double.infinity,
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Obx(() => ((_myAccountController
                                                      .activeOrderCount.value) >
                                                  0)
                                              ? ListView.builder(
                                                  // controller: _recentController,
                                                  itemCount: ((_myAccountController
                                                              .activeOrdersModel
                                                              .value
                                                              ?.data)
                                                          ?.length) ??
                                                      0,
                                                  physics:
                                                      NeverScrollableScrollPhysics(),
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  shrinkWrap: true,
                                                  itemExtent: (recentCount
                                                              .value ==
                                                          1)
                                                      ? SizeUtils
                                                              .horizontalBlockSize *
                                                          95
                                                      : (recentCount.value == 2)
                                                          ? SizeUtils
                                                                  .horizontalBlockSize *
                                                              80
                                                          : SizeUtils
                                                                  .horizontalBlockSize *
                                                              30,
                                                  itemBuilder:
                                                      (context, index) {
                                                    //currentItems = index;
                                                    return RecentActiveOrders1(
                                                      recentCount: recentCount,
                                                      myAccountController:
                                                          _myAccountController,
                                                      itemIndex:
                                                          (_myAccountController
                                                                      .activeOrdersModel
                                                                      .value
                                                                      ?.data!
                                                                      .length ??
                                                                  0) -
                                                              1 -
                                                              index,
                                                      navBackTo:
                                                          "newbasescreen",
                                                    );
                                                  },
                                                )
                                              : SizedBox()),
                                          Obx(() => ((_homeController
                                                      .cartsCount.value) >
                                                  0)
                                              ? ListView.builder(
                                                  // controller: _recentCartController,
                                                  itemCount:
                                                      // 1,
                                                      ((_homeController
                                                              .getAllCartsModel
                                                              .value
                                                              ?.carts
                                                              ?.length) ??
                                                          0),
                                                  physics: PageScrollPhysics(),
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  shrinkWrap: true,
                                                  itemExtent: (recentCount
                                                              .value ==
                                                          1)
                                                      ? SizeUtils
                                                              .horizontalBlockSize *
                                                          95
                                                      : (recentCount.value == 2)
                                                          ? SizeUtils
                                                                  .horizontalBlockSize *
                                                              80
                                                          : SizeUtils
                                                                  .horizontalBlockSize *
                                                              30,
                                                  itemBuilder:
                                                      (context, index) {
                                                    // currentItems = index;
                                                    return RecentCarts12(
                                                      recentCount:
                                                          recentCount.value,
                                                      moreStoreController:
                                                          _moreStoreController,
                                                      homeController:
                                                          _homeController,
                                                      itemIndex: (_homeController
                                                              .getAllCartsModel
                                                              .value
                                                              ?.carts
                                                              ?.length)! -
                                                          1 -
                                                          index,
                                                      navBackTo:
                                                          "newbasescreen",
                                                    );
                                                  },
                                                )
                                              : SizedBox()),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : SizedBox(),
                    (_myWalletController.myWalletModel.value?.data == null ||
                            _myWalletController
                                    .myWalletModel.value?.data?.length ==
                                0)
                        ? EmptyHistoryPage(
                            text1: "You Don't have any stores yet",
                            text2: "Add stores to get the Cashback",
                            text3: "",
                            icon: Icons.currency_rupee_sharp,
                          )
                        : ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: _myWalletController
                                    .myWalletModel.value?.data
                                    ?.where((c) => c.deactivated == false)
                                    .toList()
                                    .length ??
                                0,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () async {
                                  _moreStoreController.storeId.value =
                                      _myWalletController.myWalletModel.value!
                                              .data![index].sId ??
                                          '';
                                  await _moreStoreController.getStoreData(
                                      id: _myWalletController.myWalletModel
                                              .value!.data![index].sId ??
                                          '',
                                      businessId: '',
                                      navBackTo: "newbasescreen");
                                },
                                child: ListOfAllWallets(
                                  walletData: _myWalletController
                                      .myWalletModel.value!.data!
                                      .where((c) => c.deactivated == false)
                                      .toList()[index],
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
      ),
    );
  }
}

class PayAtStore extends StatelessWidget {
  PayAtStore({
    Key? key,
  }) : super(key: key);
  final MyWalletController _myWalletController = Get.find();

  final PaymentController _paymentController = Get.find();

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
                    //_myWalletController.myWalletModel.value?.data.first.businesstype.sId on basis of this id filter the list for each category
                    Obx(
                      () => (_myWalletController.intSelected.value == 1)
                          ? GestureDetector(
                              onTap: () {
                                _myWalletController.intSelected.value = 1;
                                _myWalletController.selectBusineesTypeId.value =
                                    '';
                              },
                              child: SelectedDisplayBusinessType(
                                text: "All",
                              ),
                            )
                          : GestureDetector(
                              onTap: () {
                                _myWalletController.intSelected.value = 1;
                                _myWalletController.selectBusineesTypeId.value =
                                    '';
                              },
                              child: DisplayBusinessType(
                                text: "All",
                              ),
                            ),
                    ),
                    SizedBox(
                      width: 3.w,
                    ),
                    Obx(
                      () => (_myWalletController.intSelected.value == 2)
                          ? GestureDetector(
                              onTap: () {
                                _myWalletController.intSelected.value = 2;
                                _myWalletController.selectBusineesTypeId.value =
                                    "61f95fcd0a984e3d1c8f9ec9";
                                // print(_myWalletController.intSelected.value);
                              },
                              child: SelectedDisplayBusinessType(
                                text: "Grocery",
                              ),
                            )
                          : GestureDetector(
                              onTap: () {
                                _myWalletController.intSelected.value = 2;
                                _myWalletController.selectBusineesTypeId.value =
                                    "61f95fcd0a984e3d1c8f9ec9";
                                // print(_myWalletController.intSelected.value);
                              },
                              child: DisplayBusinessType(
                                text: "Grocery",
                              ),
                            ),
                    ),

                    SizedBox(
                      width: 3.w,
                    ),
                    Obx(
                      () => (_myWalletController.intSelected.value == 3)
                          ? GestureDetector(
                              onTap: () {
                                _myWalletController.intSelected.value = 3;
                                _myWalletController.selectBusineesTypeId.value =
                                    "641ecc4ad9f0df5fa16d708d";
                                // print(_myWalletController.intSelected.value);
                              },
                              child: SelectedDisplayBusinessType(
                                text: "Dry Fruits",
                              ),
                            )
                          : GestureDetector(
                              onTap: () {
                                _myWalletController.intSelected.value = 3;
                                _myWalletController.selectBusineesTypeId.value =
                                    "641ecc4ad9f0df5fa16d708d";
                                // print(_myWalletController.intSelected.value);
                              },
                              child: DisplayBusinessType(
                                text: "Dry Fruits",
                              ),
                            ),
                    ),

                    SizedBox(
                      width: 3.w,
                    ),
                    Obx(
                      () => (_myWalletController.intSelected.value == 4)
                          ? GestureDetector(
                              onTap: () {
                                _myWalletController.intSelected.value = 4;
                                _myWalletController.selectBusineesTypeId.value =
                                    "63a68a03f5416c5c5b0ab0a5";
                                // print(_myWalletController.intSelected.value);
                              },
                              child: SelectedDisplayBusinessType(
                                text: "Pharmacy",
                              ),
                            )
                          : GestureDetector(
                              onTap: () {
                                _myWalletController.intSelected.value = 4;
                                _myWalletController.selectBusineesTypeId.value =
                                    "63a68a03f5416c5c5b0ab0a5";
                                // print(_myWalletController.intSelected.value);
                              },
                              child: DisplayBusinessType(
                                text: "Pharmacy",
                              ),
                            ),
                    ),
                    SizedBox(
                      width: 3.w,
                    ),
                    Obx(
                      () => (_myWalletController.intSelected.value == 5)
                          ? GestureDetector(
                              onTap: () {
                                _myWalletController.intSelected.value = 5;
                                _myWalletController.selectBusineesTypeId.value =
                                    "625cc6c0c30c356c00c6a9bb";
                                // print(_myWalletController.intSelected.value);
                              },
                              child: SelectedDisplayBusinessType(
                                text: "Meat",
                              ),
                            )
                          : GestureDetector(
                              onTap: () {
                                _myWalletController.intSelected.value = 5;
                                _myWalletController.selectBusineesTypeId.value =
                                    "625cc6c0c30c356c00c6a9bb";
                                // print(_myWalletController.intSelected.value);
                              },
                              child: DisplayBusinessType(
                                text: "Meat",
                              ),
                            ),
                    ),

                    SizedBox(
                      width: 3.w,
                    ),
                    Obx(
                      () => (_myWalletController.intSelected.value == 6)
                          ? GestureDetector(
                              onTap: () {
                                _myWalletController.intSelected.value = 6;
                                _myWalletController.selectBusineesTypeId.value =
                                    "63a689eff5416c5c5b0ab0a4";
                                // print(_myWalletController.intSelected.value);
                              },
                              child: SelectedDisplayBusinessType(
                                text: "Pet food",
                              ),
                            )
                          : GestureDetector(
                              onTap: () {
                                _myWalletController.intSelected.value = 6;
                                _myWalletController.selectBusineesTypeId.value =
                                    "63a689eff5416c5c5b0ab0a4";
                                // print(_myWalletController.intSelected.value);
                              },
                              child: DisplayBusinessType(
                                text: "Pet food",
                              ),
                            ),
                    ),

                    SizedBox(
                      width: 3.w,
                    ),
                  ],
                ),
              ),
              Obx(
                () => (_myWalletController.myWalletModel.value?.data == null ||
                        _myWalletController.myWalletModel.value?.data?.length ==
                            0)
                    ? EmptyHistoryPage(
                        text1: "You Don't have any stores yet",
                        text2: "Add stores to get the Cashback",
                        text3: "",
                        icon: Icons.currency_rupee_sharp,
                      )
                    : Obx(
                        () => ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: _myWalletController
                                      .selectBusineesTypeId.value ==
                                  ''
                              ? _myWalletController.myWalletModel.value?.data
                                      ?.where((c) => c.deactivated == false)
                                      .toList()
                                      .length ??
                                  0
                              : _myWalletController.myWalletModel.value?.data
                                      ?.where((c) =>
                                          c.deactivated == false &&
                                          c.totalCashbackSubBusinessType!.first
                                                  .subBusinessType ==
                                              _myWalletController
                                                  .selectBusineesTypeId.value)
                                      .toList()
                                      .length ??
                                  0,
                          itemBuilder: (context, index) {
                            print(_myWalletController.selectBusineesTypeId);
                            return InkWell(
                              onTap: () {
                                RedeemCashInStorePageData payviewData =
                                    RedeemCashInStorePageData(
                                        name: _myWalletController.myWalletModel
                                            .value!.data![index].name,
                                        sId: _myWalletController.myWalletModel
                                            .value!.data![index].sId,
                                        // storeType: _myWalletController
                                        //     .myWalletModel
                                        //     .value!
                                        //     .data![index]
                                        //     .storeType,
                                        // earnedCashback: _myWalletController
                                        //     .myWalletModel
                                        //     .value!
                                        //     .data![index]
                                        //     .earnedCashback,
                                        // updatedAt: _myWalletController
                                        //     .myWalletModel
                                        //     .value!
                                        //     .data![index]
                                        //     .updatedAt,
                                        // distance: _myWalletController
                                        //     .myWalletModel
                                        //     .value!
                                        //     .data![index]
                                        //     .distance,
                                        // logo: _myWalletController.myWalletModel
                                        //     .value!.data![index].logo,
                                        // // businesstype: _myWalletController.myWalletModel.value!.data![index].storeType,
                                        // actual_cashback: _myWalletController
                                        //     .myWalletModel
                                        //     .value!
                                        //     .data![index]
                                        //     .earnedCashback,
                                        // premium: _myWalletController.myWalletModel.value!.data![index].premium,
                                        welcomeOfferAmount: _myWalletController
                                            .myWalletModel
                                            .value!
                                            .data![index]
                                            .welcomeOfferAmount);
                                _paymentController
                                    .redeemCashInStorePageDataIndex
                                    .value = payviewData;

                                Get.toNamed(AppRoutes.PayView, arguments: {});
                              },
                              child: Obx(
                                () => ListOfAllWallets(
                                  walletData: _myWalletController
                                              .selectBusineesTypeId.value ==
                                          ''
                                      ? _myWalletController
                                          .myWalletModel.value!.data!
                                          .where((c) => c.deactivated == false)
                                          .toList()[index]
                                      : _myWalletController
                                          .myWalletModel.value!.data!
                                          .where((c) =>
                                              c.deactivated == false &&
                                              c.totalCashbackSubBusinessType!
                                                      .first.subBusinessType ==
                                                  _myWalletController
                                                      .selectBusineesTypeId
                                                      .value)
                                          .toList()[index],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox();
                          },
                        ),
                      ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ListOfAllWallets extends StatelessWidget {
  WalletData walletData;

  ListOfAllWallets({
    Key? key,
    required this.walletData,
  }) : super(key: key);

  final MyWalletController _myWalletController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.5.h, horizontal: 1.w),
      child: Column(
        children: [
          ListViewStoreDetails(
            logo: "${walletData.logo ?? ""}",
            // color: color,
            // isDisplayDistance: true,
            // StoreID: "${storeSearchModel.sId ?? ""}",
            StoreName: "${walletData.name ?? ""}",
            distance: walletData.distance ?? 0,
            balance: (walletData.earnedCashback ?? 0) +
                (walletData.welcomeOfferAmount ?? 0),
          ),
        ],
      ),
    );
  }
}

class ListOfAllWalletsShimmer extends StatelessWidget {
  ListOfAllWalletsShimmer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.5.h, horizontal: 1.w),
      child: Column(
        children: [
          ShimmerEffect(
            child: ListViewStoreDetailsShimmer(
              logo: "",
              // color: color,
              // isDisplayDistance: true,
              // StoreID: "${storeSearchModel.sId ?? ""}",
              StoreName: "",
            ),
          ),
        ],
      ),
    );
  }
}

class ListViewStoreDetails extends StatelessWidget {
  String? StoreName;
  String? logo;
  num? distance;
  num? balance;

  ListViewStoreDetails(
      {Key? key, this.StoreName, this.distance = 0, this.logo, this.balance})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.5.h),
      child: Row(
        children: [
          DispalyStoreLogo(
            logo: logo ?? "",
            bottomPadding: 0,
            height: 10,
          ),
          SizedBox(
            width: 3.w,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              DisplayStoreName(name: StoreName),
              SizedBox(
                height: 0.5.h,
              ),
              DisplayDistance(
                distance: distance,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 0.5.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    DisplayPreminumStore(),
                    SizedBox(
                      width: 3.w,
                    ),
                    Text(
                      "Balance: \u{20b9}${balance?.toStringAsFixed(2)}",
                      style: TextStyle(
                        color: AppConst.black,
                        fontSize: 11.sp,
                        fontFamily: 'MuseoSans',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class ListViewStoreDetailsShimmer extends StatelessWidget {
  String? StoreName;
  String? logo;
  num? distance;
  num? balance;

  ListViewStoreDetailsShimmer(
      {Key? key, this.StoreName, this.distance = 0, this.logo, this.balance})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.5.h),
      child: Row(
        children: [
          DispalyStoreLogo(
            logo: logo ?? "",
            bottomPadding: 0,
          ),
          SizedBox(
            width: 4.w,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ShimmerEffect(
                    child: Container(
                      height: 20,
                      width: 50.w,
                      color: AppConst.grey,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    height: 20,
                    width: 40,
                    color: AppConst.grey,
                  )

                  // Text(
                  //   "${(distance!.toInt() / 1000).toStringAsFixed(2)} km",
                  //   style: TextStyle(
                  //     color: Colors.grey,
                  //     fontSize: 10,
                  //     fontFamily: 'MuseoSans',
                  //     fontWeight: FontWeight.w500,
                  //   ),
                  // ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 1.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      color: AppConst.grey,
                      height: 20,
                      width: 150,
                    ),
                    SizedBox(
                      width: 3.w,
                    ),
                    Text(
                      "",
                      style: TextStyle(
                        color: AppConst.black,
                        fontSize: 11.sp,
                        fontFamily: 'MuseoSans',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class DisplayBusinessType extends StatelessWidget {
  String? text;
  DisplayBusinessType({Key? key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4), color: AppConst.white),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(FontAwesomeIcons.crown, size: 1.8.h, color: AppConst.grey),
          SizedBox(
            width: 2.w,
          ),
          Text(text ?? "",
              style: TextStyle(
                fontFamily: 'MuseoSans',
                color: Color(0xff462f03),
                fontSize: 10.sp,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.normal,
              )),
        ],
      ),
    );
  }
}

class SelectedDisplayBusinessType extends StatelessWidget {
  String? text;
  SelectedDisplayBusinessType({Key? key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4), color: AppConst.grey),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(FontAwesomeIcons.crown, size: 1.8.h, color: AppConst.white),
          SizedBox(
            width: 2.w,
          ),
          Text(text ?? "",
              style: TextStyle(
                fontFamily: 'MuseoSans',
                color: ColorConstants.white,
                fontSize: 10.sp,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.normal,
              )),
        ],
      ),
    );
  }
}

class ClaimMoreButton extends StatelessWidget {
  final MyWalletController _myWalletController = Get.find();
  final AddLocationController _addLocationController = Get.find();
  ClaimMoreButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppConst.white,
      child: Padding(
        padding: EdgeInsets.only(
          left: 4.w,
          top: 2.h,
          right: 3.w,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                new Text("Extra Balance",
                    style: TextStyle(
                      fontFamily: 'MuseoSans',
                      color: Color(0xff000000),
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                    )),
                new Text("Want to claim more offers. Click here",
                    style: TextStyle(
                      fontFamily: 'MuseoSans',
                      color: Color(0xff9e9e9e),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.normal,
                    ))
              ],
            ),
            Obx(
              (() => (_addLocationController.isGpson.value == true)
                  ? GestureDetector(
                      onTap: () async {
                        _addLocationController
                            .getCurrentLocation2()
                            .then((value) async {
                          UserViewModel.setLocation(LatLng(
                              _addLocationController.currentPosition.latitude,
                              _addLocationController
                                  .currentPosition.longitude));
                          await _myWalletController
                              .getAllWalletByCustomerByBusinessType();
                          int? value = await _myWalletController
                              .updateBusinesstypeWallets();
                          if (value != null) {
                            _addLocationController.isRecentAddress.value =
                                false;
                            Get.toNamed(
                              AppRoutes.SelectBusinessType,
                            );
                          }
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: AppConst.green,
                            borderRadius: BorderRadius.circular(8)),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 3.w, vertical: 1.h),
                          child: Center(
                            child: Text(
                              'Claim More',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontFamily: 'MuseoSans',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  : InkWell(
                      onTap: (() {
                        _addLocationController.getCurrentLocation2();
                      }),
                      child: Container(
                        decoration: BoxDecoration(
                            color: AppConst.darkGreen,
                            borderRadius: BorderRadius.circular(8)),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 3.w, vertical: 1.h),
                          child: Center(
                            child: Text(
                              'Enable Location',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontFamily: 'MuseoSans',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )),
            )
          ],
        ),
      ),
    );
  }
}

class ClaimMoreButtonShimmer extends StatelessWidget {
  final MyWalletController _myWalletController = Get.find();
  final AddLocationController _addLocationController = Get.find();

  ClaimMoreButtonShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppConst.white,
      child: Padding(
        padding: EdgeInsets.only(left: 4.w, top: 2.h, right: 3.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ShimmerEffect(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: AppConst.grey,
                    height: 15,
                    width: 100,
                    child: Text(
                      "",
                      style: TextStyle(
                        fontFamily: 'MuseoSans',
                        color: Color(0xff000000),
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    color: AppConst.grey,
                    height: 10,
                    width: 150,
                    child: Text(
                      "",
                      style: TextStyle(
                        fontFamily: 'MuseoSans',
                        color: Color(0xff000000),
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () async {},
                child: ShimmerEffect(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppConst.green,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 3.w,
                        vertical: 1.h,
                      ),
                      child: Center(
                        child: Text(
                          'Claim More',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontFamily: 'MuseoSans',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DisplayAmountAndSkipButton extends StatelessWidget {
  num? walletAmount;
  DisplayAmountAndSkipButton({Key? key, this.walletAmount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 4.w, top: 2.h, right: 3.w, bottom: 2.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                  text: new TextSpan(children: [
                new TextSpan(
                    text: "\u{20b9}",
                    style: TextStyle(
                      fontFamily: 'Inter',
                      color: AppConst.acentGreen,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                    )),
                new TextSpan(
                    text: "${walletAmount?.toStringAsFixed(2)}",
                    style: TextStyle(
                      fontFamily: 'MuseoSans',
                      color: AppConst.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                    )),
              ])),
              Text("Balance available to claim",
                  style: TextStyle(
                    fontFamily: 'MuseoSans',
                    color: AppConst.white,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                  ))
            ],
          ),
          GestureDetector(
            onTap: () {
              Get.offAllNamed(AppRoutes.BaseScreen);
            },
            child: Container(
              decoration: BoxDecoration(
                  color: AppConst.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.w),
                child: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(" Skip & Continue ",
                          style: TextStyle(
                            fontFamily: 'MuseoSans',
                            color: AppConst.white,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                          )),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 2.h,
                        color: AppConst.white,
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class DisplayAmountAndSkipButtonShimmer extends StatelessWidget {
  final num? walletAmount;

  DisplayAmountAndSkipButtonShimmer({Key? key, this.walletAmount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 4.w, top: 2.h, right: 3.w, bottom: 2.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ShimmerEffect(
            child: Container(
              width: 100.0, // Adjust the width as needed
              height: 24.0, // Adjust the height as needed
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4.0),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: ShimmerEffect(
              child: Container(
                decoration: BoxDecoration(
                  color: AppConst.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.w),
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          " Skip & Continue ",
                          style: TextStyle(
                            fontFamily: 'MuseoSans',
                            color: AppConst.white,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 2.h,
                          color: AppConst.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
