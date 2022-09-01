part of 'dbbloc_bloc.dart';

@immutable
abstract class DbblocEvent {
  const DbblocEvent();
  @override
  List<Object> get props => [];
}

class LoadTodo extends DbblocEvent {
   final List<Todo> todos;
 const LoadTodo({this.todos=const <Todo>[]} );
 @override
  List<Object> get props => [todos];
}
class AddTodo extends DbblocEvent {
   final Todo todos;
 const AddTodo({required this.todos,} );
 @override
  List<Object> get props => [todos];
}
class UpdateTodo extends DbblocEvent {
  final Todo todos;
 const UpdateTodo({required this.todos} );
 @override
  List<Object> get props => [todos];
}
class DeleteTodo extends DbblocEvent {
  final Todo todos;
 const DeleteTodo({required this.todos} );
 @override
  List<Object> get props => [todos];
}
