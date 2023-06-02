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
  final HomeController _homeController = Get.put(HomeController());

  final PaymentController _paymentController = Get.put(PaymentController());
  final AddCartController _addCartController = Get.put(AddCartController());
  final MyAccountController _myAccountController =
      Get.put(MyAccountController(MyAccountRepository(), HiveRepository()));
  final freshChatController _freshChat = Get.put(freshChatController());
  final UserViewModel userViewModel = Get.put(UserViewModel());
  final MoreStoreController _moreStoreController =
      Get.put(MoreStoreController());

  @override
  Widget build(BuildContext context) {
    _myWalletController.walletbalanceOfBusinessType.value =
        _myWalletController.StoreTotalWelcomeAmount();

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
                  Obx(
                    () => DisplayAmountAndSkipButton(
                      walletAmount:
                          _myWalletController.walletbalanceOfBusinessType.value,
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
                    PayAtStore(),
                    ScanReceiptStores(),
                    RecentOrdersAndStores()
                  ]))
                ],
              ),
            ),
          ),
        ));
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
                    itemCount:
                        _myWalletController.myWalletModel.value?.data?.length ??
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
                                  storeType: _myWalletController.myWalletModel
                                      .value!.data![index].storeType,
                                  earnedCashback: _myWalletController
                                      .myWalletModel
                                      .value!
                                      .data![index]
                                      .earnedCashback,
                                  updatedAt: _myWalletController.myWalletModel
                                      .value!.data![index].updatedAt,
                                  distance: _myWalletController.myWalletModel
                                      .value!.data![index].distance,
                                  logo: _myWalletController
                                      .myWalletModel.value!.data![index].logo,
                                  // businesstype: _myWalletController.myWalletModel.value!.data![index].storeType,
                                  actual_cashback: _myWalletController
                                      .myWalletModel
                                      .value!
                                      .data![index]
                                      .earnedCashback,
                                  premium: _myWalletController.myWalletModel
                                      .value!.data![index].premium,
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
                              .myWalletModel.value!.data![index],
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

class RecentOrdersAndStores extends StatelessWidget {
  RecentOrdersAndStores({
    Key? key,
  }) : super(key: key);
  final MyWalletController _myWalletController = Get.find();
  final MoreStoreController _moreStoreController = Get.find();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: AppConst.white,
        child: Obx(
          () => _myWalletController.isLoading.value
              ? Container(height: 90.h, child: LoadingWidget())
              : (_myWalletController.myWalletModel.value?.data == null ||
                      _myWalletController.myWalletModel.value?.data?.length ==
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
                              .myWalletModel.value?.data?.length ??
                          0,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () async {
                            _moreStoreController.storeId.value =
                                _myWalletController.myWalletModel.value!
                                        .data![index].sId ??
                                    '';
                            await _moreStoreController.getStoreData(
                                id: _myWalletController.myWalletModel.value!
                                        .data![index].sId ??
                                    '',
                                businessId: '');
                          },
                          child: ListOfAllWallets(
                            walletData: _myWalletController
                                .myWalletModel.value!.data![index],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox();
                      },
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
              Obx(
                () => _myWalletController.isLoading.value
                    ? Center(child: ListViewShimmer())
                    : (_myWalletController.myWalletModel.value?.data == null ||
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
                                    .myWalletModel.value?.data?.length ??
                                0,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  RedeemCashInStorePageData payviewData =
                                      RedeemCashInStorePageData(
                                          name: _myWalletController
                                              .myWalletModel
                                              .value!
                                              .data![index]
                                              .name,
                                          sId: _myWalletController.myWalletModel
                                              .value!.data![index].sId,
                                          storeType: _myWalletController
                                              .myWalletModel
                                              .value!
                                              .data![index]
                                              .storeType,
                                          earnedCashback: _myWalletController
                                              .myWalletModel
                                              .value!
                                              .data![index]
                                              .earnedCashback,
                                          updatedAt: _myWalletController
                                              .myWalletModel
                                              .value!
                                              .data![index]
                                              .updatedAt,
                                          distance: _myWalletController
                                              .myWalletModel
                                              .value!
                                              .data![index]
                                              .distance,
                                          logo: _myWalletController
                                              .myWalletModel
                                              .value!
                                              .data![index]
                                              .logo,
                                          // businesstype: _myWalletController.myWalletModel.value!.data![index].storeType,
                                          actual_cashback: _myWalletController
                                              .myWalletModel
                                              .value!
                                              .data![index]
                                              .earnedCashback,
                                          premium: _myWalletController.myWalletModel.value!.data![index].premium,
                                          welcomeOfferAmount: _myWalletController.myWalletModel.value!.data![index].welcomeOfferAmount);
                                  _paymentController
                                      .redeemCashInStorePageDataIndex
                                      .value = payviewData;

                                  Get.toNamed(AppRoutes.PayView, arguments: {});
                                },
                                child: ListOfAllWallets(
                                  walletData: _myWalletController
                                      .myWalletModel.value!.data![index],
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox();
                            },
                          ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget ListViewShimmer() {
    return ShimmerEffect(
      child: ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: _myWalletController.myWalletModel.value?.data?.length ?? 0,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              RedeemCashInStorePageData payviewData = RedeemCashInStorePageData(
                  name: _myWalletController
                      .myWalletModel.value!.data![index].name,
                  sId:
                      _myWalletController.myWalletModel.value!.data![index].sId,
                  storeType: _myWalletController
                      .myWalletModel.value!.data![index].storeType,
                  earnedCashback: _myWalletController
                      .myWalletModel.value!.data![index].earnedCashback,
                  updatedAt: _myWalletController
                      .myWalletModel.value!.data![index].updatedAt,
                  distance: _myWalletController
                      .myWalletModel.value!.data![index].distance,
                  logo: _myWalletController
                      .myWalletModel.value!.data![index].logo,
                  // businesstype: _myWalletController.myWalletModel.value!.data![index].storeType,
                  actual_cashback: _myWalletController
                      .myWalletModel.value!.data![index].earnedCashback,
                  premium: _myWalletController
                      .myWalletModel.value!.data![index].premium,
                  welcomeOfferAmount: _myWalletController
                      .myWalletModel.value!.data![index].welcomeOfferAmount);
              _paymentController.redeemCashInStorePageDataIndex.value =
                  payviewData;

              Get.toNamed(AppRoutes.PayView, arguments: {});
            },
            child: ListOfAllWallets(
              walletData: _myWalletController.myWalletModel.value!.data![index],
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
            // Balance: (storeSearchModel.earnedCashback ?? 0) +
            //     (storeSearchModel.welcomeOfferAmount ?? 0)),
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

  ListViewStoreDetails({Key? key, this.StoreName, this.distance = 0, this.logo})
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
                  Container(
                    width: 60.w,
                    child: Text(StoreName ?? "Sreeja Kirana & General Stores",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: 'MuseoSans',
                          color: AppConst.black,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.normal,
                        )),
                  ),
                  Text(
                    "${(distance!.toInt() / 1000).toStringAsFixed(2)} km",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 10,
                      fontFamily: 'MuseoSans',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 1.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    DisplayPreminumStore(),
                    SizedBox(
                      width: 3.w,
                    ),
                    DisplayFreshStore()
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
            GestureDetector(
              onTap: () async {
                UserViewModel.setLocation(LatLng(
                    _addLocationController.currentPosition.latitude,
                    _addLocationController.currentPosition.longitude));
                await _myWalletController
                    .getAllWalletByCustomerByBusinessType();
                int? value =
                    await _myWalletController.updateBusinesstypeWallets();
                if (value != null) {
                  Get.toNamed(
                    AppRoutes.SelectBusinessType,
                  );
                }
              },
              child: Container(
                decoration: BoxDecoration(
                    color: AppConst.green,
                    borderRadius: BorderRadius.circular(8)),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
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
                    text: "${walletAmount}",
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