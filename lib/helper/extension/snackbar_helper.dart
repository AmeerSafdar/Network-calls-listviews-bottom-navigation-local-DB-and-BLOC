  // ignore_for_file: no_leading_underscores_for_local_identifiers

  import 'package:flutter/material.dart';
import 'package:task03/helper/extension/color_helper.dart';
import 'package:task03/helper/extension/string_helper.dart';
  void buildErrorSnackbar(BuildContext context,String msg) {
    StringHelper _stringHelper=StringHelper();
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content:  _stringHelper.getStringText(msg),
                    backgroundColor:K_red ,
                  ));
  }