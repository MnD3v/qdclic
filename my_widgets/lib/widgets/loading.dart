import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_widgets/extentions/extensions.dart';
import 'package:my_widgets/widgets/custom_show_dialog.dart';
import 'package:my_widgets/widgets/text.dart';

void loading({
  progress,
  final color,
  final backgroundColor,
}) {
  Custom.showDialog(dialog:
      Dialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Loading(backgroundColor: backgroundColor, color: color, progress:  progress,),
      ),
   
      barrierColor: Colors.black26);
}

class Loading extends StatelessWidget {
  const Loading(
      {super.key,
      this.progress,
      required this.backgroundColor,
      required this.color});
  final Widget? progress;
  final color;
  final backgroundColor;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 155.0,
        decoration: const BoxDecoration(color: Colors.transparent),
        alignment: Alignment.center,
        child: Container(
            padding: EdgeInsets.symmetric(vertical: 9),
            width: Get.width,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6.0),
                border: Border.all(color: Colors.white30, width: 2)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        //            Image(image: AssetImage('assets/images/case.png'), height: 30,),
                        SizedBox(
                          height: 35,
                          width: 35,
                          child: Stack(
                            children: [
                              CircularProgressIndicator(
                                color: color ?? Theme.of(context).primaryColor,
                                strokeWidth: 2.2,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    12.w,
                    EText('Traitement en cours...',
                        maxLines: 2,
                        weight: FontWeight.w500,
                        align: TextAlign.center,
                        color: color ?? Theme.of(context).primaryColor)
                  ],
                ),
                progress ?? 0.h
              ],
            )));
  }
}
