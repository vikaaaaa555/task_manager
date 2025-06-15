import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../bloc/home/home_bloc.dart';
import '../task_form.dart';

class CreateTask extends StatelessWidget {
  const CreateTask({super.key});

  @override
  Widget build(BuildContext context) {
    return TaskForm(
      onSubmit:
          (title, description, dueDate, isCompleted) =>
              context.read<HomeBloc>().add(
                CreateTaskEvent(
                  title: title,
                  description: description,
                  dueDate: dueDate,
                ),
              ),
    );
  }
}
