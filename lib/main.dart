import 'package:bloc_sample/screens/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_sample/blocks/todos/todos_bloc.dart';

import 'model/todoModel.dart';
void main() {
  runApp(
    
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TodosBloc()..add(LoadTodo(
            todos: [
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
            ]
          )),
        ),
       
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    )
      
    
  );
}
