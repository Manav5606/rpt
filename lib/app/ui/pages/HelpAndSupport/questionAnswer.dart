import 'package:flutter/material.dart';
import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/constants/app_const.dart';

import 'package:customer_app/data/generalQuestionsData.dart';
import 'package:customer_app/theme/styles.dart';
import 'package:customer_app/widgets/backButton.dart';

class QuestionsAndAnswers extends StatelessWidget {
  const QuestionsAndAnswers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            minimum: EdgeInsets.only(
                top: SizeUtils.horizontalBlockSize * 3.82,
                left: SizeUtils.horizontalBlockSize * 2.55,
                right: SizeUtils.horizontalBlockSize * 2.55),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        height: SizeUtils.horizontalBlockSize * 15,
                        decoration:
                            BoxDecoration(color: AppConst.white, boxShadow: []),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              BackButtonWidget(),
                              SizedBox(
                                width: SizeUtils.horizontalBlockSize * 5,
                              ),
                              Text(
                                "Help & Support",
                                style: TextStyle(
                                    color: AppConst.black,
                                    fontSize:
                                        SizeUtils.horizontalBlockSize * 4),
                              )
                            ])),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: SizeUtils.horizontalBlockSize * 12,
                            width: double.infinity,
                            alignment: Alignment.centerLeft,
                            color: AppConst.lightGrey,
                            child: Text(
                              " HELP WITH THIS ORDER",
                              style: AppStyles.STORE_NAME_STYLE,
                            ),
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: askedQuestion.length,
                              itemBuilder: (context, index) {
                                return ExpansionTile(
                                    title: Text(
                                      askedQuestion[index].title!,
                                      style: TextStyle(
                                          color: AppConst.black,
                                          fontWeight: FontWeight.w600,
                                          fontSize:
                                              SizeUtils.horizontalBlockSize *
                                                  4),
                                    ),
                                    iconColor: AppConst.black,
                                    collapsedIconColor: AppConst.black,
                                    tilePadding: EdgeInsets.all(
                                        SizeUtils.horizontalBlockSize - 1),
                                    expandedAlignment: Alignment.center,
                                    textColor: AppConst.black,
                                    children: [
                                      Container(
                                          height:
                                              SizeUtils.horizontalBlockSize *
                                                  30,
                                          child: Text(
                                            askedQuestion[index].description!,
                                            overflow: TextOverflow.clip,
                                            maxLines: 6,
                                          ))
                                    ]);
                              })
                        ])
                  ]),
            )));
  }
}
