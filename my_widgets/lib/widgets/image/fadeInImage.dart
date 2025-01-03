// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:my_widgets/my_widgets.dart';

class EFadeInImage extends StatefulWidget {
  const EFadeInImage({super.key, required this.image, this.color, this.radius, this.width, this.height});
  final double? width;
  final double? height;
  final color;
  final ImageProvider image;
  final double? radius;

  @override
  State<EFadeInImage> createState() => _EFadeInImageState();
}

class _EFadeInImageState extends State<EFadeInImage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  ClipRRect(
      borderRadius: BorderRadius.circular(widget.radius??12),
      child: FadeInImage(
        height: widget.height,
        width: widget.width,
            imageErrorBuilder: (context, error, stackTrace) {
              print(error.toString());
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.info,
                    color: widget.color ?? Theme.of(context).primaryColor,
                  ),
                  12.h,
                  const EText("erreur de chargment")
                ],
              );
            },
            fit: BoxFit.cover,
          
            placeholder: const AssetImage('assets/images/placeholder.png'),
            image: widget.image,
      ),
    );
  }
}
