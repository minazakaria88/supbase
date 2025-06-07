import 'package:flutter/material.dart';

import 'home_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://gerxocucvubryifscobw.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImdlcnhvY3VjdnVicnlpZnNjb2J3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDkzMTc2NDcsImV4cCI6MjA2NDg5MzY0N30.-GSCZHS6lXgfpinpyf39spbvH5kAIr2nbdtgLHRBDSQ',
  );
  runApp(const TaskSchool());
}

class TaskSchool extends StatelessWidget {
  const TaskSchool({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task School',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}

