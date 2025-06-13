class TaskEntity {
  final String title;
  final String? description;
  final DateTime dueDate;

  const TaskEntity({
    required this.title,
    this.description,
    required this.dueDate,
  });
}
