import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:bloc_sample/blocks/todos/todos_bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import '/model/todoModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'dbbloc_event.dart';
part 'dbbloc_state.dart';

class DbblocBloc extends Bloc<DbblocEvent, DbblocState> {
  DbblocBloc() : super(TodosLoading()) {
    on<LoadTodo>(_loadTodo);
    on<AddTodo>(_addTodo);
    on<UpdateTodo>(_updateTodo);
    on<DeleteTodo>(_deleteTodo);
  }
  _addTodo(
    AddTodo event,
    Emitter<DbblocState> emit,
  ) async {
    
    try {
      await FirebaseFirestore.instance
          .collection(
            'todos',
          )
          .doc(event.todos.id)
          .set(
            event.todos.toJson(),
            SetOptions(merge: true)
          );
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance
              .collection(
                'todos',
              )
              .get();
      List<Todo> models =
          snapshot.docs.map((e) => Todo.fromJson(e.data())).toList();
      emit(TodosLoaded(todos: models));
    } catch (e) {
      log(
        "Error message is $e",
      );
    }
  }

  _loadTodo(
    LoadTodo event,
    Emitter<DbblocState> emit,
  ) async {
    // emit(TodosLoaded(todos: event.todos));
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
      emit(EmptyTodos());
    }
  }

  void _updateTodo(
    UpdateTodo event,
    Emitter<DbblocState> emit,
  ) async {
    try {
      await FirebaseFirestore.instance
          .collection(
            'todos',
          )
          .doc(event.todos.id)
          .update(
            event.todos.toJson(),
          );
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance
              .collection(
                'todos',
              )
              .get();
      List<Todo> models =
          snapshot.docs.map((e) => Todo.fromJson(e.data())).toList();
      emit(TodosLoaded(todos: models));
    } catch (e) {
      log(
        "Error message is $e",
      );
    }

  }

  void _deleteTodo(
    DeleteTodo event,
    Emitter<DbblocState> emit,
  )async {
     try {
      await FirebaseFirestore.instance
          .collection(
            'todos',
          )
          .doc(event.todos.id)
          .delete(
          );
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance
              .collection(
                'todos',
              )
              .get();
      List<Todo> models =
          snapshot.docs.map((e) => Todo.fromJson(e.data())).toList();
      emit(TodosLoaded(todos: models));
    } catch (e) {
      log(
        "Error message is $e",
      );
    }
  }
}
