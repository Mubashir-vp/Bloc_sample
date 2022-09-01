import 'dart:developer';

import 'package:bloc_sample/blocks/bloc/appBlocobserver.dart';
import 'package:bloc_sample/cubits/auth_cubit/auth_cubit.dart';
import 'package:bloc_sample/cubits/auth_cubit/auth_state.dart';
import 'package:bloc_sample/new_blocks/apiBloc/bloc/apibloc_bloc.dart';
import 'package:bloc_sample/new_blocks/firebaseBloc/dbbloc_bloc.dart';
import 'package:bloc_sample/screens/homescreen.dart';
import 'package:bloc_sample/screens/loginSelectionScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'blocks/bloc/counter_bloc_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedStorage storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );
  await Firebase.initializeApp();
  HydratedBlocOverrides.runZoned(
    (() => runApp(
          MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => DbblocBloc()
                  ..add(
                    const LoadTodo(),
                  ),
              ),
              BlocProvider(create: (context) => AuthCubit()),
              BlocProvider(
                create: (context) => CounterBloc(),
              ),
              BlocProvider(
                create: (context) => ApiblocBloc()
                  ..add(
                    const LoadData(),
                  ),
              ),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              home: BlocBuilder<AuthCubit, AuthState>(
                buildWhen: (oldState, newState) {
                  return oldState is AuthInitialState;
                },
                builder: (context, state) {
                  return state is AuthLoggedoutState
                      ? const LoginSelectionScreen()
                      : state is AuthLoggedInState
                          ? HomeScreen()
                          : const Scaffold();
                },
              ),
            ),
          ),
        )),
    blocObserver: AppBlocObserver(),
    storage: storage,
  );
}
