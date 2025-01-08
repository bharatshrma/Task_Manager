// lib/models/task.dart
import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 0)
enum Priority {
  @HiveField(0)
  high,
  @HiveField(1)
  medium,
  @HiveField(2)
  low
}

@HiveType(typeId: 1)
class Task extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  DateTime? dueDate;

  @HiveField(2)
  Priority priority;

  @HiveField(3)
  bool isCompleted;

  Task({
    required this.name,
    this.dueDate,
    required this.priority,
    this.isCompleted = false,
  });
}
