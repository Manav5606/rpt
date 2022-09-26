import 'package:flutter/material.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/data/search_results_data.dart';
import 'package:customer_app/widgets/search_field.dart';
import 'package:customer_app/widgets/search_result_widget.dart';

class SearchResultScreen extends StatelessWidget {
  SearchResultScreen({Key? key}) : super(key: key);

  final textFieldFocusNode = FocusNode();
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
          padding: EdgeInsets.only(top: 15, left: 10, right: 10),
          child: Column(
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
                suffixIcon: GestureDetector(
                  onTap: () {
                    _searchController.clear();
                  },
                  child: Icon(
                    Icons.close,
                    color: AppConst.darkGrey,
                    size: 20,
                  ),
                ),
              ),
              Expanded(
                child: ListView.separated(
                    padding: EdgeInsets.only(top: 20, bottom: 20),
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: 15,
                      );
                    },
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return SearchResultWidget(result: searchResults[index]);
                    },
                    itemCount: searchResults.length),
              )
            ],
          )),
    ));
  }
}
