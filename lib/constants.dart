import 'dart:ui';

import 'package:hive/hive.dart';
import 'package:minimal_todo_app/models/todo_model.dart';

const kPrimaryColor = Color(0xFFEEEFF5);
const kBox = '_todoBox';
Box<TodoModel>? get box => kBox != null ? Hive.box<TodoModel>(kBox) : null;
