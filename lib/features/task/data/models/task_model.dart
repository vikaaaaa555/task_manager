import '../../domain/entities/task_entity.dart';

class TaskModel extends TaskEntity {
  TaskModel({required super.id, required super.title, required super.dueDate});

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
    id: json['id'],
    title: json['title'],
    dueDate: DateTime.fromMillisecondsSinceEpoch(json['dueDate']),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'dueDate': dueDate.millisecondsSinceEpoch,
  };
}
