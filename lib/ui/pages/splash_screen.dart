import 'package:bukuku/shared/values.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../services/auth_service.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    checkUserLoginStatus();
  }

  Future<void> checkUserLoginStatus() async {
    String token = await authService.getToken();
    bool isLoggedIn = token.isNotEmpty;

    await Future.delayed(const Duration(seconds: 2));

    if (isLoggedIn) {
      Get.offNamed('/home');
    } else {
      Get.offNamed('/onboarding');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 280,
          height: 300,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage(splashLogo),
            ),
          ),
        ),
      ),
    );
  }
}
