import 'package:bloc/bloc.dart';
import 'package:minimal_todo_app/cubits/cubit/todo_state.dart';
import 'package:minimal_todo_app/db/todo_database.dart';
import 'package:minimal_todo_app/models/todo_model.dart';

class TodoCubit extends Cubit<TodoState> {
  final TodoDatabase database;

  TodoCubit(this.database) : super(TodoInitial());

  void fetchTodos() {
    final todos = database.readAllTodos();
    emit(TodoLoaded(todos)); // Emit the todos in a wrapped state
  }

  void addTodo(String title) {
    final newTodo = TodoModel(title: title, isCompleted: false);
    database.addTodo(newTodo,);
    fetchTodos(); // Refresh the list after adding
  }

  void deleteTodoAt(int index) {
    database.deleteTodo(index);
    fetchTodos(); // Refresh the list after deleting
  }
}
