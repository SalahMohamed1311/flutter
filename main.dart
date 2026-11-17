import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/team_provider.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(
    // State is lifted to the root so every screen shares the same data.
    ChangeNotifierProvider(
      create: (_) => TeamProvider(),
      child: const TeamApp(),
    ),
  );
}

class TeamApp extends StatelessWidget {
  const TeamApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Team Hub',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),
      home: const HomeScreen(),
    );
  }
}
