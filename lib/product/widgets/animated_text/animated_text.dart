import 'package:cryptocurrency/core/init/theme/dark_color_scheme/dark_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:animated_flip_counter/animated_flip_counter.dart';

class AnimatedText extends StatelessWidget {
  final bool isPriceText;
  final num value;
  final double fontSize;
  const AnimatedText(
      {Key? key,
      required this.isPriceText,
      required this.value,
      required this.fontSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedFlipCounter(
      value: value,
      fractionDigits: 2,
      prefix: isPriceText ? '\$' : '%',
      thousandSeparator: isPriceText ? ',' : '',
      decimalSeparator: '.',
      textStyle: TextStyle(
        color: isPriceText
            ? DarkColorScheme.instance!.white
            : value.isNegative
                ? DarkColorScheme.instance!.red
                : DarkColorScheme.instance!.green,
        fontSize: fontSize,
      ),
    );
  }
}
