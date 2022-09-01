part of 'dbbloc_bloc.dart';

@immutable
abstract class DbblocState extends Equatable {
  const DbblocState();
  @override
  List<Object> get props => [];
}

class TodosLoading extends DbblocState {}

class TodosLoaded extends DbblocState {
  final List<Todo> todos;
 const TodosLoaded({this.todos=const <Todo>[]} );
 @override
  List<Object> get props => [todos];
}
class EmptyTodos extends DbblocState{}
