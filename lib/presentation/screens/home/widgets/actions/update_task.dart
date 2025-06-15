import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../features/task/domain/entities/task_entity.dart';
import '../../../../bloc/home/home_bloc.dart';
import '../task_form.dart';

class UpdateTask extends StatelessWidget {
  final TaskEntity task;

  const UpdateTask({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return TaskForm(
      initialTitle: task.title,
      initialDescription: task.description,
      initialDueDate: task.dueDate,
      onSubmit: (title, description, dueDate) {
        context.read<HomeBloc>().add(
          UpdateTaskEvent(
            id: task.id!,
            title: title,
            description: description,
            dueDate: dueDate,
          ),
        );
        Navigator.pop(context);
      },
    );
  }
}
