import 'dart:developer';
import 'dart:ui';

import 'package:bloc_sample/cubits/auth_cubit/auth_cubit.dart';
import 'package:bloc_sample/cubits/auth_cubit/auth_state.dart';
import 'package:bloc_sample/screens/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Login extends StatelessWidget {
  Login({
    Key? key,
  }) : super(
          key: key,
        );
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(
    BuildContext context,
  ) {
    TextEditingController _textEditingController = TextEditingController();
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: formkey,
              child: Padding(
                padding: const EdgeInsets.all(
                  40.0,
                ),
                child: TextFormField(
                  keyboardType: const TextInputType.numberWithOptions(),
                  validator: ((value) {
                    if (value!.isEmpty) {
                      return "Enter the mobile Number";
                    } else if (value.length != 10) {
                      return "Enter a correct Mobile Number";
                    }
                    return null;
                  }),
                  controller: _textEditingController,
                  decoration: const InputDecoration(
                    hintText: "Enter Your Phone no",
                  ),
                ),
              ),
            ),
            BlocConsumer<AuthCubit, AuthState>(listener: (context, state) {
              if (state is AuthCodeSendState) {
                showModalBottomSheet(
                    context: context,
                    builder: (
                      BuildContext context,
                    ) {
                      return BlocConsumer<AuthCubit, AuthState>(
                        listener: (context, state) {
                          if (state is AuthLoggedInState) {
                            Navigator.popUntil(
                              context,
                              (route) => route.isFirst,
                            );
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomeScreen(),
                              ),
                            );
                          } else if (state is AuthErrorState) {
                            ScaffoldMessenger.of(
                              context,
                            ).showSnackBar(
                              SnackBar(
                                content: Text(
                                  state.errorMessage.toString(),
                                ),
                              ),
                            );
                            Navigator.pop(context);
                          }
                        },
                        builder: (context, state) {
                          return SingleChildScrollView(
                            child: SizedBox(
                              height: MediaQuery.of(
                                    context,
                                  ).size.height /
                                  1.4,
                              child: Center(
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 18,
                                    ),
                                    const Text(
                                      "Enter OTP code sent to your number",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 18,
                                    ),
                                    Text(
                                      _textEditingController.text,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    OtpTextField(
                                      numberOfFields: 6,
                                      borderColor: Colors.black,
                                      focusedBorderColor: Colors.greenAccent,
                                      showFieldAsBox: true,
                                      onCodeChanged: (
                                        String code,
                                      ) {},
                                      onSubmit: (
                                        String verificationCode,
                                      ) {
                                        print(state);
                                        BlocProvider.of<AuthCubit>(context)
                                            .verifyOtp(
                                          verificationCode,
                                        );
                                        print(state);
                                      },
                                    ),
                                    state is AuthLoadingState
                                        ? const Center(
                                            child: CircularProgressIndicator(),
                                          )
                                        :const SizedBox(
                                            height: 18,
                                          ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    });
              } else if (state is AuthErrorState) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(
                  SnackBar(
                    duration: const Duration(
                      milliseconds: 500,
                    ),
                    content: Text(
                      state.errorMessage.toString(),
                    ),
                  ),
                );
                log(state.errorMessage.toString());
              }
            }, builder: (context, state) {
              if (state is AuthLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return TextButton(
                onPressed: () {
                  if (formkey.currentState!.validate()) {
                    BlocProvider.of<AuthCubit>(context).sendOtp(
                      "+91" + _textEditingController.text,
                    );
                  }
                },
                child: const Text(
                  "Verify Me",
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
