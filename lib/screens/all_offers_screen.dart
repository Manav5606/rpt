import 'package:flutter/material.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/data/offera_near_me_data.dart';
import 'package:customer_app/data/models/offers_near_me_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';

class AllOffersScreen extends StatefulWidget {
  const AllOffersScreen({Key? key}) : super(key: key);

  @override
  _AllOffersScreenState createState() => _AllOffersScreenState();
}

class _AllOffersScreenState extends State<AllOffersScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: offersNearMe.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          "${offersNearMe[index].shopDetails.name}, ${offersNearMe[index].offer} off",
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: AppConst.grey,
                      ),
                    ],
                  ),
                ),
                Container(
                  height: index == 0 ? 250 : 220,
                  child: ListView.separated(
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: offersNearMe[index].products.length,
                    itemBuilder: (context, idx) {
                      Products product = offersNearMe[index].products[idx];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: index == 0
                                ? MediaQuery.of(context).size.width * .38
                                : MediaQuery.of(context).size.width * .3,
                            width: index == 0
                                ? MediaQuery.of(context).size.width * .46
                                : MediaQuery.of(context).size.width * .3,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              image: DecorationImage(
                                image: AssetImage(product.image),
                              ),
                              gradient: RadialGradient(
                                colors: [
                                  AppConst.white,
                                  AppConst.veryLightGrey,
                                ],
                                radius: 1,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            width: index == 0
                                ? MediaQuery.of(context).size.width * .46
                                : MediaQuery.of(context).size.width * .3,
                            child: Text(
                              "\$${product.cahsback} cashback",
                              style: TextStyle(
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                          Container(
                            width: index == 0
                                ? MediaQuery.of(context).size.width * .46
                                : MediaQuery.of(context).size.width * .3,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    "${product.description}",
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      color: AppConst.darkGrey,
                                    ),
                                  ),
                                ),
                                product.isAdded
                                    ? ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            product.isAdded = false;
                                          });
                                        },
                                        style: ElevatedButton.styleFrom(
                                          visualDensity:
                                              VisualDensity(horizontal: -4),
                                          primary: AppConst.kSecondaryColor,
                                          shape: CircleBorder(),
                                          padding: EdgeInsets.all(0),
                                        ),
                                        child: Icon(Icons.done),
                                      )
                                    : OutlinedButton(
                                        onPressed: () {
                                          setState(() {
                                            product.isAdded = true;
                                          });
                                        },
                                        child: Icon(
                                          FontAwesomeIcons.plus,
                                          color: AppConst.kPrimaryColor,
                                        ),
                                        style: OutlinedButton.styleFrom(
                                          visualDensity:
                                              VisualDensity(horizontal: -4),
                                          side: BorderSide(
                                            width: 1.0,
                                            color: AppConst.kPrimaryColor,
                                          ),
                                          shape: CircleBorder(),
                                          padding: EdgeInsets.only(bottom: 2),
                                        ),
                                      ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        width: 10,
                      );
                    },
                  ),
                )
              ],
            ));
      },
    );
  }
}
