// import 'package:flutter/material.dart';

// import 'package:customer_app/constants/app_const.dart';

// class Button extends StatelessWidget {
//   final onTap;
//   final bgColor;
//   final borderRadius;
//   final child;

//   Button({
//     required this.onTap,
//     required this.child,
//     this.bgColor,
//     this.borderRadius,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         width: double.infinity,
//         alignment: Alignment.center,
//         padding: EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           color: bgColor == null ? AppConst.kPrimaryColor : bgColor,
//           borderRadius: BorderRadius.circular(
//             borderRadius == null ? 5.0 : borderRadius,
//           ),
//         ),
//         child: child,
//       ),
//     );
//   }
// }
