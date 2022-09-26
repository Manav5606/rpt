// import 'package:flutter/material.dart';
// import 'package:customer_app/app/constants/responsive.dart';
// import 'package:customer_app/constants/app_const.dart';

// import 'package:get/get.dart';

// class CustomButton extends StatelessWidget {
//   final String title;
//   final Function() function;
//   final IconData? icon;
//   final Color? color;
//   final double? width;
//   final double? height;
//   final double? textSize;
//   final double? radius;
//   CustomButton(
//       {required this.title,
//       required this.function,
//       this.icon,
//       this.color,
//       this.width,
//       this.height,
//       this.textSize,
//       this.radius});

//   @override
//   Widget build(BuildContext context) {
//     return TextButton(
//       onPressed: function,
//       style: TextButton.styleFrom(
//         backgroundColor: color ?? AppConst.black,
//         shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(
//                 radius ?? SizeUtils.horizontalBlockSize * 5)),
//       ),
//       child: Container(
//         height: height ?? 45,
//         width: width ?? Get.width,
//         child: Center(
//           child: Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               icon != null
//                   ? Icon(
//                       icon,
//                       size: SizeUtils.horizontalBlockSize * 5,
//                       color: AppConst.white,
//                     )
//                   : Text(''),
//               icon != null
//                   ? SizedBox(
//                       width: SizeUtils.horizontalBlockSize * 5,
//                     )
//                   : Text(''),
//               Text(
//                 title,
//                 style:
//                     TextStyle(fontSize: textSize ?? 20, color: AppConst.white),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
