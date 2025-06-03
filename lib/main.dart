import 'package:flutter/material.dart';
import 'screen//detail_page.dart';
import 'screen//image_page.dart';
import 'screen//home_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {

  const MyApp({super.key});
  static const APP_NAME = 'EndemikDB';

  @override
  Widget build(BuildContext context) {
        return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: APP_NAME,
      theme: ThemeData(
        primaryColor: Colors.purple, // Menentukan warna utama
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
            color: Colors.white, // Warna teks menjadi putih
            fontSize: 20, // Ukuran teks
            fontWeight: FontWeight.bold, // Ketebalan teks
          ),
          iconTheme: IconThemeData(
            color: Colors.white, // Warna ikon menjadi putih
          ),
          backgroundColor: Colors.purple, // Menggunakan warna utama untuk AppBar
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.purple, // Warna latar belakang
          selectedItemColor: Colors.white, // Warna item yang dipilih
          unselectedItemColor: Colors.white60, // Warna item yang tidak dipilih
          showSelectedLabels: true, // Menampilkan label item yang dipilih
          showUnselectedLabels: false, // Menyembunyikan label item yang tidak dipilih
        ),
      ),
      home: const MyHomePage(titleApp: APP_NAME),
      initialRoute: '/',
      routes: {
        '/detail': (context) => const DetailPage(),
        '/image': (context) => const ImagePage(),
      },
    );
  }
}
