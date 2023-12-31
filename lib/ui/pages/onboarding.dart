import 'package:bukuku/shared/values.dart';
import 'package:bukuku/ui/pages/register.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared/theme.dart';
import '../widgets/button_custom.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [

          // Background Image
          Image.asset(
            bgOnboarding,
            fit: BoxFit.cover,
          ),

          // Black Overlay
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black,
                  Colors.transparent
                ],
              ),
            ),
          ),

          // Text
          Padding(
            padding: const EdgeInsets.only(left: 24, bottom: 60, right: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Track Book Reading\nWith Bukuku',
                  style: whiteTextStyle.copyWith(
                      fontSize: 34,
                      fontWeight: bold
                  ),
                ),

                Text(
                  'Manage Book With Single App',
                  style: whiteTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: regular
                  ),
                ),

                const SizedBox(height: 50),

                FilledButtonCustom(
                    width: double.infinity,
                    height: 50,
                    label: 'Get Started',
                    isNeon: true,
                    onTap: (){
                      Get.to(() => const RegisterPage());
                    }
                ),

              ],
            ),
          )
        ],
      ),
    );
  }
}
