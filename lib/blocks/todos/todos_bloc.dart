import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../model/todoModel.dart';

part 'todos_event.dart';

part 'todos_state.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
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
}
