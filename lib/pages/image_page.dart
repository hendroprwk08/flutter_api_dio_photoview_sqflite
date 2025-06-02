import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImagePage extends StatelessWidget {
  const ImagePage({super.key});

  @override
  Widget build(BuildContext context) {
    // tangkap argument dari main.dart
    final Map? arguments = ModalRoute.of(context)?.settings.arguments as Map?;
    var _tag = arguments?['a_tag'];
    var _foto = arguments?['a_foto'];

    // tampilkan
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: Hero(
          tag: _tag,
          child: PhotoView(
            imageProvider: NetworkImage(_foto),
            backgroundDecoration: const BoxDecoration(color: Colors.black),
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered * 2.0, // Bisa dicubit untuk zoom
          ),
        ),
      ),
    );
  }
}
