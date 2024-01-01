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
        borderRadius: BorderRadius.circular(10),
      ),

      child: Text(
        label,
        style: whiteTextStyle.copyWith(
            fontSize: customFontSize ?? 14,
            fontWeight: semiBold
        ),
      ),
    );
  }
}

class MenuButtonCutom extends StatelessWidget {
  final IconData icon;
  final String label;
  final Function onTap;


  const MenuButtonCutom({super.key, required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Icon
          Container(
            width: 150,
            height: 150,

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: whiteColor,
            ),

            child: Center(
              child: Icon(
                icon,
                size: 50,
              ),
            ),
          ),

          const SizedBox(height: 8),

          // Text
          Text(
            label,
            style: blackTextStyle.copyWith(
                fontSize: 14,
                fontWeight: medium
            ),
          )
        ],
      ),
    );
  }
}