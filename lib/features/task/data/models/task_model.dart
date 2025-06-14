import '../../../../core/utils/typedefs.dart';
import '../../domain/entities/task_entity.dart';

class TaskModel extends TaskEntity {
  TaskModel({
    required super.id,
    required super.title,
    required super.description,
    required super.dueDate,
  });

  factory TaskModel.fromJson(Json json) => TaskModel(
    id: json['id'],
    title: json['title'],
    description: json['description'],
    dueDate: DateTime.fromMillisecondsSinceEpoch(json['dueDate']),
  );

  Json toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'dueDate': dueDate.millisecondsSinceEpoch,
  };
}
