import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../features/task/domain/entities/task_entity.dart';
import '../../../features/task/domain/use_cases/create_task.dart';
import '../../../features/task/domain/use_cases/delete_task.dart';
import '../../../features/task/domain/use_cases/get_all_tasks.dart';
import '../../../features/task/domain/use_cases/update_task.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

/// BLoC responsible for managing task-related state and business logic.
///
/// Handles:
/// - Loading tasks from the database
/// - Creating new tasks
/// - Updating existing tasks
/// - Deleting tasks
///
/// Communicates with use cases to perform these operations and emits appropriate states.
class TasksBloc extends Bloc<TasksEvent, TasksState> {
  final GetAllTasksUseCase getAllTasksUseCase;
  final CreateTaskUseCase createTaskUseCase;
  final DeleteTaskUseCase deleteTaskUseCase;
  final UpdateTaskUseCase updateTaskUseCase;

  TasksBloc({
    required this.getAllTasksUseCase,
    required this.createTaskUseCase,
    required this.deleteTaskUseCase,
    required this.updateTaskUseCase,
  }) : super(const TasksInitial()) {
    on<LoadTasksFromDBEvent>(_handleLoadTasksFromDBEvent);
    on<CreateTaskEvent>(_handleCreateTaskEvent);
    on<DeleteTaskEvent>(_handleDeleteTaskEvent);
    on<UpdateTaskEvent>(_handleUpdateTaskEvent);
  }

  /// Handles [LoadTasksFromDBEvent] to load all tasks from the database.
  ///
  /// Emits:
  /// - [TasksLoading] when operation starts
  /// - [TasksLoadSuccess] with list of tasks if successful
  /// - [TasksFailure] if an error occurs
  Future<void> _handleLoadTasksFromDBEvent(
    LoadTasksFromDBEvent event,
    Emitter<TasksState> emit,
  ) async {
    emit(const TasksLoading());
    try {
      final tasks = await getAllTasksUseCase();
      emit(TasksLoadSuccess(tasks: tasks));
    } catch (e) {
      emit(TasksFailure(message: e.toString()));
    }
  }

  /// Handles [CreateTaskEvent] to create a new task.
  ///
  /// Triggers [LoadTasksFromDBEvent] after successful creation
  Future<void> _handleCreateTaskEvent(
    CreateTaskEvent event,
    Emitter<TasksState> emit,
  ) async {
    emit(const TasksLoading());
    try {
      await createTaskUseCase(
        CreateTaskParams(
          title: event.title,
          description: event.description,
          dueDate: event.dueDate,
        ),
      );
      add(LoadTasksFromDBEvent());
    } catch (e) {
      emit(TasksFailure(message: e.toString()));
    }
  }

  /// Handles [CreateTaskEvent] to create a new task.
  ///
  /// Triggers [LoadTasksFromDBEvent] after successful creation
  Future<void> _handleDeleteTaskEvent(
    DeleteTaskEvent event,
    Emitter<TasksState> emit,
  ) async {
    emit(const TasksLoading());
    try {
      await deleteTaskUseCase(DeleteTaskParams(id: event.id));
      add(LoadTasksFromDBEvent());
    } catch (e) {
      emit(TasksFailure(message: e.toString()));
    }
  }

  /// Handles [DeleteTaskEvent] to delete a task by ID.
  ///
  /// Triggers [LoadTasksFromDBEvent] after successful creation
  Future<void> _handleUpdateTaskEvent(
    UpdateTaskEvent event,
    Emitter<TasksState> emit,
  ) async {
    emit(const TasksLoading());
    try {
      await updateTaskUseCase(
        UpdateTaskParams(
          id: event.id,
          title: event.title,
          description: event.description,
          dueDate: event.dueDate,
        ),
      );
      add(LoadTasksFromDBEvent());
    } catch (e) {
      emit(TasksFailure(message: e.toString()));
    }
  }
}
