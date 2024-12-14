import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minimal_todo_app/components/custom_search_bar.dart';
import 'package:minimal_todo_app/components/todo_item.dart';
import 'package:minimal_todo_app/constants.dart';
import 'package:minimal_todo_app/cubits/cubit/todo_cubit.dart';
import 'package:minimal_todo_app/cubits/cubit/todo_state.dart';
import 'package:minimal_todo_app/models/todo_model.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final TextEditingController _todoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(),
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        title: const Text('Task Manager'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 4.0),
            child: CircleAvatar(
              backgroundImage: Image.asset('assets/images/samurai.png').image,
              backgroundColor: Colors.transparent,
            ),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomSearchBar(),
          Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: Text(
              'Today\'s Tasks',
              style:
                  GoogleFonts.jetBrainsMono(color: Colors.black, fontSize: 28),
            ),
          ),
          const SizedBox(height: 18),
          Expanded(
            child: BlocBuilder<TodoCubit, TodoState>(
              builder: (context, state) {
                if (state is TodoLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is TodoLoaded) {
                  final todos = state.todos;
                  if (todos.isEmpty) {
                    return const Center(
                      child: Text(
                        'No todos yet!',
                        style: TextStyle(color: Colors.grey),
                      ),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: todos.length,
                      itemBuilder: (context, index) {
                        final todo = todos[index];
                        return TodoItem(
                          todo: todo,
                          onCheckboxChanged: (value) {
                            final newTodo = TodoModel(
                                title: todo.title, isCompleted: value ?? false);
                          },
                          onDelete: () =>
                              context.read<TodoCubit>().deleteTodoAt(index),
                        );
                      },
                    );
                  }
                } else {
                  return const Center(child: Text('Error Loading todos'));
                }
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(
                      bottom: 20,
                      right: 20,
                      left: 20,
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 0.0),
                          blurRadius: 10.0,
                          spreadRadius: 0,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: _todoController,
                      decoration: const InputDecoration(
                        hintText: 'Add new task',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 20, right: 20),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimaryColor,
                      elevation: 10,
                      minimumSize: const Size(60, 60),
                    ),
                    onPressed: () {
                      final taskTitle = _todoController.text.trim();

                      if (taskTitle.isNotEmpty) {
                        // Create a new todo and add it via the cubit
                        final newTodo =
                            TodoModel(title: taskTitle, isCompleted: false);
                        context.read<TodoCubit>().addTodo(
                              newTodo.title,
                            );

                        // Clear the input field
                        _todoController.clear();
                      } else {
                        // Optionally show a snack bar or error if input is empty
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Task title cannot be empty'),
                          ),
                        );
                      }
                    },
                    child: const Icon(
                      Icons.add,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
