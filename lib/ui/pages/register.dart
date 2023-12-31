
import 'package:bukuku/models/auth/register_model.dart';
import 'package:bukuku/shared/theme.dart';
import 'package:bukuku/shared/values.dart';
import 'package:bukuku/ui/widgets/button_custom.dart';
import 'package:bukuku/ui/widgets/input_form_custom.dart';
import 'package:flutter/material.dart';
import 'package:d_info/d_info.dart';
import 'package:get/get.dart';

import '../../controllers/auth_controller.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final registerStateController = Get.put(AuthController());

  final nameController = TextEditingController(text: '');
  final emailController = TextEditingController(text: '');
  final passwordController = TextEditingController(text: '');
  final passworValidateController = TextEditingController(text: '');

  bool validate(){
    if(nameController.text.isEmpty || emailController.text.isEmpty ||
        passwordController.text.isEmpty || passworValidateController.text.isEmpty){
      return false;
    }

    return true;
  }

  register() async {
    final registerSuccess = await registerStateController.registerUser(
        RegisterRequestModel(
          name: nameController.text,
          email: emailController.text,
          password: passwordController.text,
          passwordConfirmation: passworValidateController.text,
        )
    );

    if(registerSuccess){
      if(!context.mounted) return;
      DInfo.dialogSuccess(context, 'Register Success');
      DInfo.closeDialog(
          context,
          durationBeforeClose: const Duration(seconds: 1),
          actionAfterClose: (){
            registerStateController.clearState();
            Get.offAllNamed('/login');
          }
      );

    } else {
      if(!context.mounted) return;
      final registerResponseMessage = registerStateController.registerResponse!.message.toString();
      DInfo.dialogError(context, registerResponseMessage);
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
          final isLoading = registerStateController.isLoading.value;

          return Stack(
            children: [

              // Main Content
              ListView(
                padding: const EdgeInsets.only(left: 22, right: 22, top: 40, bottom: 22),
                children: [

                  // Register Logo
                  Center(
                    child: Container(
                      width: 160,
                      height: 200,

                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage(authLogo),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 60),

                  // Register Copywrite
                  Text(
                    'Create\nNew Account',
                    style: blackTextStyle.copyWith(
                        fontSize: 20,
                        fontWeight: semiBold
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Register Form Container
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      // Full Name
                      AuthInputCustom(
                        formLabel: 'Full Name',
                        obscureText: false,
                        controller: nameController,
                      ),

                      const SizedBox(height: 16),

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

                      const SizedBox(height: 16),

                      // Password Confirmation
                      AuthInputCustom(
                        formLabel: 'Password Confirmation',
                        obscureText: true,
                        controller: passworValidateController,
                      ),

                      const SizedBox(height: 30),

                      // Button Register
                      FilledButtonCustom(
                          width: double.infinity,
                          height: 50,
                          label: 'Register',
                          onTap: (){
                            if(validate()){

                              if(passwordController.text != passworValidateController.text){
                                DInfo.dialogError(
                                  context,
                                  'The password confirmation does not match ',
                                );

                                DInfo.closeDialog(context, durationBeforeClose: const Duration(milliseconds: 1400));

                              } else {
                                register();
                              }

                            } else {
                              DInfo.dialogError(
                                context,
                                'Please Fill All Of Register Form Field',
                              );

                              DInfo.closeDialog(context, durationBeforeClose: const Duration(milliseconds: 1200));
                            }
                          }
                      ),

                      const SizedBox(height: 30),

                      // To Login
                      Center(
                        child: InkWell(
                          onTap: (){
                            Get.toNamed('/login');
                          },

                          child: Text(
                            'Sign In To My Account',
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
