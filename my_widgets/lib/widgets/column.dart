import 'package:flutter/material.dart';


class EColumn extends StatelessWidget {
  const EColumn({super.key, required this.children, this.crossAxisAlignment});
  final List<Widget> children;
  final CrossAxisAlignment? crossAxisAlignment;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      primary: true,
      child: Column(
        crossAxisAlignment: crossAxisAlignment??CrossAxisAlignment.start,
        children: children,
      )
    );
  }
}
