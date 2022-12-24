// import 'package:customer_app/screens/authentication/repository/maprepo.dart';
// import 'package:flutter/material.dart';

// class PermissionRaw extends StatelessWidget {
//   final GestureTapCallback onTap;

//   const PermissionRaw({Key? key, required this.onTap}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//         decoration: const BoxDecoration(color: Colors.redAccent),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               "Location Permission disabled.",
//               style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 15,
//                   fontWeight: FontWeight.w600),
//             ),
//             InkWell(
//               onTap: (() {
//                 MapRepo.determinePosition();
//               }),
//               child: Text(
//                 "ENABLE",
//                 style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 15,
//                     fontWeight: FontWeight.w600),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
