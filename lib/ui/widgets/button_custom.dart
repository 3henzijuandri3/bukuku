import 'package:flutter/material.dart';

import '../../shared/theme.dart';

class FilledButtonCustom extends StatelessWidget {
  final double width;
  final double height;
  final String label;
  final bool? isNeon;
  final Function onTap;

  const FilledButtonCustom({
    super.key,
    required this.width,
    required this.height,
    required this.label,
    required this.onTap,
    this.isNeon
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),

        boxShadow: [
          if(isNeon == true)
            BoxShadow(
              color: purpleColor.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 4)
          ),
        ],
      ),

      child: TextButton(
        onPressed: () => onTap(),

        style: TextButton.styleFrom(
          backgroundColor: purpleColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(56)
          ),
        ),

        child: Text(
          label,
          style: whiteTextStyle.copyWith(
              fontSize: 16,
              fontWeight: semiBold
          ),
        ),
      ),
    );
  }
}

class SmallButtonCustom extends StatelessWidget {
  final double paddingX;
  final double paddingY;
  final String label;
  final double? customFontSize;

  const SmallButtonCustom({
    super.key,
    required this.paddingX,
    required this.paddingY,
    required this.label,
    this.customFontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: paddingX, vertical: paddingY),
      decoration: BoxDecoration(
        color: purpleColor.withOpacity(0.95),
        borderRadius: BorderRadius.circular(14),
      ),

      child: Text(
        label,
        style: blackTextStyle.copyWith(
            fontSize: customFontSize ?? 14,
            fontWeight: semiBold
        ),
      ),
    );
  }
}