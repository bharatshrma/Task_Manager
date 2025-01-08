// lib/widgets/task_list_item.dart
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/task.dart';
import 'package:intl/intl.dart';
import 'edit_task_form.dart';

class TaskListItem extends StatelessWidget {
  final Task task;
  final int index;

  const TaskListItem({
    super.key,
    required this.task,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final box = Hive.box<Task>('tasks');

    return Dismissible(
      key: Key(task.hashCode.toString()),
      onDismissed: (_) => box.deleteAt(index),
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      child: ListTile(
        title: Text(
          task.name,
          style: TextStyle(
            decoration: task.isCompleted ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: task.dueDate != null
            ? Text(DateFormat('MMM dd, yyyy').format(task.dueDate!))
            : null,
        leading: Checkbox(
          value: task.isCompleted,
          onChanged: (bool? value) {
            task.isCompleted = value!;
            box.putAt(index, task);
          },
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _getPriorityIcon(task.priority),
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => EditTaskForm(task: task, index: index),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _getPriorityIcon(Priority priority) {
    IconData iconData;
    Color color;

    switch (priority) {
      case Priority.high:
        iconData = Icons.priority_high;
        color = Colors.red;
        break;
      case Priority.medium:
        iconData = Icons.trending_flat;
        color = Colors.orange;
        break;
      case Priority.low:
        iconData = Icons.low_priority;
        color = Colors.green;
        break;
    }

    return Icon(iconData, color: color);
  }
}