import 'package:flutter/material.dart';
import 'package:msh_checkbox/msh_checkbox.dart';
import 'package:provider/provider.dart';
import 'package:todo_application/ui/model/todo_model.dart';
import 'package:todo_application/ui/provider/todo_provider.dart';
import 'package:todo_application/ui/utils/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _todoTEController = TextEditingController();

  Future<void> _showDialog() async {
    return showDialog(
      context: context,
      builder: (context) {
        return _buildAlertDialog(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodoProvider>(context);
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            _buildTodoListHeader(),
            _buildTodoListBodySection(provider)
          ],
        ),
      ),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  Widget _buildTodoListBodySection(TodoProvider provider) {
    return Expanded(
      flex: 3,
      child: Container(
        decoration: const BoxDecoration(
            color: AppColors.secondaryColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18),
              topRight: Radius.circular(18),
            )),
        child: ListView.builder(
          itemCount: provider.todoList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: _buildTodoListItems(provider, index),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTodoListItems(TodoProvider provider, int index) {
    return ListTile(
      onTap: () {
        provider.todoListStatus(provider.todoList[index]);
      },
      leading: MSHCheckbox(
        style: MSHCheckboxStyle.stroke,
        size: 22,
        colorConfig: MSHColorConfig.fromCheckedUncheckedDisabled(
          checkedColor: Colors.black,
          uncheckedColor: AppColors.primaryColor,
        ),
        duration: const Duration(milliseconds: 300),
        value: provider.todoList[index].isCompleted,
        onChanged: (selected) {
          provider.todoListStatus(provider.todoList[index]);
        },
      ),
      title: Text(
        provider.todoList[index].title,
        style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w500,
          color: provider.todoList[index].isCompleted
              ? Colors.black87
              : AppColors.primaryColor,
          decoration: provider.todoList[index].isCompleted == true
              ? TextDecoration.lineThrough
              : null,
        ),
      ),
      trailing: IconButton(
          onPressed: () {
            provider.removeTodoList(provider.todoList[index]);
          },
          icon: Icon(
            Icons.delete_rounded,
            color: provider.todoList[index].isCompleted == true
                ? Colors.black87
                : AppColors.primaryColor,
            size: 28,
          )),
    );
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton(
      backgroundColor: AppColors.primaryColor,
      tooltip: "Add Todo",
      onPressed: _showDialog,
      child: const Icon(
        Icons.add,
        color: AppColors.fontColor,
        weight: 50,
        size: 32,
      ),
    );
  }

  Widget _buildTodoListHeader() {
    return const Expanded(
        child: SizedBox(
      width: double.infinity,
      child: Center(
          child: Text(
        "TODO LIST",
        style: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.w600,
          color: AppColors.fontColor,
          fontStyle: FontStyle.italic,
        ),
      )),
    ));
  }

  Widget _buildAlertDialog(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.secondaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      icon: const Icon(
        Icons.edit_calendar,
        size: 32.0,
        color: AppColors.primaryColor,
      ),
      title: const Text(
        "Add Todo Here",
        style: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.w600,
          color: Colors.black54,
          fontStyle: FontStyle.italic,
        ),
      ),
      content: TextFormField(
        controller: _todoTEController,
        decoration: InputDecoration(
            hintText: "Type your todo item...",
            hintStyle: const TextStyle(
              fontSize: 14.0,
              color: Colors.black54,
            ),
            border: OutlineInputBorder(
              borderSide: const BorderSide(
                width: 16.0,
              ),
              borderRadius: BorderRadius.circular(8.0),
            )),
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              "Cancel",
              style: TextStyle(
                color: AppColors.primaryColor,
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            )),
        TextButton(
            onPressed: () {
              if (_todoTEController.text.isNotEmpty) {
                context.read<TodoProvider>().addTodoList(
                      TodoModel(
                        title: _todoTEController.text,
                        isCompleted: false,
                      ),
                    );
                Navigator.pop(context);
                _todoTEController.clear();
              } else {
                return;
              }
            },
            child: const Text(
              "Submit",
              style: TextStyle(
                color: AppColors.primaryColor,
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            )),
      ],
    );
  }
}
