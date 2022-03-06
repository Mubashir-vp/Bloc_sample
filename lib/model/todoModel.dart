import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
part 'todoModel.g.dart';
Todo todoFromJson(String str) => Todo.fromJson(json.decode(str));

String todoToJson(Todo data) => json.encode(data.toJson());

@JsonSerializable()



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
      this.isCompleted
      });
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

    factory Todo.fromJson(Map<String, dynamic> json) => Todo(
        id: json["id"],
        description: json["description"],
        isCompleted: json["isCompleted"],
        isCancelled: json["isCancelled"],
        task: json["task"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "isCompleted": isCompleted,
        "isCancelled": isCancelled,
        "task": task,
    };
}

