import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/constants/app_const.dart';

import 'package:customer_app/constants/string_constants.dart';
import 'package:customer_app/data/popularsearchdata.dart';
import 'package:customer_app/data/popularsearchmodel.dart';
import 'package:customer_app/theme/styles.dart';
import 'package:customer_app/app/ui/pages/location_picker/address_model.dart';

import 'package:customer_app/widgets/backButton.dart';
import 'package:customer_app/widgets/popularSearchList.dart';
import 'package:customer_app/widgets/search_field.dart';
import 'package:customer_app/widgets/storesearchfield.dart';

class PopularSearchScreen extends StatefulWidget {
  @override
  State<PopularSearchScreen> createState() => _PopularSearchScreenState();
}

class _PopularSearchScreenState extends State<PopularSearchScreen> {
  List<PopularSearchModel>? foundStores;
  List<PopularSearchModel> popularData = popularSearchData;
  @override
  void initState() {
    super.initState();
    setState(() {
      foundStores = popularData;
    });
  }

  onSearch(String name) {
    setState(() {
      foundStores = popularData
          .where((store) => store.storename!.toLowerCase().contains(name))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeUtils().init(context);

    return Scaffold(
        body: SafeArea(
      minimum: EdgeInsets.only(
          top: SizeUtils.horizontalBlockSize * 3.82,
          left: SizeUtils.horizontalBlockSize * 2.55,
          right: SizeUtils.horizontalBlockSize * 2.55),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: SizeUtils.horizontalBlockSize * 15,
            decoration: BoxDecoration(color: AppConst.white, boxShadow: [
              BoxShadow(
                  color: AppConst.grey.withOpacity(0.5),
                  spreadRadius: -3,
                  blurRadius: 5,
                  offset: Offset(0, 3)),
            ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BackButtonWidget(),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        useRootNavigator: true,
                        builder: (context) {
                          return AddressModel();
                        });
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.location_on_rounded,
                        color: AppConst.kPrimaryColor,
                        size: SizeUtils.horizontalBlockSize * 5.6,
                      ),
                      SizedBox(
                        width: SizeUtils.horizontalBlockSize * 2.1,
                      ),
                      Text(
                        StringContants.orderScreenAddress,
                        style: AppStyles.ADDRESS_STYLE,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Icon(Icons.keyboard_arrow_down_outlined),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: SizeUtils.horizontalBlockSize * 5,
          ),
          Container(
              height: SizeUtils.horizontalBlockSize * 10,
              width: SizeUtils.horizontalBlockSize * 90,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: AppConst.black,
                  ),
                  borderRadius: BorderRadius.circular(
                      SizeUtils.horizontalBlockSize * 2.55)),
              child: TextField(
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                      suffixIcon: Icon(
                        Icons.search,
                        color: AppConst.black,
                      ),
                      counterText: "",
                      border: InputBorder.none,
                      hintTextDirection: TextDirection.ltr,
                      hintText: " Search products,stores & recipes",
                      hintStyle: TextStyle(
                          color: AppConst.grey,
                          fontSize: SizeUtils.horizontalBlockSize * 4)),
                  showCursor: true,
                  cursorColor: AppConst.black,
                  cursorHeight: SizeUtils.horizontalBlockSize * 6,
                  maxLength: 30,
                  onChanged: (value) => onSearch(value))),
          SizedBox(
            height: SizeUtils.horizontalBlockSize * 5,
          ),
          Text(
            'Popular Searches',
            style: AppStyles.STORE_NAME_STYLE,
          ),
          SizedBox(
            height: SizeUtils.horizontalBlockSize * 5,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: PopularSearchList(
                foundedStores: foundStores,
              ),
            ),
          )
        ],
      ),
    ));
  }
}
