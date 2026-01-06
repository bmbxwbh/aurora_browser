import 'package:flutter/material.dart';
import 'screens/browser_screen.dart';

class AuroraBrowserApp extends StatelessWidget {
  const AuroraBrowserApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aurora Browser',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6B72FF),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: Colors.grey[50],
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6B72FF),
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: Colors.grey[900],
      ),
      themeMode: ThemeMode.system,
      home: const BrowserScreen(),
    );
  }
}
