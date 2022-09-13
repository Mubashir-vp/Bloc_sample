import 'package:bloc_sample/cubits/auth_cubit/auth_cubit.dart';
import 'package:bloc_sample/cubits/auth_cubit/auth_state.dart';
import 'package:bloc_sample/model/todoModel.dart';
import 'package:bloc_sample/new_blocks/apiBloc/bloc/apibloc_bloc.dart';
import 'package:bloc_sample/new_blocks/firebaseBloc/dbbloc_bloc.dart';
import 'package:bloc_sample/screens/loginScreen.dart';
import 'package:bloc_sample/screens/loginSelectionScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ApiScreen extends StatelessWidget {
  ApiScreen({
    Key? key,
  }) : super(
          key: key,
        );
  TextEditingController idController = TextEditingController();
  TextEditingController taskControler = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  Todo? todo;
  @override
  Widget build(
    BuildContext context,
  ) {
    return SafeArea(
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthLoggedoutState) {
            Navigator.popUntil(
              context,
              (route) => route.isFirst,
            );
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginSelectionScreen(),
              ),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                    onPressed: () {
                      BlocProvider.of<AuthCubit>(context).logout();
                    },
                    icon: const Icon(Icons.exit_to_app))
              ],
              centerTitle: true,
              title: const Text(
                "Api Sample",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 20,
                ),
              ),
            ),
            body: BlocBuilder<ApiblocBloc, ApiblocState>(
              builder: (context, state) {
                if (state is DataLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is DataLoaded) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20.0,
                    ),
                    child: ListView.separated(
                      itemBuilder: (
                        BuildContext context,
                        index,
                      ) {
                        return Column(
                          children: [
                            SizedBox(
                              child: Text(state.weather.main!.humidity.toString()
                              ),
                            ),
                             SizedBox(
                              child: Text(state.weather.
                              main!.temp.toString()),
                            ),
                          ],
                        );
                      },
                      separatorBuilder: (
                        BuildContext context,
                        index,
                      ) {
                        return const SizedBox(
                          height: 14,
                        );
                      },
                      itemCount:10,
                    ),
                  );
                } else if (state is ErrorState) {
                  return  Center(
                    child: Text(
                      state.errorMessage
                    ),
                  );
                } else {
                  return const Center(
                    child: Text(
                      "Something Went Wrong",
                    ),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}
