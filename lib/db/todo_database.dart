import 'package:hive/hive.dart';
import 'package:minimal_todo_app/models/todo_model.dart';

class TodoDatabase {
  TodoDatabase() {
    _initialize();
  }

  Box<TodoModel>? _kbox;

  Future<void> _initialize() async {
    // Initialize the Hive box
    _kbox = await Hive.openBox<TodoModel>('todos');
  }

  List<TodoModel> readAllTodos() {
    return _kbox?.values.toList().cast<TodoModel>() ?? [];
  }

  Future<void> addTodo(TodoModel todo) async {
    await _kbox?.add(todo);
  }

  Future<void> deleteTodo(int index) async {
    await _kbox?.deleteAt(index);
  }
}
