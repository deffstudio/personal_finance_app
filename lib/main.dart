import 'package:flutter/material.dart';
import 'package:personal_finance_app/core/services/service_locator.dart'
    as di; // di = dependency injection
import 'package:personal_finance_app/presentation/pages/home_page.dart';

void main() async {
  // Ensure Flutter bindings are initialized before doing async work
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize the service locator (The "Vending Machine")
  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Finance',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
