import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../features/task/domain/entities/task_entity.dart';
import '../../../features/task/domain/use_cases/create_task.dart';
import '../../../features/task/domain/use_cases/delete_task.dart';
import '../../../features/task/domain/use_cases/get_all_tasks.dart';
import '../../../features/task/domain/use_cases/update_task.dart';

part 'home_event.dart';
part 'home_state.dart';

/// BLoC responsible for managing home-related state and business logic.
///
/// Handles:
/// - Loading tasks from the database
/// - Creating new tasks
/// - Updating existing tasks
/// - Deleting tasks
///
/// Communicates with use cases to perform these operations and emits appropriate states.
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetAllTasksUseCase getAllTasksUseCase;
  final CreateTaskUseCase createTaskUseCase;
  final DeleteTaskUseCase deleteTaskUseCase;
  final UpdateTaskUseCase updateTaskUseCase;

  HomeBloc({
    required this.getAllTasksUseCase,
    required this.createTaskUseCase,
    required this.deleteTaskUseCase,
    required this.updateTaskUseCase,
  }) : super(const HomeInitial()) {
    on<LoadTasksFromDBEvent>(_handleLoadTasksFromDBEvent);
    on<CreateTaskEvent>(_handleCreateTaskEvent);
    on<DeleteTaskEvent>(_handleDeleteTaskEvent);
    on<UpdateTaskEvent>(_handleUpdateTaskEvent);
  }

  /// Handles [LoadTasksFromDBEvent] to load all tasks from the database.
  ///
  /// Emits:
  /// - [HomeLoading] when operation starts
  /// - [HomeTasksLoadSuccess] with list of tasks if successful
  /// - [HomeError] if an error occurs
  Future<void> _handleLoadTasksFromDBEvent(
    LoadTasksFromDBEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(const HomeLoading());
    try {
      final tasks = await getAllTasksUseCase();
      emit(HomeTasksLoadSuccess(tasks: tasks));
    } catch (e) {
      emit(HomeError(message: e.toString()));
    }
  }

  /// Handles [CreateTaskEvent] to create a new home.
  ///
  /// Triggers [LoadTasksFromDBEvent] after successful creation
  Future<void> _handleCreateTaskEvent(
    CreateTaskEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(const HomeLoading());
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
      emit(HomeError(message: e.toString()));
    }
  }

  /// Handles [CreateTaskEvent] to create a new home.
  ///
  /// Triggers [LoadTasksFromDBEvent] after successful creation
  Future<void> _handleDeleteTaskEvent(
    DeleteTaskEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(const HomeLoading());
    try {
      await deleteTaskUseCase(DeleteTaskParams(id: event.id));
      add(LoadTasksFromDBEvent());
    } catch (e) {
      emit(HomeError(message: e.toString()));
    }
  }

  /// Handles [DeleteTaskEvent] to delete a home by ID.
  ///
  /// Triggers [LoadTasksFromDBEvent] after successful creation
  Future<void> _handleUpdateTaskEvent(
    UpdateTaskEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(const HomeLoading());
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
      emit(HomeError(message: e.toString()));
    }
  }
}
