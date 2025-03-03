import 'package:flutter/material.dart';

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

  Color _getIconColor() {
    if (hasError) {
      return Colors.red;
    } else if (_focusNode.hasFocus) {
      return Colors.blue;
    } else {
      return Colors.grey;
    }
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
      decoration: InputDecoration(
        labelText: widget.label,
        hintText: widget.hintText,
        labelStyle: TextStyle(
          color: _getIconColor(),
        ),
        prefixIcon: Icon(
          widget.prefix,
          color: _getIconColor(),
        ),
        suffixIcon: widget.suffix != null
            ? IconButton(
          icon: Icon(
            widget.suffix,
            color: _getIconColor(),
          ),
          onPressed: widget.suffixPressed,
        )
            : null,
        border: const OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: _getIconColor(),
            width: 2.0,
          ),
        ),
      ),
    );
  }
}
