import 'package:bukuku/controllers/auth_controller.dart';
import 'package:bukuku/models/auth/login_model.dart';
import 'package:flutter/material.dart';

import '../../shared/theme.dart';
import '../../shared/values.dart';
import '../widgets/button_custom.dart';
import '../widgets/input_form_custom.dart';
import 'package:d_info/d_info.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final loginStateController = Get.put(AuthController());

  final emailController = TextEditingController(text: '');
  final passwordController = TextEditingController(text: '');

  bool validate(){
    if(emailController.text.isEmpty || passwordController.text.isEmpty){
      return false;
    }

    return true;
  }

  login() async {
    final loginSuccess = await loginStateController.loginUser(
        LoginRequestModel(
          email: emailController.text,
          password: passwordController.text,
        )
    );

    if(loginSuccess){
      if(!context.mounted) return;
      DInfo.dialogSuccess(context, 'Login Success');
      DInfo.closeDialog(
          context,
          durationBeforeClose: const Duration(seconds: 1),
          actionAfterClose: (){
            Get.offAllNamed('/home');
          }
      );

    } else {
      if(!context.mounted) return;
      final loginResponseMessage = loginStateController.loginResponse!.message.toString();
      DInfo.dialogError(context, loginResponseMessage);
      DInfo.closeDialog(
        context,
        durationBeforeClose: const Duration(milliseconds: 1600),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx((){
        final isLoading = loginStateController.isLoading.value;

        return Stack(
          children: [

            // Main Content
            ListView(
              padding: const EdgeInsets.only(left: 22, right: 22, top: 40, bottom: 22),
              children: [

                // Register Logo
                Center(
                  child: Container(
                    width: 180,
                    height: 220,

                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage(authLogo),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 100),

                // Register Copywrite
                Text(
                  'Sign In\nTo Your Account',
                  style: blackTextStyle.copyWith(
                      fontSize: 20,
                      fontWeight: semiBold
                  ),
                ),

                const SizedBox(height: 30),

                // Login Form Container
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Email
                    AuthInputCustom(
                      formLabel: 'Email Address',
                      obscureText: false,
                      controller: emailController,
                    ),

                    const SizedBox(height: 16),

                    // Password
                    AuthInputCustom(
                      formLabel: 'Password',
                      obscureText: true,
                      controller: passwordController,
                    ),

                    const SizedBox(height: 30),

                    // Button Login
                    FilledButtonCustom(
                        width: double.infinity,
                        height: 50,
                        label: 'Continue',
                        onTap: (){
                          if(validate()){
                            login();

                          } else {
                            DInfo.dialogError(
                              context,
                              'Please Fill All Of Register Form Field',
                            );

                            DInfo.closeDialog(context, durationBeforeClose: Duration(milliseconds: 1200));
                          }
                        }
                    ),

                    const SizedBox(height: 30),

                    // To Register
                    Center(
                      child: InkWell(
                        onTap: (){
                          Get.toNamed('/register');
                        },

                        child: Text(
                          'Create a New Account',
                          style: greyTextStyle.copyWith(
                              fontSize: 16,
                              fontWeight: medium
                          ),
                        ),
                      ),
                    ),

                  ],
                ),

              ],
            ),

            // Loading Bar
            if(isLoading)
              Stack(
                children: [
                  // Overlay
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.black.withOpacity(0.2),
                  ),

                  // Circular Bar
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
                ],
              ),

          ],
        );
      })
    );
  }
}
