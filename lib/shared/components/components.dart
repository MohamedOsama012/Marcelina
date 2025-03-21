import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:marcelina/shared/styles/color.dart';

import '../styles/icon_broken.dart';

class DefaultAppBar extends StatelessWidget  {
  final String? title;
  final List<Widget>? actions;
  final BuildContext context;

  const DefaultAppBar({
    super.key,
    required this.context,
    this.title,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(IconBroken.Arrow___Left_2),
      ),
      title: Text(title ?? ''),
      actions: actions,
      titleSpacing: 0,
    );
  }

}


class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType type;
  final Function(String)? onSubmit;
  final Function(String)? onChange;
  final Function()? onTap;
  final bool isPassword;
  final String? Function(String?)? validate;
  final String label;
  final String? hintText;
  final IconData prefix;
  final IconData? suffix;
  final Function()? suffixPressed;
  final bool isClickable;

  const CustomTextField({
    required this.controller,
    required this.type,
    this.onSubmit,
    this.onChange,
    this.onTap,
    this.isPassword = false,
    required this.validate,
    required this.label,
    this.hintText,
    required this.prefix,
    this.suffix,
    this.suffixPressed,
    this.isClickable = true,
    super.key,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late FocusNode _focusNode;
  bool hasError = false;
  final Color focusColor = HexColor("#DD5D79"); // Pink color when focused

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _validateField() {
    setState(() {
      hasError = widget.validate?.call(widget.controller.text) != null;
    });
  }

  Color _getDynamicColor() {
    return hasError ? Colors.red : (_focusNode.hasFocus ? focusColor : HexColor('DD5D79'));
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.type,
      focusNode: _focusNode,
      obscureText: widget.isPassword,
      enabled: widget.isClickable,
      onFieldSubmitted: widget.onSubmit,
      onChanged: (value) {
        widget.onChange?.call(value);
        _validateField();
      },
      onTap: widget.onTap,
      validator: (value) {
        String? validationResult = widget.validate?.call(value);
        setState(() {
          hasError = validationResult != null;
        });
        return validationResult;
      },
      cursorColor: _getDynamicColor(),
      decoration: InputDecoration(
        labelText: widget.label,
        hintText: widget.hintText,
        labelStyle: const TextStyle(
          color: Colors.black,
        ),
        prefixIcon: Icon(
          widget.prefix,
          color: _getDynamicColor(),
        ),
        suffixIcon: widget.suffix != null
            ? IconButton(
          icon: Icon(
            widget.suffix,
            color: _getDynamicColor(),
          ),
          onPressed: widget.suffixPressed,
        )
            : null,
        border: const OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: hasError ? Colors.red : focusColor,
            width: 2.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: HexColor('DD5D79'),
          ),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
            width: 2.0,
          ),
        ),
      ),
    );
  }
}

void showToast({required String text, required ToastStates state}) =>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: chooseToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0);

enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
    case ToastStates.WARNING:
      color = Colors.yellow;
  }
  return color;
}


Widget buildProductCard({
  required String title,
  required String subTitle,
  required double price,
  required String imagePath,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      decoration: BoxDecoration(
        color: HexColor("#FFEFF3"),
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(15),
          topLeft: Radius.circular(15),
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: AssetImage(imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              subTitle,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              "\$$price",
              style: TextStyle(
                fontSize: 14,
                color: primaryColor,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

