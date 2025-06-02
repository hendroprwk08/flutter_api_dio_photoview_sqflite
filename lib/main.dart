import 'package:flutter/material.dart';
import 'pages/detail_page.dart';
import 'pages/image_page.dart';
import 'pages/home_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  // pengaturan hanya berorientasi potrait
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
        return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Halo Flutter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
      initialRoute: '/',
      routes: {
        '/detail': (context) => const DetailPage(),
        '/image': (context) => const ImagePage(),
      },
    );
  }
}
