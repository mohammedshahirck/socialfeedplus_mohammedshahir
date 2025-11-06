import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:socialfeedplus_mohammedshahir/features/auth/controllers/auth_controller.dart';
import 'package:socialfeedplus_mohammedshahir/shared/widgets/custom_gradient_button.dart';
import 'package:socialfeedplus_mohammedshahir/shared/widgets/custom_text_form_field.dart';


class AuthScreen extends GetView<AuthController> {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formGlobalKey = GlobalKey<FormState>();
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Form(
              key: formGlobalKey,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: Obx(() {
                  final isSignup = controller.isSignupMode.value;
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        isSignup ? "Create Account" : "SocialFeed+",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 30),
                      if (controller.isSignupMode.value)
                        CustomTextFormField(
                          controller: controller.emailController,
                          validator: controller.validateEmail,
                          keyboardType: TextInputType.name,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r'[a-zA-Z0-9@._\-+]'),
                            ),
                          ],
                          labelText: 'Email',
                          prefixIcon: Icons.mail,
                        ),
                      const SizedBox(height: 30),
                      CustomTextFormField(
                        controller: controller.userNameController,
                        validator: controller.validateUsername,
                        keyboardType: TextInputType.name,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'[a-zA-Z0-9_ ]'),
                          ),
                        ],
                        labelText: 'User Name',
                        prefixIcon: Icons.person,
                      ),
                      const SizedBox(height: 20),
                      CustomTextFormField(
                        controller: controller.passwordController,
                        validator: controller.validatePassword,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: controller.obscurePassword.value,
                        labelText: 'Password',
                        prefixIcon: Icons.lock_outline,
                        suffixIcon: IconButton(
                          icon: Icon(
                            controller.obscurePassword.value
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: controller.togglePasswordVisibility,
                        ),
                      ),
                      const SizedBox(height: 20),
                      if (controller.isSignupMode.value)
                        CustomTextFormField(
                          controller: controller.confirmPasswordController,
                          validator: controller.validateConfirmPassword,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: controller.obscureConfirmPassword.value,
                          labelText: 'Confirm Password',
                          prefixIcon: Icons.lock,
                          suffixIcon: IconButton(
                            icon: Icon(
                              controller.obscureConfirmPassword.value
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed:
                                controller.toggleConfirmPasswordVisibility,
                          ),
                        ),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: CustomGradientButton(
                          onPressed: () {
                            if (isSignup) {
                              controller.signup(formGlobalKey);
                            } else {
                              controller.login(formGlobalKey);
                            }
                          },
                          text: isSignup ? "Sign Up" : "Login",
                        ),
                      ),

                      const SizedBox(height: 20),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: isSignup
                              ? 'Already have an account? '
                              : 'Don’t have an account? ',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),

                          children: [
                            TextSpan(
                              text: isSignup ? ' Login' : ' Sign Up',
                              style: const TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = controller.toggleAuthMode,
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
