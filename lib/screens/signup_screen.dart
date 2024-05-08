import 'package:amazon_clone/resources/authentication_methods.dart';
import 'package:amazon_clone/screens/signin_screen.dart';
import 'package:amazon_clone/utils/color_theme.dart';
import 'package:amazon_clone/utils/constants.dart';
import 'package:amazon_clone/utils/utils.dart';
import 'package:amazon_clone/widget/custom_button.dart';
import 'package:amazon_clone/widget/text_field_widget.dart';

import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  AuthenticationMethods authenticationMethods = AuthenticationMethods();

  final _keySignUp = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    addressController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SizedBox(
          height: screenSize.height,
          width: screenSize.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.network(
                    amazonLogo,
                    height: screenSize.height * 0.10,
                  ),
                  SizedBox(
                    height: screenSize.height * 0.7,
                    child: FittedBox(
                      child: Container(
                        height: screenSize.height * 0.85,
                        width: screenSize.width * 0.85,
                        padding: const EdgeInsets.all(25),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                        child: Form(
                          key: _keySignUp,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Sign-Up",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 33),
                              ),
                              TextFieldWidget(
                                tittle: "Name",
                                controller: nameController,
                                obscureText: false,
                              ),
                              TextFieldWidget(
                                tittle: "Address",
                                controller: addressController,
                                obscureText: false,
                              ),
                              TextFieldWidget(
                                tittle: "Email",
                                controller: emailController,
                                obscureText: false,
                              ),
                              TextFieldWidget(
                                tittle: "Password",
                                controller: passwordController,
                                obscureText: true,
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: CustomMainButton(
                                  color: yellowColor,
                                  isLoading: isLoading,
                                  onPressed: () async {
                                    if (_keySignUp.currentState!.validate()) {
                                      setState(() {
                                        isLoading = true;
                                      });
                                      String output =
                                          await authenticationMethods
                                              .signUpWithEmailandPassword(
                                                  nameController.text,
                                                  emailController.text,
                                                  addressController.text,
                                                  passwordController.text);
                                      setState(() {
                                        isLoading = false;
                                      });
                                      if (output == "success") {
                                        debugPrint(output);
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    const SignInScreen()));
                                      } else {
                                        //error
                                        Utils().showSnackBar(
                                            context: context, content: output);
                                      }
                                    }
                                  },
                                  child: const Text(
                                    "Sign Up",
                                    style: TextStyle(
                                        letterSpacing: 0.6,
                                        color: Colors.black),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  CustomMainButton(
                      color: Colors.grey[400]!,
                      isLoading: false,
                      onPressed: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                          return const SignInScreen();
                        }));
                      },
                      child: const Text(
                        "Back",
                        style: TextStyle(
                          letterSpacing: 0.6,
                          color: Colors.black,
                        ),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
