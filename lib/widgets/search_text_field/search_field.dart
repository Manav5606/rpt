import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/widgets/search_text_field/search_field_style.dart';
import 'package:flutter/material.dart';

class SearchField extends StatefulWidget {
  final String? hintText;
  final SearchFieldStyle? style;
  final String startText;
  final Function(String)? onChanged;
  final bool? enabled;
  final Widget? child;

  SearchField(
      {required this.style,
      this.hintText = "Search",
      this.startText = "",
      this.onChanged,
      this.enabled,
      this.child});

  @override
  _SearchFieldState createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  final _key = GlobalKey();

  TextEditingController? _controller;
  FocusNode? _focusNode;

  @override
  void initState() {
    _controller = TextEditingController()..text = widget.startText;
    _controller!.addListener(() {
      setState(() {});
      widget.onChanged?.call(_controller?.value.text ?? "");
    });
    _focusNode = FocusNode();
    _focusNode!.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _focusNode!.dispose();
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        duration: widget.style!.animationsDuration,
        height: widget.style!.height,
        decoration: BoxDecoration(
            color: widget.style!.backgroundColor,
            border: null,
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: Container(
          // height: widget.style!.height,
          child: Stack(
            children: [
              TextField(
                key: _key,
                autofocus: false,
                controller: _controller,
                focusNode: _focusNode,
                enabled: widget.enabled,
                maxLines: 1,
                textInputAction: TextInputAction.search,
                cursorColor: widget.style!.cursorColor,
                style: widget.style!.style,
                onSubmitted: (value) {
                  widget.onChanged!(value);
                },
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    hintStyle: widget.style!.hintStyle,
                    prefixIconColor: AppConst.grey,
                    prefixIcon: Icon(
                      Icons.search,
                      color: AppConst.grey,
                    ),
                    border: InputBorder.none,
                    hintText: widget.hintText),
              ),
              if (widget.child != null)
                Positioned(
                  left: widget.style!.childPadding,
                  child: widget.child!,
                )
            ],
          ),
        ));
  }
}
