class TaskEntity {
  final String? id;
  final String title;
  final String description;
  final DateTime dueDate;

  const TaskEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
  });
}
