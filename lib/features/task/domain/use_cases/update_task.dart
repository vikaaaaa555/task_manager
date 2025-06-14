import 'package:equatable/equatable.dart';

import '../../../../core/use_case.dart';
import '../repositories/task_repository.dart';

class UpdateTaskUseCase extends UseCaseWithParams<void, UpdateTaskParams> {
  final TaskRepository _repository;

  const UpdateTaskUseCase(this._repository);

  @override
  Future<void> call(UpdateTaskParams params) async => await _repository
      .updateTask(params.id, params.title, params.description, params.dueDate);
}

class UpdateTaskParams extends Equatable {
  final String id;
  final String title;
  final String description;
  final DateTime dueDate;

  const UpdateTaskParams({
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
  });

  @override
  List<Object?> get props => [id, title, description, dueDate];
}
