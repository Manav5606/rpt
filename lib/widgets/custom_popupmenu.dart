import 'package:flutter/material.dart';
import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/constants/app_const.dart';

class CustomPopMenu extends StatelessWidget {
  final PopupMenuItemSelected? onSelected;
  final Widget? child;
  final List<String>? list;
  final bool isQunitity;
  final String? title;

  const CustomPopMenu({Key? key, this.onSelected, this.child, this.list, this.isQunitity = true, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      onSelected: onSelected,
      offset: Offset(0.0, 40),
      child: child,
      itemBuilder: (ctx) {
        return [
          PopupMenuItem(
            value: 0,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title ?? '',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: SizeUtils.verticalBlockSize * 2,
                  ),
                ),
                SizedBox(
                  width: SizeUtils.horizontalBlockSize * 1,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Icon(
                    Icons.clear,
                    size: SizeUtils.verticalBlockSize * 3,
                  ),
                ),
              ],
            ),
          ),
          ...List.generate(
            list?.length ?? 0,
            (index) => PopupMenuItem(
              value: index,
              padding: EdgeInsets.zero,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(
                    height: 0,
                  ),
                  isQunitity
                      ? Align(
                          child: Text(
                            index == 0 ? "  ${index}(Remove)" : "  $index",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: SizeUtils.verticalBlockSize * 2,
                            ),
                          ),
                        )
                      : Align(
                          child: Text(
                            "${list?[index]}",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: SizeUtils.verticalBlockSize * 2,
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ),
        ];
      },
    );
  }
}
