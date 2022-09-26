import 'package:flutter/material.dart';
import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/constants/app_const.dart';

import 'package:customer_app/data/popularsearchmodel.dart';
import 'package:customer_app/routes/app_list.dart';
import 'package:customer_app/theme/styles.dart';
import 'package:get/get.dart';

class PopularSearchList extends StatelessWidget {
  List<PopularSearchModel>? foundedStores;
  final ScrollController? controller;
  PopularSearchList({Key? key, this.controller, required this.foundedStores})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return (foundedStores!.isEmpty)
        ? Text("No data")
        : ListView.separated(
            controller: this.controller,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: foundedStores!.length, //data.length,
            itemBuilder: (context, index) {
              return ListViewChild(
                popularSearchModel: foundedStores![index],
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(
                height: SizeUtils.horizontalBlockSize * 2.55,
              );
            },
          );
  }
}

class ListViewChild extends StatelessWidget {
  final PopularSearchModel popularSearchModel;
  const ListViewChild({Key? key, required this.popularSearchModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeUtils().init(context);

    return Column(
      children: [
        InkWell(
          onTap: () => {Get.toNamed(AppRoutes.CheckOutScreen)},
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(popularSearchModel.storelogo!),
                backgroundColor: AppConst.white,
                radius: SizeUtils.horizontalBlockSize * 7.65,
              ),
              SizedBox(
                width: SizeUtils.horizontalBlockSize * 2.55,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      popularSearchModel.storename!,
                      style: AppStyles.STORE_NAME_STYLE,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(popularSearchModel.storecashback!,
                            style: AppStyles.BOLD_STYLE_GREEN),
                      ],
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.trending_up_sharp,
                color: AppConst.grey,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
