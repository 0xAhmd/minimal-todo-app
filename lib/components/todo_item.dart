import 'package:flutter/material.dart';
import 'package:minimal_todo_app/models/todo_model.dart';

class TodoItem extends StatelessWidget {
  final TodoModel todo;
  final ValueChanged<bool?>? onCheckboxChanged;
  final VoidCallback? onDelete;

  const TodoItem({
    super.key,
    required this.todo,
    this.onCheckboxChanged,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
      child: Container(
        height: 65,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: ListTile(
            leading: Checkbox(
              value: todo.isCompleted,
              onChanged: onCheckboxChanged,
            ),
            title: Text(todo.title), // Use the title from TodoModel
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: onDelete,
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}
