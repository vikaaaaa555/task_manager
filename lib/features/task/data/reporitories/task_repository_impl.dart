import '../../domain/repositories/task_repository.dart';
import '../data_sources/task_remote_data_source.dart';
import '../models/task_model.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskRemoteDataSource _dataSource;

  const TaskRepositoryImpl(this._dataSource);

  @override
  Future<void> createTask(
    String title,
    String description,
    DateTime dueDate,
  ) async => await _dataSource.createTask(
    title: title,
    description: description,
    dueDate: dueDate,
  );

  @override
  Future<void> deleteTask(String id) async =>
      await _dataSource.deleteTask(id: id);

  @override
  Future<List<TaskModel>> getAllTasks() async =>
      await _dataSource.getAllTasks();

  @override
  Future<void> updateTask(
    String id,
    String title,
    String description,
    DateTime dueDate,
    bool isCompleted,
  ) async => await _dataSource.updateTask(
    id: id,
    title: title,
    description: description,
    dueDate: dueDate,
    isCompleted: isCompleted,
  );
}
