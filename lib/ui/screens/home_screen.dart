import 'package:flutter/material.dart';
import 'package:todo_application/ui/utils/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
      onPressed: () {},
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
