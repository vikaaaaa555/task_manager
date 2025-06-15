import '../../../../core/use_case.dart';
import '../entities/task_entity.dart';
import '../repositories/task_repository.dart';

class GetAllTasksUseCase extends UseCaseWithoutParams<List<TaskEntity>> {
  final TaskRepository _repository;

  const GetAllTasksUseCase(this._repository);

  @override
  Future<List<TaskEntity>> call() async => await _repository.getAllTasks();
}