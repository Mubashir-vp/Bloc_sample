import 'package:bloc_sample/screens/loginUsingEmail.dart';
import 'package:flutter/material.dart';

import 'loginScreen.dart';

class LoginSelectionScreen extends StatelessWidget {
  const LoginSelectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
               Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>  LoginUsingPhone(),
                ),
              );
          },
          child: const Text("SignIn using Phone "),
        ),
        ElevatedButton(
          onPressed: () {
               Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>const  LoginUsingEmail(),
                ),
              );
          },
          child: const Text("SignIn using Email "),
        ),
      ],
    ),
            )));
  }
}
