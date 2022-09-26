import 'package:flutter/material.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/constants/string_resources.dart';
import 'package:customer_app/data/repositories/new_main_api.dart';
import 'package:customer_app/widgets/copied/circle_image_widget.dart';

class StoreShopNowTile extends StatelessWidget {
  final String? title;
  final String? image;
  final String? walletAmount;
  final double? calculatedDistance;
  final num? defaultCashBack;
  final num? welcomeOffer;
  final bool? isInStore;

  StoreShopNowTile({
    @required this.title,
    this.image,
    this.walletAmount,
    this.calculatedDistance,
    this.defaultCashBack,
    this.welcomeOffer,
    this.isInStore: false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(0.0),
      leading: CircleImageWidget(
        image: image,
      ),
      title: Text(
        title!,
        style: AppConst.header,
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Visibility(
            visible: (defaultCashBack ?? 0) > 0,
            child: Text(
              'Cashback: ${defaultCashBack?.toString() ?? 0}%',
              style: AppConst.descriptionTextPurple,
            ),
          ),
          Visibility(
            visible: isInStore ?? false,
            child: Container(
              margin: const EdgeInsets.only(top: 4.0),
              padding:
                  const EdgeInsets.symmetric(horizontal: 4.0, vertical: 6.0),
              decoration: BoxDecoration(
                color: AppConst.themePurple,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Text("In store order",
                  style:
                      AppConst.descriptionText.copyWith(color: AppConst.white)),
            ),
          )
        ],
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Visibility(
            visible: calculatedDistance != null,
            child: Text(
              'Distance: ${((calculatedDistance ?? 0) / 1000).toStringAsFixed(2)} KM',
              style: AppConst.descriptionTextPurple,
            ),
          ),
          Visibility(
            visible: walletAmount != null,
            child: Text(
              'Wallet: ${walletAmount ?? '0'} ' + StringResources.rupee,
              style: AppConst.descriptionTextPurple,
            ),
          ),
          Visibility(
            visible: welcomeOffer != null,
            child: Text(
              'Welcome Offer: ${welcomeOffer ?? 0} ' + StringResources.rupee,
              style: AppConst.descriptionTextPurple,
            ),
          ),
        ],
      ),
    );
  }
}

class StoreShopNowTile2 extends StatelessWidget {
  final String? label;
  final StoreModel? boomModel;

  StoreShopNowTile2({this.label, this.boomModel});

  @override
  Widget build(BuildContext context) {
    num cashBack = 0;
    if (boomModel != null) {
      cashBack = boomModel!.cashback!;
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleImageWidget(
              image: boomModel == null
                  ? 'https://i0.wp.com/deltacollegian.net/wp-content/uploads/2017/05/adidas.png?fit=880%2C660'
                  : boomModel!.logo,
            ),
            SizedBox(
              width: 8,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    width: 150,
                    child: Text(
                      boomModel == null ? label! : boomModel!.name!,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Stag',
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Text(
                    '10% Cashback',
                    style: TextStyle(
                        fontSize: 8,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'OpenSans',
                        color: AppConst.kPrimaryColor),
                  ),
                ),
                Container(
                  width: 70,
                  height: 15,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: AppConst.themePurple,
                  ),
                  child: Center(
                    child: Text(
                      boomModel! == null
                          ? label!
                          : '${boomModel!.store_type} order',
                      style: TextStyle(color: AppConst.white, fontSize: 10),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '$cashBack ${StringResources.rupee}',
              style: AppConst.titleText2Purple,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Text('You earned 35.00',
                  style: TextStyle(
                      fontSize: 10,
                      color: Color(0xff252525),
                      fontFamily: 'Stag',
                      letterSpacing: 0.3,
                      fontWeight: FontWeight.w600)),
            ),
            Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  color: AppConst.themePurple,
                  size: 15,
                ),
                Text(
                    boomModel! == null
                        ? label!
                        : '${(boomModel!.calculated_distance! / 1000).toStringAsFixed(2)} km',
                    style: TextStyle(
                        fontSize: 10,
                        color: AppConst.black,
                        fontFamily: 'Stag',
                        letterSpacing: 0.3,
                        fontWeight: FontWeight.w600)),
              ],
            )
          ],
        )
      ],
    );
  }
}

class StoreShopNowTile3 extends StatelessWidget {
  final String? label;

  StoreShopNowTile3({this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleImageWidget(
              image:
                  'https://i0.wp.com/deltacollegian.net/wp-content/uploads/2017/05/adidas.png?fit=880%2C660',
            ),
            SizedBox(
              width: 8,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label!,
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Stag',
                  ),
                ),
                Text(
                  '10% Cashback',
                  style: TextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'OpenSans',
                      color: Color(0xffEE1717)),
                )
              ],
            )
          ],
        ),
        Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
              shape: BoxShape.circle, color: AppConst.themePurple),
          child: Center(
            child: Icon(
              Icons.message_rounded,
              color: AppConst.white,
              size: 16,
            ),
          ),
        )
      ],
    );
  }
}
