import '../entities/task_entity.dart';

abstract class TaskRepository {
  Future<List<TaskEntity>> getAllTasks();

  Future<void> createTask(String title, String description, DateTime dueDate);

  Future<void> updateTask(
    int id,
    String title,
    String description,
    DateTime dueDate,
  );

  Future<void> deleteTask(int id);
}
