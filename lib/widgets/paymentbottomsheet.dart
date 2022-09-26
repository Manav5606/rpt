import 'package:flutter/material.dart';
import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/screens/wallet/paysheetdata.dart';
import 'package:customer_app/theme/styles.dart';
import 'package:customer_app/widgets/arrowIcon.dart';

class PaymentBottomSheet extends StatelessWidget {
  const PaymentBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: SizeUtils.horizontalBlockSize * 25,
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppConst.lightYellow,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(SizeUtils.horizontalBlockSize * 6),
                topRight: Radius.circular(SizeUtils.horizontalBlockSize * 6)),
          ),
          child: ListTile(
            leading: Icon(
              Icons.cancel,
              color: AppConst.kPrimaryColor,
            ),
            title: Text(
              "Payment Failed",
              style: AppStyles.STORE_NAME_STYLE,
            ),
            subtitle: Text("You can choose the below payment methods"),
          ),
        ),
        SizedBox(
          height: SizeUtils.horizontalBlockSize * 5,
        ),
        Container(
            height: SizeUtils.horizontalBlockSize * 5,
            width: SizeUtils.horizontalBlockSize * 55,
            child: Text(
              "The recommended payemnts",
              style: AppStyles.BOLD_STYLE,
            )),
        Expanded(
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Container(
              padding: EdgeInsets.only(
                left: SizeUtils.horizontalBlockSize * 3,
                right: SizeUtils.horizontalBlockSize * 3,
              ),
              child: ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return SizedBox(
                      height: SizeUtils.horizontalBlockSize * 12,
                      width: MediaQuery.of(context).size.width,
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage:
                              NetworkImage(paymentOptions[index].image!),
                          radius: SizeUtils.horizontalBlockSize * 6,
                        ),
                        title: Text(
                          paymentOptions[index].name!,
                          style: AppStyles.STORE_NAME_STYLE,
                        ),
                        trailing: ArrowForwardIcon(),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider();
                  },
                  itemCount: paymentOptions.length),
            ),
          ),
        )
      ],
    );
  }
}
