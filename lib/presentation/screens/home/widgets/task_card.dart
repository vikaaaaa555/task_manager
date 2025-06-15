import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/options/localization/l10n.dart';
import '../../../bloc/home/home_bloc.dart';

class TaskCard extends StatelessWidget {
  final String id;
  final String title;
  final String description;
  final DateTime dueDate;
  final bool isCompleted;

  const TaskCard({
    super.key,
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.isCompleted,
  });

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat.yMd();
    final formattedDate = dateFormat.format(dueDate);

    final now = DateTime.now();
    final isOverdue = dueDate.isBefore(DateTime(now.year, now.month, now.day));
    final isFuture = dueDate.isAfter(DateTime(now.year, now.month, now.day));

    return Card(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    decoration:
                        isCompleted
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Checkbox(
                  value: isCompleted,
                  onChanged: (value) {
                    context.read<HomeBloc>().add(
                      UpdateTaskEvent(
                        id: id,
                        title: title,
                        description: description,
                        dueDate: dueDate,
                        isCompleted: !isCompleted,
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              description,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                decoration:
                    isCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              S.of(context).dueFormattedDate(formattedDate),
              style: TextStyle(
                decoration:
                    isCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                color:
                    isOverdue
                        ? Colors.red
                        : isFuture
                        ? Colors.green
                        : Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
