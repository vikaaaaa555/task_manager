import '../../../../core/use_case.dart';
import '../repositories/task_repository.dart';

class GetAllTasksUseCase extends UseCaseWithoutParams<void> {
  final TaskRepository _repository;

  const GetAllTasksUseCase(this._repository);

  @override
  Future<void> call() async => await _repository.getAllTasks();
}