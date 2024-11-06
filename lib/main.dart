import 'package:examen_movil/routes/listRoutes.dart';
import 'package:examen_movil/routes/routes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(
        appBarTheme: const AppBarTheme(backgroundColor: Colors.blue),
      ),
      initialRoute: Routes.loginScreen,
      routes: ListRoutes.listScreens,
    );
  }
}
