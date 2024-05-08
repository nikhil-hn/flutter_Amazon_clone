import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final String tittle;
  final bool obscureText;
  final TextEditingController controller;
  bool signinPagePass;

  TextFieldWidget(
      {super.key,
      required this.tittle,
      required this.obscureText,
      required this.controller,
      this.signinPagePass = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              tittle,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            signinPagePass
                ? GestureDetector(
                    child: const Text(
                      'Forget Password',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(255, 3, 96, 172)),
                    ),
                  )
                : const SizedBox(
                    height: 0,
                    width: 0,
                  )
          ],
        ),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 1, horizontal: 3),
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'enter $tittle';
            } else if (tittle == 'Email') {
              if (!value.contains('@')) {
                return 'enter a valid $tittle';
              }
            }
            return null;
          },
        )
      ],
    );
  }
}
