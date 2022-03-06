import 'dart:developer';

import 'package:bloc_sample/cubits/auth_cubit/auth_cubit.dart';
import 'package:bloc_sample/cubits/auth_cubit/auth_state.dart';
import 'package:bloc_sample/screens/counterScreen.dart';
import 'package:bloc_sample/screens/homescreen.dart';
import 'package:bloc_sample/screens/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_sample/blocks/todos/todos_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'blocks/bloc/counter_bloc_bloc.dart';
import 'model/todoModel.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedStorage storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );
  await Firebase.initializeApp();
  HydratedBlocOverrides.runZoned(
    (() => runApp(MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => TodosBloc()
                ..add(LoadTodo(todos: [
                  Todo(
                    id: "1",
                    description: "Flutter Bloc",
                    isCompleted: false,
                    isCancelled: false,
                    task: 'Study Bloc',
                  ),
                  Todo(
                    id: "2",
                    description: "Flutter Getx",
                    task: 'Study Getx',
                  )
                ])),
            ),
            BlocProvider(create: (context) => AuthCubit()),
            BlocProvider(
              create: (context) => CounterBloc(),
            )
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: BlocBuilder<AuthCubit, AuthState>(
              buildWhen: (oldState, newState) {
                return oldState is AuthInitialState;
              },
              builder: (context, state) {
                return state is AuthLoggedoutState
                    ? Login()
                    : state is AuthLoggedInState
                        ? const CounterPage()
                        : const Scaffold();
              },
            ),
          ),
        ))),
    storage: storage,
  );
}
