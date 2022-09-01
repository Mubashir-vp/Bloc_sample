part of 'firebase_todo_bloc.dart';

@immutable
abstract class FirebaseTodoEvent {}



class LoadTodo extends FirebaseTodoEvent {
  final List<Todo> todos;
  LoadTodo({this.todos = const <Todo>[]});
  List<Object> get props => [todos];
}

class AddTodo extends FirebaseTodoEvent {
  final Todo todo;
  AddTodo({required this.todo});
    List<Object> get props => [todo];

}

class Update extends FirebaseTodoEvent {
    final Todo todo;
  Update({required this.todo});
    List<Object> get props => [todo];

}

class Delete extends FirebaseTodoEvent {
    final Todo todo;
  Delete({required this.todo});
    List<Object> get props => [todo];
    

}