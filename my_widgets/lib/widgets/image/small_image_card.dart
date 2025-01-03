import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_widgets/widgets/future_builder_widgets.dart';

class SmallImageCard extends StatelessWidget {
  const SmallImageCard(
      {super.key,
      required this.remove,
      required this.image,
      required this.isLoadingImages,
      this.width,
      this.one});
  final isLoadingImages;
  final remove;
  final ImageProvider image;
  final one;
  final width;
  @override
  Widget build(BuildContext context) {
    final _width = width??Get.width;
    return Container(
      height: one == true ? 200 : (_width - 18) / 2.5,
      width: one == true ? _width : _width / 2 - 19,
      margin: const EdgeInsets.all(3),
      alignment: Alignment.topRight,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 209, 209, 209),
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: image,
        ),
      ),
      child: isLoadingImages
          ? Container(
              color: Colors.white54, child: const ECircularProgressIndicator(label: null,))
          : Container(
              height: 30,
              width: 30,
              margin: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                  color: Colors.black38,
                  borderRadius: BorderRadius.circular(6)),
              child: InkWell(
                onTap: remove,
                child: const Icon(
                  CupertinoIcons.trash,
                  color: Colors.white,
                  size: 14,
                ),
              ),
            ),
    );
  }
}
