import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:customer_app/constants/value_constants.dart';
import 'package:customer_app/utils/sort_helper.dart';
import 'package:customer_app/widgets/custom_outline_button.dart';
import 'package:customer_app/widgets/modal_sheet.dart';
import 'package:customer_app/widgets/recent_places.dart';
import 'package:customer_app/widgets/seeya_sort_widget.dart';
import 'package:customer_app/widgets/store_listing.dart';
import 'package:customer_app/widgets/tabs.dart';
import 'package:get/get.dart';
import 'package:customer_app/constants/app_const.dart';

import 'package:customer_app/data/repositories/new_main_api.dart';

class ScanReceipts extends StatefulWidget {
  @override
  _ScanReceiptsState createState() => _ScanReceiptsState();
}

class _ScanReceiptsState extends State<ScanReceipts>
    with SingleTickerProviderStateMixin {
  List<StoreModel> nearStores = [];
  List<StoreModel> favStores = [];
  List<StoreModel> allStores = [];

  List<StoreModel> favGroceries = [];
  List<StoreModel> favFresh = [];
  List<StoreModel> favPharmacy = [];
  List<StoreModel> favRestaurant = [];

  List<StoreModel> nearGroceries = [];
  List<StoreModel> nearFresh = [];
  List<StoreModel> nearPharmacy = [];
  List<StoreModel> nearRestaurant = [];

  SortWrapper<StoreModel> sortFavStores = SortWrapper<StoreModel>([]);
  SortWrapper<StoreModel> sortNearStores = SortWrapper<StoreModel>([]);
  SortWrapper<StoreModel> sortAllStores = SortWrapper<StoreModel>([]);
  SortWrapper<StoreModel> sortFavGroceries = SortWrapper<StoreModel>([]);
  SortWrapper<StoreModel> sortFavFresh = SortWrapper<StoreModel>([]);
  SortWrapper<StoreModel> sortFavPharmacy = SortWrapper<StoreModel>([]);
  SortWrapper<StoreModel> sortFavRestaurant = SortWrapper<StoreModel>([]);
  SortWrapper<StoreModel> sortNearGroceries = SortWrapper<StoreModel>([]);
  SortWrapper<StoreModel> sortNearFresh = SortWrapper<StoreModel>([]);
  SortWrapper<StoreModel> sortNearPharmacy = SortWrapper<StoreModel>([]);
  SortWrapper<StoreModel> sortNearRestaurant = SortWrapper<StoreModel>([]);

  String? sortValue;

  bool dataLoad = true;

  TabController? _tabController;
  bool fabView = true;

  getData() async {
    //favStores = (await NewApi.scanReceiptsFavStores())!;
    //nearStores = (await NewApi.scanReceiptNearMeStoreData())!;
    //allStores = await NewApi.getScanReceiptPageSpecialOffersStoresData();

    sortFavStores = SortWrapper(favStores);
    sortNearStores = SortWrapper(nearStores);
    sortAllStores = SortWrapper(allStores);

    favGroceries.addAll(allStores.where(
        (element) => element.businesstypeId == '5fde415692cc6c13f9e879fd'));
    favFresh.addAll(allStores.where(
        (element) => element.businesstypeId == '5fdf434058a42e05d4bc2044'));
    favRestaurant.addAll(allStores.where(
        (element) => element.businesstypeId == '5fe0bfef4657be045655cf4a'));
    favPharmacy.addAll(allStores.where(
        (element) => element.businesstypeId == '5fe22e111df87913f06a4cc9'));

    nearGroceries.addAll(allStores.where(
        (element) => element.businesstypeId == '5fde415692cc6c13f9e879fd'));
    nearFresh.addAll(allStores.where(
        (element) => element.businesstypeId == '5fdf434058a42e05d4bc2044'));
    nearPharmacy.addAll(allStores.where(
        (element) => element.businesstypeId == '5fe0bfef4657be045655cf4a'));
    nearRestaurant.addAll(allStores.where(
        (element) => element.businesstypeId == '5fe22e111df87913f06a4cc9'));

    sortFavGroceries = SortWrapper(favGroceries);
    sortFavFresh = SortWrapper(favFresh);
    sortFavRestaurant = SortWrapper(favRestaurant);
    sortFavPharmacy = SortWrapper(favPharmacy);
    sortNearGroceries = SortWrapper(nearGroceries);
    sortNearFresh = SortWrapper(nearFresh);
    sortNearPharmacy = SortWrapper(nearPharmacy);
    sortNearRestaurant = SortWrapper(nearRestaurant);

    _tabController = TabController(length: 2, vsync: this)
      ..addListener(() {
        if (_tabController!.index == 0) {
          setState(() {
            fabView = true;
          });
        } else {
          setState(() {
            fabView = false;
          });
        }
      });

    setState(() {
      dataLoad = false;
    });
  }

  sortAll(int Function(StoreModel a, StoreModel b) sortFunction) {
    [
      sortFavStores,
      sortNearStores,
      sortAllStores,
      sortFavGroceries,
      sortFavFresh,
      sortFavRestaurant,
      sortFavPharmacy,
      sortNearGroceries,
      sortNearFresh,
      sortNearPharmacy,
      sortNearRestaurant
    ].forEach((element) {
      element.sort(sortFunction);
    });
  }

  unsortAll() {
    [
      sortFavStores,
      sortNearStores,
      sortAllStores,
      sortFavGroceries,
      sortFavFresh,
      sortFavRestaurant,
      sortFavPharmacy,
      sortNearGroceries,
      sortNearFresh,
      sortNearPharmacy,
      sortNearRestaurant
    ].forEach((element) {
      element = element.unsort;
    });
  }

  sortAndUpdate(String sortValue) {
    setState(() {
      this.sortValue = sortValue;

      switch (sortValue) {
        case SortValue.DISTANCE:
          sortAll((a, b) =>
              a.calculated_distance!.compareTo(b.calculated_distance!));
          break;

        case SortValue.CASHBACK:
          sortAll((a, b) => a.cashback!.compareTo(b.cashback!));
          break;

        case SortValue.AZ:
          sortAll((a, b) => a.name!.compareTo(b.name!));
          break;
        default:
          sortFavStores = sortFavStores.unsort;
          sortNearStores = sortNearStores.unsort;
          sortAllStores = sortAllStores.unsort;
          sortFavGroceries = sortFavGroceries.unsort;
          sortFavFresh = sortFavFresh.unsort;
          sortFavRestaurant = sortFavRestaurant.unsort;
          sortFavPharmacy = sortFavPharmacy.unsort;
          sortNearGroceries = sortNearGroceries.unsort;
          sortNearFresh = sortNearFresh.unsort;
          sortNearPharmacy = sortNearPharmacy.unsort;
          sortNearRestaurant = sortNearRestaurant.unsort;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Text(
          'Scan Receipts',
          style: AppConst.appbarTextStyle,
        ),
        iconTheme: IconThemeData(color: AppConst.white),
        actions: [
          GestureDetector(
              onTap: () {
                //     Get.to(
                //       () => SearchStore(allStores: allStores, showButton: true));
              },
              child: Icon(CupertinoIcons.search, color: AppConst.white)),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: dataLoad
          ? SpinKitDualRing(color: AppConst.themePurple)
          : Column(
              children: [
                FavoriteAndNearbyTab(controller: _tabController!),
                SizedBox(
                  height: 15,
                ),
                Flexible(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      ListView(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              children: [
                                Text(
                                  'Recommended',
                                  style: AppConst.titleText3,
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            height: 20,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                              height: 260.0,
                              child: StoreGridList(
                                data: sortFavStores.initialData,
                                onClick: (store) {
                                  //  Get.to(TheBossCameraScreen(
                                  //  storeModel: store,
                                  // ));
                                },
                              )),
                          SizedBox(
                            height: 20,
                          ),
                          sortFavStores.initialData.length > 6
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CustomOutlineButton(
                                      onTap: () {},
                                      label: 'View all offers',
                                      height: 28,
                                      width: 160,
                                      fontStyle: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Stag'),
                                    )
                                  ],
                                )
                              : SizedBox(),
                          SizedBox(
                            height: 25,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Favourite Store Near You',
                                  style: AppConst.titleText1,
                                ),
                                SortDropDownIcon(
                                  onPress: () {
                                    SeeyaModalSheet(
                                        title: "Sort By",
                                        child: SeeyaSortWidget(
                                          defaultSorting: sortValue!,
                                          onSortApply: (value) {
                                            sortAndUpdate(value);
                                            Get.back();
                                          },
                                        )).show(context);
                                  },
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          DefaultTabController(
                            length: 5,
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                children: [
                                  BusinessButtonTab(),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Container(
                                    height: 500,
                                    child: TabBarView(
                                      children: [
                                        FavStoreListing(
                                            data: sortAllStores.sorted),
                                        FavStoreListing(
                                            data: sortFavGroceries.sorted),
                                        FavStoreListing(
                                            data: sortFavFresh.sorted),
                                        FavStoreListing(
                                            data: sortFavRestaurant.sorted),
                                        FavStoreListing(
                                            data: sortFavPharmacy.sorted),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      DefaultTabController(
                        length: 5,
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: [
                              ButtonsTabBar(
                                physics: AlwaysScrollableScrollPhysics(),
                                backgroundColor: AppConst.black,
                                unselectedBackgroundColor: AppConst.white,
                                unselectedLabelStyle:
                                    TextStyle(color: AppConst.black),
                                radius: 20,
                                borderColor: AppConst.grey,
                                unselectedBorderColor: AppConst.grey,
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 10),
                                borderWidth: 1,
                                labelStyle: TextStyle(
                                    color: AppConst.white,
                                    fontWeight: FontWeight.bold),
                                tabs: [
                                  Tab(
                                    text: "Recent",
                                  ),
                                  Tab(
                                    text: "Grocery",
                                  ),
                                  Tab(
                                    text: "Fresh",
                                  ),
                                  Tab(
                                    text: "Restaurant",
                                  ),
                                  Tab(
                                    text: "Pharmacy",
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Expanded(
                                child: TabBarView(
                                  children: [
                                    NearByStoreListing(
                                        data: sortNearStores.sorted),
                                    NearByStoreListing(
                                        data: sortNearGroceries.sorted),
                                    NearByStoreListing(
                                        data: sortNearFresh.sorted),
                                    NearByStoreListing(
                                        data: sortNearRestaurant.sorted),
                                    NearByStoreListing(
                                        data: sortNearPharmacy.sorted),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
