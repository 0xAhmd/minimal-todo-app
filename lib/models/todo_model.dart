import 'package:hive/hive.dart';

part 'todo_model.g.dart';

@HiveType(typeId: 0)
class TodoModel extends HiveObject {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final bool isCompleted;

  TodoModel({
    required this.title,
     this.isCompleted = false,
  });
}
