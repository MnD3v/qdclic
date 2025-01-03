import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_widgets/widgets/column.dart';
import 'package:my_widgets/extentions/extensions.dart';
import 'package:my_widgets/widgets/simple_button.dart';
import 'package:my_widgets/widgets/text.dart';

class WarningWidget extends StatelessWidget {
  const WarningWidget({
    super.key,
    required this.message,
    this.confirm,
  });
  final message;
  final VoidCallback? confirm;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 700),
        child: Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: Container(
            decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(
                  21,
                ),
                border: Border.all(color: Colors.white38)),
            child: Padding(
              padding: const EdgeInsets.all(9.0),
              child: EColumn(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    12.h,
                    const Image(
                      image: AssetImage("assets/icons/warning.png"),
                      height: 50,
                    ),
                    12.h,
                    const EText('Problème', size: 25, weight: FontWeight.bold),
                    12.h,
                    EText(
                      message,
                      size: 21,
                      maxLines: 5,
                      align: TextAlign.center,
                    ),
                    24.h,
                    SimpleButton(
                      color: Colors.pinkAccent,
                      radius: 12,
                      onTap: confirm ??
                          () {
                            Get.back();
                          },
                      child: EText("OK"),
                    )
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
