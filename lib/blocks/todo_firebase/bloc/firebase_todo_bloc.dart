import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '/model/todoModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'firebase_todo_event.dart';
part 'firebase_todo_state.dart';

class FirebaseTodoBloc extends Bloc<FirebaseTodoEvent, FirebaseTodoState> {
  FirebaseTodoBloc() : super(FirebaseTodoState()) {
    on<AddTodo>((event, emit) {
      _addTodo;
    });
    on<LoadTodo>(
      (event, emit) {
        _loadTodo;
      },
    );
  }
  _addTodo(
    AddTodo event,
    Emitter<FirebaseTodoState> emit,
  ) async {
    try {
              log("message${event.todo.id}");

      if (state is TodosLoaded) {
        await FirebaseFirestore.instance
            .collection(
              'todos',
            )
            .doc(event.todo.id)
            .set(
              event.todo.toJson(),
            );
      }
    } catch (e) {
      log(
        "Error message is $e",
      );
    }
  }

  _loadTodo(
    AddTodo event,
    Emitter<FirebaseTodoState> emit,
  ) async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance
            .collection(
              'todos',
            )
            .get();

    if (snapshot.docs.isNotEmpty) {
      List<Todo> models =
          snapshot.docs.map((e) => Todo.fromJson(e.data())).toList();
      emit(TodosLoaded(todos: models));
    } else {
      emit(EmptyState());
    }
  }
}
