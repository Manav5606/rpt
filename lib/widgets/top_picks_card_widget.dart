import 'package:flutter/material.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/data/repositories/new_main_api.dart';
import 'package:customer_app/widgets/copied/circle_image_widget.dart';

class TopPickCardWidget extends StatelessWidget {
  final StoreModel? storeModel;

  TopPickCardWidget({@required this.storeModel});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          top: 0,
          child: ImageFromNetwork(
            image: storeModel!.logo!,
            height: 100.0,
            width: 100.0,
            decoration: BoxDecoration(
              color: AppConst.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppConst.veryLightGrey),
            ),
          ),
        ),
        Positioned(
            bottom: 0,
            left: 10,
            child: Container(
              height: 20,
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: AppConst.themePurple,
              ),
              child: Center(
                child: Text(
                  '${storeModel!.cashback}% cashback',
                  style: AppConst.smallBoxTextSan,
                ),
              ),
            ))
      ],
    );
  }
}
