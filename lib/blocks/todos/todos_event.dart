part of 'todos_bloc.dart';

@immutable
abstract class TodosEvent {}

class LoadTodo extends TodosEvent {
  final List<Todo> todos;
  LoadTodo({this.todos = const <Todo>[]});
  List<Object> get props => [todos];
}

class AddTodo extends TodosEvent {
  final Todo todo;
  AddTodo({required this.todo});
    List<Object> get props => [todo];

}

class Update extends TodosEvent {
    final Todo todo;
  Update({required this.todo});
    List<Object> get props => [todo];

}

class Delete extends TodosEvent {
    final Todo todo;
  Delete({required this.todo});
    List<Object> get props => [todo];
    

}
