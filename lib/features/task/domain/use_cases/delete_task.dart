import 'package:equatable/equatable.dart';

import '../../../../core/use_case.dart';
import '../repositories/task_repository.dart';

class DeleteTaskUseCase extends UseCaseWithParams<void, DeleteTaskParams> {
  final TaskRepository _repository;

  const DeleteTaskUseCase(this._repository);

  @override
  Future<void> call(DeleteTaskParams params) async =>
      await _repository.deleteTask(params.id);
}

class DeleteTaskParams extends Equatable {
  final String id;

  const DeleteTaskParams({required this.id});

  @override
  List<Object?> get props => [id];
}
