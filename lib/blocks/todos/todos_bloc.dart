import 'dart:developer';
import 'package:bloc_sample/model/todoModel.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:meta/meta.dart';
import '../../model/todoModel.dart';
part 'todos_event.dart';
part 'todos_state.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  // @override
  // TodosState? fromJson(Map<String, dynamic> json) {
  //   TodosState.f
  // }

  // @override
  // Map<String, dynamic>? toJson(TodosState state) {
  //   return state.toMap();
  // }

  // @override
  // TodosState get initialState {
  //   return super.initialState ?? TodosState();
  // }

  TodosBloc()
      : super(
          TodosState(),
        ) {
    on<LoadTodo>(
      _loadTodo,
    );
    on<AddTodo>(
      _addTodo,
    );
    on<Update>(
      _updateTodo,
    );
    on<Delete>(
      _delete,
    );
  }
  _loadTodo(
    LoadTodo event,
    Emitter<TodosState> emit,
  ) {
    emit(
      TodosLoaded(
        todos: event.todos,
      ),
    );
  }

  _addTodo(
    AddTodo event,
    Emitter<TodosState> emit,
  ) {
    final state = this.state;
    if (state is TodosLoaded) {
      emit(
        TodosLoaded(
          todos: List.from(
            state.todos,
          )..add(
              event.todo,
            ),
        ),
      );
    }
  }

  _updateTodo(
    Update event,
    Emitter<TodosState> emit,
  ) {}
  _delete(
    Delete event,
    Emitter<TodosState> emit,
  ) {
    final state = this.state;
    if (state is TodosLoaded) {
      List<Todo> todos = state.todos.where((todo) {
        return todo.id != event.todo.id;
      }).toList();
      emit(TodosLoaded(todos: todos));
    }
  }
 


  // @override
  // TodosLoaded? fromJson(Map<String, dynamic> json) => json['value'];

  // @override
  // Map<String, dynamic>? toJson(TodosState state) => {'value': state};
}
