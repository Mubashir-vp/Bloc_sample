// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todoModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Todo _$TodoFromJson(Map<String, dynamic> json) {
  return Todo(
    id: json['id'] as String,
    task: json['task'] as String,
    description: json['description'] as String,
    isCancelled: json['isCancelled'] as bool,
    isCompleted: json['isCompleted'] as bool,
  );
}

Map<String, dynamic> _$TodoToJson(Todo instance) => <String, dynamic>{
      'id': instance.id,
      'task': instance.task,
      'description': instance.description,
      'isCompleted': instance.isCompleted,
      'isCancelled': instance.isCancelled,
    };
