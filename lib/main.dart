import 'package:flutter/material.dart';
import 'package:projet_dev_mobile/src/Question/Question_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Mysterius',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple.shade900),
      ),home:const HomeScreen(),
      );
      
  }
}