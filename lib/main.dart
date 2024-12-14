import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:minimal_todo_app/constants.dart';
import 'package:minimal_todo_app/cubits/cubit/todo_cubit.dart';
import 'package:minimal_todo_app/db/todo_database.dart';
import 'package:minimal_todo_app/models/todo_model.dart';
import 'package:minimal_todo_app/views/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TodoModelAdapter());
  await Hive.openBox<TodoModel>(kBox);
  runApp(
    DevicePreview(
      builder: (context) => const MyApp(),
      enabled: true,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoCubit(
        TodoDatabase()..readAllTodos(),
      ),
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: GoogleFonts.poppins().fontFamily,
        ),
        debugShowCheckedModeBanner: false,
        title: 'Todo-App',
        home: HomePage(),
      ),
    );
  }
}
