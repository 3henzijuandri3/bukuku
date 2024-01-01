import 'package:bukuku/shared/theme.dart';
import 'package:bukuku/ui/pages/add_book.dart';
import 'package:bukuku/ui/pages/all_book.dart';
import 'package:bukuku/ui/pages/book_detail.dart';
import 'package:bukuku/ui/pages/edit_book.dart';
import 'package:bukuku/ui/pages/home.dart';
import 'package:bukuku/ui/pages/login.dart';
import 'package:bukuku/ui/pages/onboarding.dart';
import 'package:bukuku/ui/pages/register.dart';
import 'package:bukuku/ui/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'bukuku',

      theme: ThemeData(
          scaffoldBackgroundColor: lightBackgroundColor,

          appBarTheme: AppBarTheme(
            elevation: 0,
            centerTitle: true,
            backgroundColor: lightBackgroundColor,

            iconTheme: IconThemeData(
              color: blackColor,
            ),

            titleTextStyle: blackTextStyle.copyWith(
                fontSize: 20,
                fontWeight: semiBold
            ),
          )
      ),

      getPages: [
        GetPage(name: '/', page: () => const SplashScreenPage()),
        GetPage(name: '/onboarding', page: () => const OnBoardingPage()),
        GetPage(name: '/login', page: () => const LoginPage()),
        GetPage(name: '/register', page: () => const RegisterPage()),
        GetPage(name: '/home', page: () => const HomePage()),
        GetPage(name: '/addBook', page: () => const AddBookPage()),
        GetPage(name: '/allBook', page: () => const AllBookPage()),
        GetPage(name: '/detail', page: () => BookDetailPage(bookId: Get.arguments)),
        GetPage(name: '/edit', page: () => EditBookPage(bookId: Get.arguments)),
      ],
    );
  }
}
