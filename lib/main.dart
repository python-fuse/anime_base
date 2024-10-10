import 'package:anime_base/pages/root_page.dart';
import 'package:anime_base/pages/search_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Anime Base',
      theme: ThemeData(
        colorScheme: const ColorScheme.dark(),
        useMaterial3: true,
      ),
      home: const RootPage(),
      routes: {
        '/home': (ctx) => const RootPage(),
        '/search': (ctx) => const SearchPage(),
      },
    );
  }
}
