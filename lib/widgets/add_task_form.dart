
// lib/widgets/add_task_form.dart
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/task.dart';

class AddTaskForm extends StatefulWidget {
  const AddTaskForm({super.key});

  @override
  State<AddTaskForm> createState() => _AddTaskFormState();
}

class _AddTaskFormState extends State<AddTaskForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  DateTime? _selectedDate;
  Priority _priority = Priority.medium;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 16,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Task Name',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a task name';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            ListTile(
              title: Text(_selectedDate == null
                  ? 'No due date'
                  : 'Due: ${_selectedDate.toString().split(' ')[0]}'),
              trailing: const Icon(Icons.calendar_today),
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                );
                if (date != null) {
                  setState(() => _selectedDate = date);
                }
              },
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
            ElevatedButton(
              onPressed: _saveTask,
              child: const Text('Add Task'),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  void _saveTask() {
    if (_formKey.currentState!.validate()) {
      final task = Task(
        name: _nameController.text,
        dueDate: _selectedDate,
        priority: _priority,
      );

      final box = Hive.box<Task>('tasks');
      box.add(task);

      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}