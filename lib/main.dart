import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:com.mycompany.quizapp/Pages/splash_screen.dart';
import 'package:com.mycompany.quizapp/utils/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const QuizApp());
}

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quiz App',
      theme: AppTheme.appTheme(1),
      home: const SplashScreen(),
    );
  }
}

