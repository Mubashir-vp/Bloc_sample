import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  final String id;
  final String task;
  final String description;
  bool? isCompleted;
  bool? isCancelled;
  Todo(
      {required this.id,
      required this.task,
      required this.description,
       this.isCancelled,
       this.isCompleted});
  Todo copyWith(
      {String? id,
      String? task,
      String? description,
      bool? isCompleted,
      bool? isCancelled}) {
    return Todo(
      id: id ?? this.id,
      task: task ?? this.task,
      description: description ?? this.description,
      isCancelled: isCancelled ?? this.isCancelled,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  List<Object?> get props => [
        id,
        task,
        description,
        isCancelled,
        isCompleted,
      ];
  static List<Todo> todos = [
    Todo(
      id: "1",
      description: "Flutter Bloc",
      isCompleted: false,
      isCancelled: false,
      task: 'Study Bloc',
    ),
    Todo(
      id: "2",
      description: "Flutter Getx",
      task: 'Study Getx',
    )
  ];
}
