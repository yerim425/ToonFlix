import 'package:flutter/material.dart';
import 'package:toonflix/pages/home_page.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: Color(0xFF03C75A),
          onPrimary: Color.fromARGB(255, 245, 255, 245),
          secondary: Color.fromARGB(255, 2, 117, 54),
          onSecondary: Color.fromARGB(255, 245, 255, 245),
          error: Colors.redAccent,
          onError: Colors.white,
          surface: Color.fromARGB(255, 40, 40, 40),
          onSurface: Color.fromARGB(255, 245, 255, 245),
        ),
        textTheme: TextTheme(
          titleLarge: TextStyle(
            fontSize: 22,
            color: Color.fromARGB(255, 245, 255, 245),
            fontWeight: FontWeight.w600,
          ),
          headlineSmall: TextStyle(
            fontSize: 16,
            color: Color.fromARGB(255, 2, 117, 54),
            fontWeight: FontWeight.w600,
          ),
          bodyLarge: TextStyle(
            fontSize: 18,
            color: Color.fromARGB(255, 245, 255, 245),
          ),
          bodyMedium: TextStyle(
            fontSize: 16,
            color: Color.fromARGB(255, 245, 255, 245),
          ),
          bodySmall: TextStyle(
            fontSize: 14,
            color: Color.fromARGB(255, 245, 255, 245),
          ),
        ),
      ),
      home: Scaffold(body: HomePage()),
    );
  }
}
