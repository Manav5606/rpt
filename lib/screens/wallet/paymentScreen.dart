import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/theme/styles.dart';
import 'package:customer_app/widgets/arrowIcon.dart';
import 'package:customer_app/widgets/backButton.dart';

class PaymentModeScreen extends StatelessWidget {
  const PaymentModeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            minimum: EdgeInsets.only(
                top: SizeUtils.horizontalBlockSize * 3.82,
                left: SizeUtils.horizontalBlockSize * 2.55,
                right: SizeUtils.horizontalBlockSize * 2.55),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                height: SizeUtils.horizontalBlockSize * 10,
                width: double.infinity,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  BackButtonWidget(),
                  SizedBox(
                    width: SizeUtils.horizontalBlockSize * 5,
                  ),
                  Expanded(
                      child: Text(
                    "Bill Total: \u20b9250.00",
                    style: AppStyles.STORE_NAME_STYLE,
                  ))
                ]),
              ),
              SizedBox(
                height: SizeUtils.horizontalBlockSize * 3,
              ),
              Expanded(
                  child: SingleChildScrollView(
                child: Column(
                  children: [
                    RecomnendedPayment(),
                    paymentCard(),
                    paymentUPI(),
                    paymentWallets(),
                    paymentNetworking(),
                    paymentpaylater(),
                    paymentCashOnDelivery()
                  ],
                ),
              ))
            ])));
  }
}

class paymentCashOnDelivery extends StatelessWidget {
  const paymentCashOnDelivery({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeUtils.horizontalBlockSize * 40,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: SizeUtils.horizontalBlockSize * 6,
            width: SizeUtils.horizontalBlockSize * 55,
            alignment: Alignment.topLeft,
            color: AppConst.white,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                "  Cash on Delivery",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: SizeUtils.horizontalBlockSize * 8,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
          SizedBox(
            height: SizeUtils.horizontalBlockSize * 1,
          ),
          Center(
            child: Container(
              height: SizeUtils.horizontalBlockSize * 30,
              width: SizeUtils.horizontalBlockSize * 85,
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: AppConst.white,
                          child: Icon(
                            Icons.delivery_dining_outlined,
                            color: AppConst.black,
                          ),
                          radius: SizeUtils.horizontalBlockSize * 5,
                        ),
                        SizedBox(
                          width: SizeUtils.horizontalBlockSize * 3,
                        ),
                        Expanded(
                            child: Text(
                          "Cash on Delivery",
                          style: AppStyles.STORE_NAME_STYLE,
                        )),
                        ArrowForwardIcon()
                      ],
                    ),
                  ),
                  Divider(
                    thickness: SizeUtils.horizontalBlockSize * 1,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class paymentpaylater extends StatelessWidget {
  const paymentpaylater({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeUtils.horizontalBlockSize * 40,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: SizeUtils.horizontalBlockSize * 6,
            width: SizeUtils.horizontalBlockSize * 55,
            alignment: Alignment.topLeft,
            color: AppConst.white,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                "  Pay later",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: SizeUtils.horizontalBlockSize * 8,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
          SizedBox(
            height: SizeUtils.horizontalBlockSize * 1,
          ),
          Center(
            child: Container(
              height: SizeUtils.horizontalBlockSize * 30,
              width: SizeUtils.horizontalBlockSize * 85,
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: AppConst.grey,
                          backgroundImage: NetworkImage(
                              'https://aniportalimages.s3.amazonaws.com/media/details/LazyPay_Logo_BK3lJZh.jpg'),
                          radius: SizeUtils.horizontalBlockSize * 5,
                        ),
                        SizedBox(
                          width: SizeUtils.horizontalBlockSize * 3,
                        ),
                        Expanded(
                            child: Text(
                          "LazyPay",
                          style: AppStyles.STORE_NAME_STYLE,
                        )),
                        ArrowForwardIcon()
                      ],
                    ),
                  ),
                  InkWell(
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: AppConst.grey,
                          backgroundImage: NetworkImage(
                              'https://entrackr.com/wp-content/uploads/2021/12/simpl.jpg'),
                          radius: SizeUtils.horizontalBlockSize * 5,
                        ),
                        SizedBox(
                          width: SizeUtils.horizontalBlockSize * 3,
                        ),
                        Expanded(
                            child: Text(
                          "Simpl",
                          style: AppStyles.STORE_NAME_STYLE,
                        )),
                        ArrowForwardIcon()
                      ],
                    ),
                  ),
                  Divider(
                    thickness: SizeUtils.horizontalBlockSize * 1,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class paymentNetworking extends StatelessWidget {
  const paymentNetworking({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeUtils.horizontalBlockSize * 40,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: SizeUtils.horizontalBlockSize * 6,
            width: SizeUtils.horizontalBlockSize * 55,
            alignment: Alignment.topLeft,
            color: AppConst.white,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                "  Networking",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: SizeUtils.horizontalBlockSize * 8,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
          SizedBox(
            height: SizeUtils.horizontalBlockSize * 1,
          ),
          Center(
            child: Container(
              height: SizeUtils.horizontalBlockSize * 30,
              width: SizeUtils.horizontalBlockSize * 85,
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: AppConst.grey,
                          backgroundImage: NetworkImage(
                              'https://static.abplive.com/ani-images/Paytm_apr28.jpg?impolicy=abp_images&imwidth=720'),
                          radius: SizeUtils.horizontalBlockSize * 5,
                        ),
                        SizedBox(
                          width: SizeUtils.horizontalBlockSize * 3,
                        ),
                        Expanded(
                            child: Text(
                          "Networking",
                          style: AppStyles.STORE_NAME_STYLE,
                        )),
                        ArrowForwardIcon()
                      ],
                    ),
                  ),
                  Divider(
                    thickness: SizeUtils.horizontalBlockSize * 1,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class paymentWallets extends StatelessWidget {
  const paymentWallets({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeUtils.horizontalBlockSize * 40,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: SizeUtils.horizontalBlockSize * 6,
            width: SizeUtils.horizontalBlockSize * 55,
            alignment: Alignment.topLeft,
            color: AppConst.white,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                "  Wallets",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: SizeUtils.horizontalBlockSize * 8,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
          SizedBox(
            height: SizeUtils.horizontalBlockSize * 1,
          ),
          Center(
            child: Container(
              height: SizeUtils.horizontalBlockSize * 30,
              width: SizeUtils.horizontalBlockSize * 85,
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: AppConst.grey,
                          backgroundImage: NetworkImage(
                              'https://pbs.twimg.com/profile_images/1415665101470720008/ZXnjanfB_400x400.jpg'),
                          radius: SizeUtils.horizontalBlockSize * 5,
                        ),
                        SizedBox(
                          width: SizeUtils.horizontalBlockSize * 3,
                        ),
                        Expanded(
                            child: Text(
                          "Mobiwik",
                          style: AppStyles.STORE_NAME_STYLE,
                        )),
                        ArrowForwardIcon()
                      ],
                    ),
                  ),
                  InkWell(
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: AppConst.grey,
                          backgroundImage: NetworkImage(
                              'https://bfsi.eletsonline.com/wp-content/uploads/2017/03/freecharge.jpg'),
                          radius: SizeUtils.horizontalBlockSize * 5,
                        ),
                        SizedBox(
                          width: SizeUtils.horizontalBlockSize * 3,
                        ),
                        Expanded(
                            child: Text(
                          "freeCharge",
                          style: AppStyles.STORE_NAME_STYLE,
                        )),
                        ArrowForwardIcon()
                      ],
                    ),
                  ),
                  Divider(
                    thickness: SizeUtils.horizontalBlockSize * 1,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class paymentUPI extends StatelessWidget {
  const paymentUPI({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeUtils.horizontalBlockSize * 40,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: SizeUtils.horizontalBlockSize * 6,
            width: SizeUtils.horizontalBlockSize * 55,
            alignment: Alignment.topLeft,
            color: AppConst.white,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                "  UPI",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: SizeUtils.horizontalBlockSize * 8,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
          SizedBox(
            height: SizeUtils.horizontalBlockSize * 1,
          ),
          Center(
            child: Container(
              height: SizeUtils.horizontalBlockSize * 30,
              width: SizeUtils.horizontalBlockSize * 85,
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: AppConst.grey,
                          backgroundImage: NetworkImage(
                              'https://static.abplive.com/ani-images/Paytm_apr28.jpg?impolicy=abp_images&imwidth=720'),
                          radius: SizeUtils.horizontalBlockSize * 5,
                        ),
                        SizedBox(
                          width: SizeUtils.horizontalBlockSize * 3,
                        ),
                        Expanded(
                            child: Text(
                          "Paytm  UPI",
                          style: AppStyles.STORE_NAME_STYLE,
                        )),
                        ArrowForwardIcon()
                      ],
                    ),
                  ),
                  InkWell(
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: AppConst.grey,
                          backgroundImage: NetworkImage(
                              'https://storiesflistgv2.blob.core.windows.net/stories/2017/06/phonepe_mainbanner2.jpg'),
                          radius: SizeUtils.horizontalBlockSize * 5,
                        ),
                        SizedBox(
                          width: SizeUtils.horizontalBlockSize * 3,
                        ),
                        Expanded(
                            child: Text(
                          "Phonpe UPI",
                          style: AppStyles.STORE_NAME_STYLE,
                        )),
                        ArrowForwardIcon()
                      ],
                    ),
                  ),
                  Divider(
                    thickness: SizeUtils.horizontalBlockSize * 1,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class paymentCard extends StatelessWidget {
  const paymentCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeUtils.horizontalBlockSize * 40,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: SizeUtils.horizontalBlockSize * 6,
            width: SizeUtils.horizontalBlockSize * 55,
            alignment: Alignment.topLeft,
            color: AppConst.white,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                " Card",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: SizeUtils.horizontalBlockSize * 8,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
          SizedBox(
            height: SizeUtils.horizontalBlockSize * 1,
          ),
          Center(
            child: Container(
              height: SizeUtils.horizontalBlockSize * 30,
              width: SizeUtils.horizontalBlockSize * 85,
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: AppConst.grey,
                          backgroundImage: NetworkImage(
                              'https://img.freepik.com/free-vector/realistic-credit-card-design_23-2149126093.jpg?t=st=1650395189~exp=1650395789~hmac=536d8dcecfc88e4d028bc46885083eafd51045219bdd58c1a83507e215fcfcbe&w=826'),
                          radius: SizeUtils.horizontalBlockSize * 5,
                        ),
                        SizedBox(
                          width: SizeUtils.horizontalBlockSize * 3,
                        ),
                        Expanded(
                            child: Text(
                          "Add credit,debit & ATM cards",
                          style: AppStyles.STORE_NAME_STYLE,
                        )),
                        ArrowForwardIcon()
                      ],
                    ),
                  ),
                  InkWell(
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: AppConst.grey,
                          backgroundImage: NetworkImage(
                              'https://img.freepik.com/free-vector/realistic-credit-card-design_23-2149126093.jpg?t=st=1650395189~exp=1650395789~hmac=536d8dcecfc88e4d028bc46885083eafd51045219bdd58c1a83507e215fcfcbe&w=826'),
                          radius: SizeUtils.horizontalBlockSize * 5,
                        ),
                        SizedBox(
                          width: SizeUtils.horizontalBlockSize * 3,
                        ),
                        Expanded(
                            child: Text(
                          "Sodexo Meal Pass",
                          style: AppStyles.STORE_NAME_STYLE,
                        )),
                        ArrowForwardIcon()
                      ],
                    ),
                  ),
                  Divider(
                    thickness: SizeUtils.horizontalBlockSize * 1,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class RecomnendedPayment extends StatelessWidget {
  const RecomnendedPayment({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeUtils.horizontalBlockSize * 40,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: SizeUtils.horizontalBlockSize * 6,
            width: SizeUtils.horizontalBlockSize * 55,
            alignment: Alignment.topLeft,
            color: AppConst.white,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                "  Recommended",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: SizeUtils.horizontalBlockSize * 8,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
          SizedBox(
            height: SizeUtils.horizontalBlockSize * 1,
          ),
          Center(
            child: Container(
              height: SizeUtils.horizontalBlockSize * 30,
              width: SizeUtils.horizontalBlockSize * 85,
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: AppConst.grey,
                          backgroundImage: NetworkImage(
                              'https://static.abplive.com/ani-images/Paytm_apr28.jpg?impolicy=abp_images&imwidth=720'),
                          radius: SizeUtils.horizontalBlockSize * 5,
                        ),
                        SizedBox(
                          width: SizeUtils.horizontalBlockSize * 3,
                        ),
                        Expanded(
                            child: Text(
                          "Paytm",
                          style: AppStyles.STORE_NAME_STYLE,
                        )),
                        ArrowForwardIcon()
                      ],
                    ),
                  ),
                  InkWell(
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: AppConst.grey,
                          backgroundImage: NetworkImage(
                              'https://storiesflistgv2.blob.core.windows.net/stories/2017/06/phonepe_mainbanner2.jpg'),
                          radius: SizeUtils.horizontalBlockSize * 5,
                        ),
                        SizedBox(
                          width: SizeUtils.horizontalBlockSize * 3,
                        ),
                        Expanded(
                            child: Text(
                          "Phonpe",
                          style: AppStyles.STORE_NAME_STYLE,
                        )),
                        ArrowForwardIcon()
                      ],
                    ),
                  ),
                  Divider(
                    thickness: SizeUtils.horizontalBlockSize * 1,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
