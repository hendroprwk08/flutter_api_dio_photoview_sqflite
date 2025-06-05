import 'package:flutter/material.dart';
import '../model/endemik.dart';
import '../helper/database_helper.dart';

class FavoritWidget extends StatefulWidget {
  const FavoritWidget({super.key});

  @override
  State<FavoritWidget> createState() => _FavoritWidgetState();
}

class _FavoritWidgetState extends State<FavoritWidget> {
  final _databaseHelper = DatabaseHelper();
  List<Endemik> _favoritList = [];

  late int id;
  late String nama, nama_latin, deskripsi, asal, foto, status;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    List<Endemik> favorit = await _databaseHelper.getFavoritAll();

    setState(() {
      this._favoritList = favorit;
    });
  }

  @override
  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      body: _favoritList.isEmpty
          ? const Center(
              child: Text('Kosong'),
            )
          : GridView.count(
              crossAxisCount: orientation == Orientation.portrait ? 2 : 4,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              children: List.generate(
                  _favoritList == null ? 0 : _favoritList.length, (index) {
                final favoritItem = _favoritList[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/detail', arguments: {
                      'a_tag': 'image $index',
                      'a_id': favoritItem.id,
                      'a_nama': favoritItem.nama,
                      'a_nama_latin': favoritItem.nama_latin,
                      'a_deskripsi': favoritItem.deskripsi,
                      'a_asal': favoritItem.asal,
                      'a_foto': favoritItem.foto,
                      'a_status': favoritItem.status,
                    });
                  },
                  child: Card(
                    color: Colors.white70,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(5),
                            topLeft: Radius.circular(5),
                          ),
                          child: Hero(
                            tag: 'image $index',
                            child: Image.network(
                              favoritItem.foto,
                              height: orientation == Orientation.portrait
                                  ? 170
                                  : 185,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) {
                                  return child; // Jika gambar sudah selesai dimuat, tampilkan gambar
                                }

                                return Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      height:
                                          orientation == Orientation.portrait
                                              ? 160
                                              : 175,
                                      width: double.infinity,
                                      color: Colors.grey[
                                          300], // Placeholder warna saat loading
                                    ),
                                    CircularProgressIndicator(
                                      value:
                                          loadingProgress.expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                    ),
                                    // const Icon(Icons.image, size: 50, color: Colors.grey), // Icon sebagai placeholder
                                  ],
                                );
                              },
                              errorBuilder: (BuildContext context, Object error,
                                  StackTrace? stackTrace) {
                                return Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      height:
                                          orientation == Orientation.portrait
                                              ? 160
                                              : 175,
                                      width: double.infinity,
                                      color: Colors.grey[
                                          300], // Placeholder warna saat terjadi error
                                    ),
                                    const Icon(Icons.broken_image,
                                        size: 40,
                                        color: Colors.grey), // Icon error
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                        Text(favoritItem.nama.length > 20
                            ? favoritItem.nama.substring(0, 18) + '...'
                            : favoritItem.nama)
                      ],
                    ),
                  ),
                );
              }),
            ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        onPressed: () async {
          await _databaseHelper.deleteFavoritAll();
          _getData();
        },
        icon: const Icon(Icons.delete_forever),
        label: const Text('Hapus'),
      ),
    );
  }
}
