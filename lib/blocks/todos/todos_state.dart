part of 'todos_bloc.dart';

class TodosState {
}

// class TodosInitial extends TodosState {
//   TodosInitial() : super(counterValue: 0);
// }

class TodosLoaded extends TodosState {
  final List<Todo> todos;
  TodosLoaded({this.todos = const <Todo>[]});
  @override
  List<Object> get props => [todos];
}
class TodosLoading extends TodosState {
  final List<Todo> todos;
  TodosLoading({this.todos = const <Todo>[]});
  @override
  List<Object> get props => [todos];
}