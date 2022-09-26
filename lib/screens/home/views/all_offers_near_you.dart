import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/constants/string_resources.dart';
import 'package:customer_app/data/repositories/new_main_api.dart';
import 'package:customer_app/screens/base_screen.dart';
import 'package:customer_app/widgets/copied/offer_list_tile.dart';
import 'package:customer_app/widgets/gradient_button.dart';
import 'package:customer_app/widgets/screenLoader.dart';
import 'package:get/get.dart';

var offersNearYouStores = <StoreModel?>[].obs;

class AllOffersNearYou extends StatefulWidget {
  @override
  _AllOffersNearYouState createState() => _AllOffersNearYouState();
}

class _AllOffersNearYouState extends State<AllOffersNearYou> {
  getData() async {
    await NewApi.getAllCategories();
    offersNearYouStores.addAll(await NewApi.get39_AllOffersNearYouData());
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    offersNearYouStores.clear();
    super.initState();
    getData();
  }

  bool loading = true;
  bool screenLoading = false;
  loadScreen() => setState(() => screenLoading = !screenLoading);
  @override
  Widget build(BuildContext context) {
    num total = 0;
    offersNearYouStores.forEach((element) {
      num offer = element!.defaultWelcomeOffer!;
      final today = DateTime.now();
      if (element.promotionWelcomeOfferStatus == 'active') {
        {
          offer = element.promotionWelcomeOffer!;
        }
      }
      total += offer;
    });
    return IsScreenLoading(
      screenLoading: screenLoading,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'All offers near your area',
            style: AppConst.appbarTextStyle,
          ),
          automaticallyImplyLeading: false,
        ),
        body: loading
            ? SpinKitDualRing(color: AppConst.themePurple)
            : Container(
                padding: const EdgeInsets.all(10),
                child: SafeArea(
                  child: DefaultTabController(
                    length: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'We found ${StringResources.rupee}$total+ rewards for you',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ButtonsTabBar(
                          backgroundColor: AppConst.darkGrey,
                          unselectedBackgroundColor: AppConst.white,
                          unselectedLabelStyle:
                              TextStyle(color: AppConst.black),
                          radius: 20,
                          borderColor: AppConst.lightGrey,
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          borderWidth: 1,
                          labelStyle: TextStyle(
                              color: AppConst.white,
                              fontWeight: FontWeight.bold),
                          tabs: [
                            Tab(
                              text: 'All',
                            ),
                            Tab(
                              text: 'Grocery',
                            ),
                            Tab(
                              text: 'Fresh',
                            ),
                            Tab(
                              text: 'Restaurant',
                            ),
                            Tab(
                              text: 'Pharmacy',
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Obx(() => Expanded(
                                child: TabBarView(
                              children: [
                                PawPaw(data: offersNearYouStores),
                                PawPaw(
                                    data: offersNearYouStores
                                        .where((element) =>
                                            element!.businesstypeId ==
                                            '5fde415692cc6c13f9e879fd')
                                        .toList()),
                                PawPaw(
                                    data: offersNearYouStores
                                        .where((element) =>
                                            element!.businesstypeId ==
                                            '5fdf434058a42e05d4bc2044')
                                        .toList()),
                                PawPaw(
                                    data: offersNearYouStores
                                        .where((element) =>
                                            element!.businesstypeId ==
                                            '5fe0bfef4657be045655cf4a')
                                        .toList()),
                                PawPaw(
                                    data: offersNearYouStores
                                        .where((element) =>
                                            element!.businesstypeId ==
                                            '5fe22e111df87913f06a4cc9')
                                        .toList()),
                              ],
                            ))),
                        GradientButton(
                          onTap: () async {
                            loadScreen();
                            await NewApi.get39_BtnAddAll();
                            loadScreen();
                            Get.offAll(() => BaseScreen());
                          },
                          height: 40,
                          label: 'Claim all Rewards',
                          fontStyle: AppConst.titleText1White,
                        )
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}

class PawPaw extends StatelessWidget {
  final List data;
  const PawPaw({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          return OfferListTile(
            data: data[index],
          );
        });
  }
}
