part of 'firebase_todo_bloc.dart';

@immutable
 class FirebaseTodoState {}

class FirebaseTodoInitial extends FirebaseTodoState {
  FirebaseTodoInitial();
}

class Loading extends FirebaseTodoState {
  Loading();
}

class EmptyState extends FirebaseTodoState {
  EmptyState();
}

class TodosLoaded extends FirebaseTodoState {
  final List<Todo> todos;
  TodosLoaded({this.todos = const <Todo>[]});
  @override
  List<Object> get props => [todos];
}

class TodosLoading extends FirebaseTodoState {
  final List<Todo> todos;
  TodosLoading({this.todos = const <Todo>[]});
  @override
  List<Object> get props => [todos];
}
