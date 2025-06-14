part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

final class LoadTasksFromDBEvent extends HomeEvent {
  const LoadTasksFromDBEvent();
}

final class CreateTaskEvent extends HomeEvent {
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

final class DeleteTaskEvent extends HomeEvent {
  final String id;

  const DeleteTaskEvent({required this.id});

  @override
  List<Object?> get props => [id];
}

final class UpdateTaskEvent extends HomeEvent {
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
