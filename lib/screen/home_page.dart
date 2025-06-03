import 'package:flutter/material.dart';
import '../../widget/beranda_widget.dart';
import '../../widget/favorit_widget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.titleApp});
  final String titleApp;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static List<Widget> _widgetOptions = <Widget>[
    BerandaWidget(),
    FavoritWidget(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.titleApp),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Beranda',
              tooltip: 'Halaman utama'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favorit', tooltip: 'Favorit'),
        ],
        currentIndex: _selectedIndex, // index yang aktif
        onTap: _onItemTapped,
      ),
    );
  }
}