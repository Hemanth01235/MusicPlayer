

import 'package:flutter/material.dart';
import 'package:musicplayer/model/playlist_provider.dart';
import 'package:musicplayer/presentation/home_screen/home_Screen.dart';
import 'package:musicplayer/theme/theme_provider.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(
    MultiProvider(providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => PlaylistProvider()),
    ],
        child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}
