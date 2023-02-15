import 'package:flutter/material.dart';

import '../../shared/theme.dart';

class InputNumber extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  const InputNumber({Key? key, required this.label, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 60,
        height: 60,
        decoration:
            const BoxDecoration(shape: BoxShape.circle, color: greyColor),
        child: Center(
          child: Text(
            label,
            style: whiteTextStyle.copyWith(fontSize: 22, fontWeight: semiBold),
          ),
        ),
      ),
    );
  }
}
