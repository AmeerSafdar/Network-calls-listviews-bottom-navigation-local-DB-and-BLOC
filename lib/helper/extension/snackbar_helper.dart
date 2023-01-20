  // ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:task03/helper/const/color_helper.dart';
import 'package:task03/presentationLayer/widget/get_text.dart';
  void buildErrorSnackbar(BuildContext context,String msg) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content:  TextWidget(txt:msg),
                    backgroundColor:ColorHelper.K_red ,
                  ));
  }