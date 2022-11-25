import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/widgets/search_text_field/search_field_style.dart';
import 'package:flutter/material.dart';

class SearchFieldButton extends StatelessWidget {
  final SearchFieldStyle style;
  final Function onTab;

  SearchFieldButton({required this.onTab, required this.style});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTab(),
      child: Container(
          height: 36,
          decoration: BoxDecoration(
              color: style.backgroundColor,
              border: null,
              borderRadius: BorderRadius.all(Radius.circular(8))),
          child: Container(
            // height: widget.style!.height,
            child: Row(children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                child: Icon(
                  Icons.search,
                  color: AppConst.grey,
                ),
              ),
              Text(
                "Search for items",
                style: style.hintStyle,
              )
            ]),
          )),
    );
  }
}
