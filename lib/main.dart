import 'dart:async';

import 'package:flutter/material.dart';
import 'package:p2p_transfer/presentation/home/home_screen.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: const HomeScreen(),
      themeMode: ThemeMode.dark,
      theme: ThemeData.dark(useMaterial3: true)
          .copyWith(platform: TargetPlatform.iOS),
    );
  }
}
