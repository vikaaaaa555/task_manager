class TaskEntity {
  final int id;
  final String title;
  final String? description;
  final DateTime dueDate;

  const TaskEntity({
    required this.id,
    required this.title,
    this.description,
    required this.dueDate,
  });
}
