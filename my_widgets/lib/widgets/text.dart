// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class BigTitleText extends StatelessWidget {
  const BigTitleText(this.text, {super.key, this.color, this.size});
  final String text;
  final Color? color;
  final double? size;
  @override
  Widget build(BuildContext context) {
    return EText(
      text,
      weight: FontWeight.bold,
      size: size??26,
      color: color,
    );
  }
}

class TitleText extends StatelessWidget {
  const TitleText(this.text, {super.key, this.color, this.align});
  final String text;
  final Color? color;
  final TextAlign? align;
  @override
  Widget build(BuildContext context) {
    return EText(
      text,
      weight: FontWeight.bold,
      color: color,
      size: 22,
      align: align,
    );
  }
}

class EText extends StatelessWidget {
  const EText(this.text,
      {super.key,
      this.color,
      this.size,
      this.weight,
      this.align,
      this.font,
      this.maxLines,
      this.letterSpacing,
      this.underline,
      this.fontStyle,
      this.lineThrought});
  final String? text;
  final Color? color;
  final double? size;
  final FontWeight? weight;
  final TextAlign? align;
  final String? font;
  final int? maxLines;
  final double? letterSpacing;
  final bool? underline;
  final bool? lineThrought;
  final FontStyle? fontStyle;

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toString(),
      style: TextStyle(
          letterSpacing: letterSpacing,
          fontStyle: fontStyle,
          color: color ?? Theme.of(context).textTheme.bodySmall!.color,
          fontSize: size ?? 21.0,
          fontFamily: font ?? "Poppins",
          fontWeight: weight ?? FontWeight.w500,
          decorationColor: color,
          decoration: lineThrought == true
              ? TextDecoration.lineThrough
              : underline != true
                  ? TextDecoration.none
                  : TextDecoration.underline),
      textAlign: align ?? TextAlign.start,
      maxLines: maxLines ?? 90,
      textScaleFactor: .7,
      overflow: TextOverflow.ellipsis,
    );
  }
}

class ETextRich extends StatelessWidget {
  const ETextRich({super.key, required this.textSpans, this.size, this.font});
  final double? size;
  final List<InlineSpan> textSpans;
  final font;
  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(children: textSpans),
      textScaleFactor: .7,
      style: TextStyle(fontSize: size ?? 21, fontFamily:font?? "Poppins",color: Colors.white ),
      textAlign: TextAlign.start,
    );
  }
}

TextSpan ETextSpan(
    {required String? text,
    Color? color,
    String? font,
    FontWeight? weight,
    double? size,
    bool? underline}) {
  return TextSpan(
      text: text.toString(),
      style: TextStyle(
          decorationColor: color,
          color: color,
          fontWeight: weight,
          fontFamily: font,
          fontSize: size,
          decoration: underline == true ? TextDecoration.underline : null));
}
