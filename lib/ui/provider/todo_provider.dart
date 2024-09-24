import 'package:flutter/material.dart';
import 'package:todo_application/ui/model/todo_model.dart';

class TodoProvider extends ChangeNotifier {
  final List<TodoModel> _todoList = [];

  List<TodoModel> get todoList => _todoList;

  void addTodoList(TodoModel todoModel) {
    _todoList.add(todoModel);
    notifyListeners();
  }

  void removeTodoList(TodoModel todoModel) {
    final index = _todoList.indexOf(todoModel);
    _todoList.removeAt(index);
    notifyListeners();
  }
}
