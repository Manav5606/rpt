import 'package:flutter/material.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/data/repositories/new_main_api.dart';
import 'package:customer_app/utils/ui_spacing_helper.dart';
import 'package:get/get.dart';
import 'package:customer_app/widgets/top_picks_card_widget.dart';

import 'package:customer_app/data/repositories/new_main_api.dart';

class StoreGridList extends StatelessWidget {
  final List<StoreModel>? data;
  final Function(StoreModel)? onClick;

  const StoreGridList({@required this.data, this.onClick, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: .9,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: data!.length,
        itemBuilder: (_, index) => GestureDetector(
              onTap: () {
                if (onClick != null) {
                  onClick!(data![index]);
                }
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(child: TopPickCardWidget(storeModel: data![index])),
                  UISpacingHelper.verticalSpace12,
                  Text(
                    data![index].name!,
                    style: AppConst.header2,
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ));
  }
}
