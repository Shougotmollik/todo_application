import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
        return AlertDialog(
          backgroundColor: AppColors.secondaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          icon: const Icon(
            Icons.edit_calendar,
            size: 32,
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
                fontSize: 14,
                color: Colors.black54,
              ),
              border: OutlineInputBorder(
                borderSide: const BorderSide(
                  width: 16.0,
                ),
                borderRadius: BorderRadius.circular(8.0),
              )
            ),
          ),
        );
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
            Expanded(
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
                    return const ListTile();
                  },
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: _buildFloatingActionButton(),
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
}
