// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
  TextFieldWidget({
    super.key,required this.hintText,
    required this.textEditingController,
    required this.validator,
    this.onChangedVal,
    });
  String hintText;
  TextEditingController textEditingController;
  final String? Function(String? val) validator;
  void Function(String? val)? onChangedVal;
  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged:widget.onChangedVal,
      controller: widget.textEditingController,
      validator: widget.validator,
      decoration: InputDecoration(
              hintText: widget.hintText),
    );
  }
}