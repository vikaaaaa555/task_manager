import 'package:equatable/equatable.dart';

import '../../../../core/use_case.dart';
import '../repositories/task_repository.dart';

class CreateTaskUseCase extends UseCaseWithParams<void, CreateTaskParams> {
  final TaskRepository _repository;

  const CreateTaskUseCase(this._repository);

  @override
  Future<void> call(CreateTaskParams params) async => await _repository
      .createTask(params.title, params.description, params.dueDate);
}

class CreateTaskParams extends Equatable {
  final String title;
  final String description;
  final DateTime dueDate;

  const CreateTaskParams({
    required this.title,
    required this.description,
    required this.dueDate,
  });

  @override
  List<Object?> get props => [title, description, dueDate];
}
