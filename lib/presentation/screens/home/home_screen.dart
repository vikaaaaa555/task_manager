import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/options/localization/l10n.dart';
import '../../../features/task/domain/entities/task_entity.dart';
import '../../bloc/home/home_bloc.dart';
import 'widgets/actions/create_task.dart';
import 'widgets/actions/update_task.dart';
import 'widgets/task_card.dart';

class HomeScreen extends StatefulWidget {
  final List<TaskEntity> tasks;

  const HomeScreen({super.key, required this.tasks});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(
      const Duration(seconds: 30),
      (timer) => context.read<HomeBloc>().add(LoadTasksFromDBEvent()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).tasks),
        centerTitle: true,
        scrolledUnderElevation: 0.0,
      ),
      body:
          widget.tasks.isNotEmpty
              ? Padding(
                padding: EdgeInsets.all(10),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1,
                  ),
                  itemCount: widget.tasks.length,
                  itemBuilder: (context, index) {
                    final task = widget.tasks[index];
                    return GestureDetector(
                      onLongPress: () => _showOptionsDialog(task),
                      child: TaskCard(
                        id: task.id!,
                        title: task.title,
                        description: task.description,
                        dueDate: task.dueDate,
                        isCompleted: task.isCompleted,
                      ),
                    );
                  },
                ),
              )
              : const SizedBox(),
      floatingActionButton: FloatingActionButton(
        onPressed:
            () => showModalBottomSheet(
              context: context,
              builder:
                  (context) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: CreateTask(),
                  ),
            ),
        child: Icon(Icons.add_task_rounded),
      ),
    );
  }

  void _showOptionsDialog(TaskEntity task) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            actions: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed:
                          () => showModalBottomSheet(
                            context: context,
                            builder:
                                (context) => Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: UpdateTask(task: task),
                                ),
                          ),
                      child: Text(S.of(context).update),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        context.read<HomeBloc>().add(
                          DeleteTaskEvent(id: task.id!),
                        );
                        Navigator.pop(context);
                      },
                      child: Text(S.of(context).delete),
                    ),
                  ],
                ),
              ),
            ],
          ),
    );
  }
}
