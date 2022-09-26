import 'package:flutter/material.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/constants/string_constants.dart';
import 'package:customer_app/data/search_data.dart';
import 'package:customer_app/routes/app_list.dart';
import 'package:customer_app/screens/search/search_result_screen.dart';
import 'package:customer_app/widgets/search_field.dart';
import 'package:customer_app/widgets/search_widget.dart';
import 'package:get/route_manager.dart';
import 'package:sizer/sizer.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  final List<String> tags = [
    "Coke",
    "Lassi",
    "Chicken Biriyani",
    "Burger",
    "Pizza",
    "Chicken Roll",
  ];

  final TextEditingController _searchController = TextEditingController();
  final textFieldFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 15, left: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SearchField(
                  controller: _searchController,
                  focusNode: textFieldFocusNode,
                  prefixIcon: GestureDetector(
                    onTap: () {
                      textFieldFocusNode.unfocus();
                      textFieldFocusNode.canRequestFocus = false;

                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: AppConst.kPrimaryColor,
                      size: 20,
                    ),
                  ),
                  onEditingComplete: () => Get.toNamed(AppRoutes.SearchResult),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      StringContants.recentlySearched,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15.sp,
                      ),
                    ),
                    Text(
                      StringContants.clear,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 13.sp,
                        color: AppConst.kPrimaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Wrap(
                  spacing: 10,
                  alignment: WrapAlignment.start,
                  clipBehavior: Clip.none,
                  runSpacing: 10,
                  children: tags.map((e) {
                    return Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: AppConst.grey,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.access_time,
                              size: 15, color: AppConst.black),
                          Text(
                            " $e",
                            style: TextStyle(color: AppConst.black),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(
                  height: 20,
                ),
                RichText(
                  text: TextSpan(
                    text: StringContants.popularOn,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                      color: AppConst.black,
                    ),
                    children: [
                      TextSpan(
                        text: StringContants.receipto,
                        style: TextStyle(
                          color: AppConst.kPrimaryColor,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: 100,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return SearchWidget(
                        search: popularSearches[index],
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        width: 10,
                      );
                    },
                    itemCount: popularSearches.length,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  StringContants.popularCuisines,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 15.sp,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: 100,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return SearchWidget(
                        search: popularCuisines[index],
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        width: 10,
                      );
                    },
                    itemCount: popularCuisines.length,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
