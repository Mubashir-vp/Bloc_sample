import 'package:flutter/material.dart';

class LoginUsingEmail extends StatelessWidget {
  const LoginUsingEmail({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(
                20.0,
              ),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Email",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(
                20.0,
              ),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Password",
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text(
                "Verify Me",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
