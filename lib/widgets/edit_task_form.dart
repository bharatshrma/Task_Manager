// lib/widgets/edit_task_form.dart
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/task.dart';

class EditTaskForm extends StatefulWidget {
  final Task task;
  final int index;

  const EditTaskForm({
    super.key,
    required this.task,
    required this.index,
  });

  @override
  State<EditTaskForm> createState() => _EditTaskFormState();
}

class _EditTaskFormState extends State<EditTaskForm> {
  late TextEditingController _nameController;
  late DateTime? _selectedDate;
  late Priority _priority;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.task.name);
    _selectedDate = widget.task.dueDate;
    _priority = widget.task.priority;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Edit Task',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Task Name',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          ListTile(
            title: Text(_selectedDate == null
                ? 'No due date'
                : 'Due: ${_selectedDate.toString().split(' ')[0]}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (_selectedDate != null)
                  IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      setState(() => _selectedDate = null);
                    },
                  ),
                IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: _selectedDate ?? DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                    );
                    if (date != null) {
                      setState(() => _selectedDate = date);
                    }
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<Priority>(
            value: _priority,
            decoration: const InputDecoration(
              labelText: 'Priority',
              border: OutlineInputBorder(),
            ),
            items: Priority.values.map((priority) {
              return DropdownMenuItem(
                value: priority,
                child: Text(priority.toString().split('.').last.toUpperCase()),
              );
            }).toList(),
            onChanged: (Priority? value) {
              if (value != null) {
                setState(() => _priority = value);
              }
            },
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: _updateTask,
                child: const Text('Update Task'),
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  void _updateTask() {
    if (_nameController.text.isNotEmpty) {
      final updatedTask = Task(
        name: _nameController.text,
        dueDate: _selectedDate,
        priority: _priority,
        isCompleted: widget.task.isCompleted,
      );

      final box = Hive.box<Task>('tasks');
      box.putAt(widget.index, updatedTask);

      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}