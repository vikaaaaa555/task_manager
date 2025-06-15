import 'package:flutter/material.dart';

import '../../../../core/options/localization/l10n.dart';

class TaskForm extends StatefulWidget {
  final String? initialTitle;
  final String? initialDescription;
  final DateTime? initialDueDate;
  final bool? initialIsCompleted;
  final Function(
    String title,
    String description,
    DateTime dueDate,
    bool? isCompleted,
  )
  onSubmit;

  const TaskForm({
    super.key,
    this.initialTitle,
    this.initialDescription,
    this.initialDueDate,
    this.initialIsCompleted,
    required this.onSubmit,
  });

  @override
  State<TaskForm> createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  late DateTime? _dueDate;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.initialTitle ?? '');
    _descriptionController = TextEditingController(
      text: widget.initialDescription ?? '',
    );
    _dueDate = widget.initialDueDate ?? DateTime.now();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _dueDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _dueDate) {
      setState(() {
        _dueDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(hintText: S.of(context).title),
              maxLines: 1,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(hintText: S.of(context).description),
              maxLines: 5,
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Text(S.of(context).selectDueDate),
                const SizedBox(width: 10),
                TextButton(
                  onPressed: () => _selectDate(context),
                  child: Text(
                    '${_dueDate?.day}/${_dueDate?.month}/${_dueDate?.year}',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                if (_titleController.text.isNotEmpty &&
                    _descriptionController.text.isNotEmpty) {
                  widget.onSubmit(
                    _titleController.text,
                    _descriptionController.text,
                    _dueDate!,
                    widget.initialIsCompleted,
                  );
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(S.of(context).fillInAllFields),
                      duration: const Duration(seconds: 2),
                      behavior: SnackBarBehavior.floating,
                      margin: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height - 200,
                        right: 20,
                        left: 20,
                      ),
                    ),
                  );
                }
              },
              child: Text(S.of(context).save),
            ),
          ],
        ),
      ),
    );
  }
}
