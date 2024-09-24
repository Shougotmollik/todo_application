import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:todo_application/app.dart';
import 'package:todo_application/ui/provider/todo_provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => TodoProvider(),
      )
    ],
    child: const MyApp(),
  ));
}
