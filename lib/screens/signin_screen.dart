import 'package:amazon_clone/layout/screen_layout.dart';
import 'package:amazon_clone/resources/authentication_methods.dart';
import 'package:amazon_clone/screens/signup_screen.dart';
import 'package:amazon_clone/sharedPreference/shared_pref.dart';
import 'package:amazon_clone/utils/color_theme.dart';
import 'package:amazon_clone/utils/constants.dart';
import 'package:amazon_clone/utils/utils.dart';
import 'package:amazon_clone/widget/custom_button.dart';
import 'package:amazon_clone/widget/text_field_widget.dart';
import 'package:flutter/material.dart ';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  AuthenticationMethods authenticationMethods = AuthenticationMethods();
  final _keySignIn = GlobalKey<FormState>();
  bool isLoading = false;
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: SizedBox(
            height: screenSize.height,
            width: screenSize.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.network(
                      amazonLogo,
                      height: screenSize.height * 0.1,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: screenSize.height * 0.6,
                      width: screenSize.width * 0.8,
                      decoration: BoxDecoration(
                        border: Border.all(width: 0.7),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Form(
                          key: _keySignIn,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Sign-In",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 33),
                              ),
                              TextFieldWidget(
                                  controller: _emailController,
                                  tittle: 'Email',
                                  obscureText: false),
                              TextFieldWidget(
                                signinPagePass: true,
                                tittle: 'Password',
                                obscureText: true,
                                controller: _passController,
                              ),
                              Align(
                                alignment: Alignment.topCenter,
                                child: CustomMainButton(
                                    color: yellowColor,
                                    isLoading: isLoading,
                                    onPressed: () async {
                                      if (_keySignIn.currentState!.validate()) {
                                        //signin functions

                                        SharedPref().loggIn();

                                        String output =
                                            await authenticationMethods.signIn(
                                                _emailController.text,
                                                _passController.text);
                                        if (output == 'success') {
                                          Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                            builder: (context) =>
                                                const ScreenLayout(),
                                          ));
                                          debugPrint(output);
                                        } else {
                                          debugPrint(output);
                                          Utils().showSnackBar(
                                              context: context,
                                              content: output);
                                          //error feedback
                                        }
                                      }
                                    },
                                    child: const Text(
                                      'Login',
                                      style: TextStyle(color: Colors.black),
                                    )),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: 1,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Text(
                                      "New to Amazon?",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: 1,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              Center(
                                child: CustomMainButton(
                                  color: Colors.grey[300]!,
                                  isLoading: false,
                                  onPressed: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) =>
                                          const SignUpScreen(),
                                    ));
                                  },
                                  child: const Text(
                                    'I am a new customer',
                                    style: TextStyle(
                                      letterSpacing: 0.6,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
