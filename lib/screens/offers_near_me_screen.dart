import 'package:flutter/material.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/constants/string_constants.dart';
import 'package:sizer/sizer.dart';
import 'all_offers_screen.dart';

class OffersNearMeScreen extends StatefulWidget {
  const OffersNearMeScreen({Key? key}) : super(key: key);

  @override
  _OffersNearMeScreenState createState() => _OffersNearMeScreenState();
}

class _OffersNearMeScreenState extends State<OffersNearMeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = new TabController(length: 7, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.location_on_rounded,
                        color: AppConst.kPrimaryColor,
                        size: 22,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        StringContants.orderScreenAddress,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 15.sp,
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 2.0),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.search),
                      splashRadius: 25,
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(maxWidth: 30),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Material(
              color: AppConst.kSecondaryColor,
              child: TabBar(
                unselectedLabelColor: AppConst.lightGrey,
                labelColor: AppConst.white,
                indicatorColor: AppConst.white,
                isScrollable: true,
                tabs: [
                  Tab(
                    text: 'All',
                  ),
                  Tab(
                    text: 'For You',
                  ),
                  Tab(
                    text: 'Hot',
                  ),
                  Tab(
                    text: 'New',
                  ),
                  Tab(
                    text: 'Beverages',
                  ),
                  Tab(
                    text: 'New',
                  ),
                  Tab(
                    text: 'Beverages',
                  ),
                ],
                controller: _tabController,
                indicatorSize: TabBarIndicatorSize.tab,
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  AllOffersScreen(),
                  Text('Person'),
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppConst.kPrimaryColor,
                    ),
                    child: InkWell(),
                  ),
                  Text('Person'),
                  Text('Person'),
                  Text('Person'),
                  Text('Person')
                ],
                controller: _tabController,
              ),
            ),
          ],
        ),
      )),
    );
  }
}
