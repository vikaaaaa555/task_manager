part of 'tasks_bloc.dart';

sealed class TasksState extends Equatable {
  const TasksState();

  @override
  List<Object?> get props => [];
}

final class TasksInitial extends TasksState {
  const TasksInitial();
}

final class TasksLoading extends TasksState {
  const TasksLoading();
}

final class TasksLoadSuccess extends TasksState {
  final List<TaskEntity>? tasks;

  const TasksLoadSuccess({required this.tasks});

  @override
  List<Object?> get props => [tasks];
}

final class TasksFailure extends TasksState {
  final String message;

  const TasksFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
