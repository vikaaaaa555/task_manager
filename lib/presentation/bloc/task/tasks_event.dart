part of 'tasks_bloc.dart';

sealed class TasksEvent extends Equatable {
  const TasksEvent();

  @override
  List<Object?> get props => [];
}

final class LoadTasksFromDBEvent extends TasksEvent {
  const LoadTasksFromDBEvent();
}

final class CreateTaskEvent extends TasksEvent {
  final String title;
  final String description;
  final DateTime dueDate;

  const CreateTaskEvent({
    required this.title,
    required this.description,
    required this.dueDate,
  });

  @override
  List<Object?> get props => [title, description, dueDate];
}

final class DeleteTaskEvent extends TasksEvent {
  final String id;

  const DeleteTaskEvent({required this.id});

  @override
  List<Object?> get props => [id];
}

final class UpdateTaskEvent extends TasksEvent {
  final String id;
  final String title;
  final String description;
  final DateTime dueDate;

  const UpdateTaskEvent({
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
  });

  @override
  List<Object?> get props => [id, title, description, dueDate];
}
