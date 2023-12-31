import 'package:flutter/material.dart';

import '../../shared/theme.dart';

class AuthInputCustom extends StatelessWidget {
  final String formLabel;
  final bool obscureText;
  final TextEditingController? controller;

  const AuthInputCustom({super.key, required this.formLabel, required this.obscureText, this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      controller: controller,

      decoration: InputDecoration(
          hintText: formLabel,
          filled: true,
          fillColor: whiteColor,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),

          hintStyle: greyTextStyle.copyWith(
            fontSize: 14,
            fontWeight: medium
          ),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide.none,
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide(
                color: blueColor
            ),
          )
      ),
    );
  }
}

class AddBookFormCustom extends StatelessWidget {
  final String formLabel;
  final TextEditingController? controller;
  final TextInputType? type;

  const AddBookFormCustom({
    Key? key,
    required this.formLabel,
    this.controller, this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        // Email text
        Text(
          formLabel,
          style: blackTextStyle.copyWith(
              fontSize: 14,
              fontWeight: semiBold
          ),
        ),

        const SizedBox(height: 8),

        //Email Input
        TextFormField(
          keyboardType: type,
          controller: controller,

          decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(8),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14)
              )
          ),
        ),
      ],
    );
  }
}