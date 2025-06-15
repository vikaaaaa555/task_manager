import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/options/localization/l10n.dart';
import '../../../../../core/services/notification_service.dart';
import '../../../../bloc/home/home_bloc.dart';
import '../task_form.dart';

class CreateTask extends StatelessWidget {
  const CreateTask({super.key});

  @override
  Widget build(BuildContext context) {
    return TaskForm(
      onSubmit: (title, description, dueDate, isCompleted) {
        context.read<HomeBloc>().add(
          CreateTaskEvent(
            title: title,
            description: description,
            dueDate: dueDate,
          ),
        );

        final daysLeft = dueDate.difference(DateTime.now()).inDays;
        NotificationService().showNotification(
          id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
          title: S.of(context).taskTitleIsCreated(title),
          body: S.of(context).dueDeadlineDaysleftDays(daysLeft),
        );
      },
    );
  }
}
