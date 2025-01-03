
import 'package:flutter/material.dart';
import 'package:get/get.dart';

 class Custom {
  
static void showDialog({ required Widget dialog,  Color? barrierColor, bool? dismissible}) {
  FocusManager.instance.primaryFocus?.unfocus();
  Get.generalDialog(
    
    barrierColor: barrierColor??Colors.white12,
    pageBuilder: (context, animation, secondaryAnimation) {
      return AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          return Transform.translate(
              offset: Offset(
                  (1 - animation.value) * 100, (1 - animation.value) * 100),
              child: dialog);
        },
      );
    },
    barrierDismissible: dismissible??true,
    barrierLabel: ""
  );
}

}