import 'package:flutter/material.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/screens/more_stores/all_offers_listview.dart';
import 'package:customer_app/theme/styles.dart';
import 'package:customer_app/widgets/offer_card.dart';

enum ScrollDirection1 { forward, backward }

class StoresScreen extends StatefulWidget {
  const StoresScreen({Key? key}) : super(key: key);

  @override
  _StoresScreenState createState() => _StoresScreenState();
}

class _StoresScreenState extends State<StoresScreen> {
  final ScrollController _scrollController = ScrollController();

  // @override
  // void initState() {
  //   super.initState();
  //   setStatusBarcolorr();
  // }

  // setStatusBarcolorr() async {
  //   await FlutterStatusbarcolor.setStatusBarColor(Color(0xff384093));
  //   FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
  // }

  // @override
  // void dispose() {
  //   _scrollController.dispose();
  //   changeStatusBarColor();
  //   super.dispose();
  // }

  // changeStatusBarColor() async {
  //   await FlutterStatusbarcolor.setStatusBarColor(Colors.white);
  //   FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
  // }

  _scrollToTheNextItemView(
      {ScrollDirection1 scrollDirection = ScrollDirection1.forward}) async {
    if (scrollDirection == ScrollDirection1.forward) {
      if (_scrollController.position.pixels <
              _scrollController.position.maxScrollExtent &&
          !_scrollController.position.outOfRange) {
        await _scrollController.animateTo(
            _scrollController.position.pixels + 380,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOut);
      }
    } else {
      if (_scrollController.position.pixels >
              _scrollController.position.minScrollExtent &&
          !_scrollController.position.outOfRange) {
        await _scrollController.animateTo(
            _scrollController.position.pixels - 100,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOut);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding:
                const EdgeInsets.only(top: 15, left: 10, right: 10, bottom: 15),
            color: AppConst.darkBlue,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                          constraints: BoxConstraints.tightFor(),
                          padding: EdgeInsets.zero,
                          icon: Icon(
                            Icons.arrow_back,
                            size: 22,
                          ),
                          color: AppConst.white,
                          onPressed: () => Navigator.pop(context),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          "Home - Pernamitta, Ongole",
                          style: AppStyles.ADDRESS_STYLE
                              .copyWith(color: AppConst.white),
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Genie",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: AppConst.white,
                            fontSize: 45,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Anything you want, delivered",
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            color: AppConst.white,
                            fontSize: 20,
                          ),
                        )
                      ],
                    ),
                    Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                        color: AppConst.darkBlue,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: ListView(
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Get min 50% OFF here",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        "View All",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                          color: AppConst.kPrimaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 90,
                    child: ListView.separated(
                        controller: _scrollController,
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            width: 10,
                          );
                        },
                        scrollDirection: Axis.horizontal,
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          return OfferCard();
                        }),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Popular brand on deals",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        "View All",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                          color: AppConst.kPrimaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 90,
                    child: ListView.separated(
                        controller: _scrollController,
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            width: 10,
                          );
                        },
                        scrollDirection: Axis.horizontal,
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          return OfferCard();
                        }),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "More stores",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  AllOffersListView(),
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }
}


// class StoresScreen extends StatefulWidget {
//   @override
//   _StoresScreenState createState() => _StoresScreenState();
// }

// class _StoresScreenState extends State<StoresScreen> {
//   final ScrollController _scrollController = ScrollController();

//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }

//   _scrollToTheNextItemView(
//       {ScrollDirection1 scrollDirection = ScrollDirection1.forward}) async {
//     if (scrollDirection == ScrollDirection1.forward) {
//       if (_scrollController.position.pixels <
//               _scrollController.position.maxScrollExtent &&
//           !_scrollController.position.outOfRange) {
//         await _scrollController.animateTo(
//             _scrollController.position.pixels + 100,
//             duration: const Duration(milliseconds: 500),
//             curve: Curves.easeOut);
//       }
//     } else {
//       if (_scrollController.position.pixels >
//               _scrollController.position.minScrollExtent &&
//           !_scrollController.position.outOfRange) {
//         await _scrollController.animateTo(
//             _scrollController.position.pixels - 100,
//             duration: const Duration(milliseconds: 500),
//             curve: Curves.easeOut);
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Button Scroll"),
//         actions: [
//           IconButton(
//               icon: Icon(Icons.arrow_back_ios),
//               onPressed: () => _scrollToTheNextItemView(
//                   scrollDirection: ScrollDirection1.backward)),
//           IconButton(
//               icon: Icon(Icons.arrow_forward_ios),
//               onPressed: _scrollToTheNextItemView)
//         ],
//       ),
//       body: Center(
//         child: Container(
//           height: 120,
//           child: ListView(
//             scrollDirection: Axis.horizontal,
//             controller: _scrollController,
//             shrinkWrap: true,
//             children: List.generate(
//                 20,
//                 (_) => Container(
//                     margin: EdgeInsets.only(right: 14),
//                     color: Colors.blue,
//                     height: 100,
//                     width: 100)),
//           ),
//         ),
//       ),
//     );
//   }
// }

