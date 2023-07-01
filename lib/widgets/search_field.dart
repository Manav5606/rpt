import 'package:flutter/material.dart';
import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:sizer/sizer.dart';

class SearchField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final String placeholder;
  final Function()? onEditingComplete;
  final Function(String)? onChange;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  const SearchField(
      {Key? key,
      this.onEditingComplete,
      this.onChange,
      this.prefixIcon,
      // = const Icon(
      //   Icons.search,
      //   color: kPrimaryColor,
      // ),
      this.suffixIcon,
      this.placeholder = "Address search e.g. Kukatpally",
      this.focusNode,
      required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(50),
      // elevation: 2,
      child: Container(
        // margin: EdgeInsets.only(top: 1.h),
        height: 4.6.h,
        child: Center(
          child: TextFormField(
            onChanged: onChange,
            controller: controller,
            cursorColor: AppConst.black,
            focusNode: focusNode,
            textAlign: TextAlign.start,
            textAlignVertical: TextAlignVertical.center,
            onEditingComplete: onEditingComplete,
            textInputAction: TextInputAction.done,
            style: TextStyle(
              fontFamily: 'MuseoSans',
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.normal,
              fontSize:
                  (SizerUtil.deviceType == DeviceType.tablet) ? 9.sp : 10.sp,
              // color: Colors.grey[400],
            ),
            decoration: InputDecoration(
              hintText: placeholder,
              hintStyle: TextStyle(
                  fontFamily: 'MuseoSans',
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.normal,
                  fontSize: (SizerUtil.deviceType == DeviceType.tablet)
                      ? 9.sp
                      : 10.sp,
                  color: Color(0xff878C9B) //AppConst.grey,
                  ),
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              fillColor: AppConst.shimmerbgColor,
              filled: true,
              isDense: true,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide.none
                  // borderSide: const BorderSide(color: AppConst.black, width: 1.5),
                  ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide.none),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
              floatingLabelBehavior: FloatingLabelBehavior.never,
            ),
          ),
        ),
      ),
    );
  }
}

// class SearchField extends StatelessWidget {
//   final TextEditingController controller;
//   final FocusNode? focusNode;
//   final String placeholder;
//   final Function()? onEditingComplete;
//   final Function(String)? onChange;
//   final Widget prefixIcon;
//   final Widget? suffixIcon;

//   const SearchField(
//       {Key? key,
//       this.onEditingComplete,
//       this.onChange,
//       this.prefixIcon = const Icon(
//         Icons.search,
//         color: kPrimaryColor,
//       ),
//       this.suffixIcon,
//       this.placeholder = "Restaurant names, cuisine or dish ...",
//       this.focusNode,
//       required this.controller})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       borderRadius: BorderRadius.circular(10),
//       elevation: 2,
//       child: SizedBox(
//         // height: 5.h,
//         child: TextFormField(
//           onChanged: onChange,
//           controller: controller,
//           focusNode: focusNode,
//           textAlignVertical: TextAlignVertical.center,
//           onEditingComplete: onEditingComplete,
//           textInputAction: TextInputAction.done,
//           style: TextStyle(
//             fontFamily: 'MuseoSans',
//             fontSize: SizeUtils.horizontalBlockSize * 4.5,
//             // color: Colors.grey[400],
//           ),
//           decoration: InputDecoration(
//             hintText: placeholder,
//             hintStyle: TextStyle(
//               fontFamily: 'MuseoSans',
//               fontSize: SizeUtils.horizontalBlockSize * 4.5,
//               color: Colors.grey[400],
//             ),
//             prefixIcon: prefixIcon,
//             suffixIcon: suffixIcon,
//             border: InputBorder.none,
//             floatingLabelBehavior: FloatingLabelBehavior.never,
//           ),
//         ),
//       ),
//     );
//   }
// }
