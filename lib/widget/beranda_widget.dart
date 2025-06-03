import 'package:flutter/material.dart';
import '../model/endemik.dart';
import '../service/endemik_service.dart';

class BerandaWidget extends StatefulWidget {
  const BerandaWidget({super.key});

  @override
  State<BerandaWidget> createState() => _BerandaWidgetState();
}

class _BerandaWidgetState extends State<BerandaWidget> {
  List<Endemik> endemik = [];
  var isLoading = true;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    final endemikService = EndemikService();
    final endemik = await endemikService.getData();

    setState(() {
      this.endemik = endemik;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;

    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : GridView.count(
      crossAxisCount: orientation == Orientation.portrait ? 2 : 4,
      crossAxisSpacing: 5,
      mainAxisSpacing: 5,
      children:
      List.generate(endemik == null ? 0 : endemik.length, (index) {
        final endemikItem = endemik[index];

        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/detail', arguments: {
              'a_tag': 'image $index',
              'a_id': endemikItem.id,
              'a_nama': endemikItem.nama,
              'a_nama_latin': endemikItem.nama_latin,
              'a_deskripsi': endemikItem.deskripsi,
              'a_asal': endemikItem.asal,
              'a_foto': endemikItem.foto,
              'a_status': endemikItem.status,
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
                      endemikItem.foto,
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
                                  ? 170
                                  : 185,
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
                                  ? 170
                                  : 185,
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
                Text(endemikItem.nama.length >= 20
                    ? endemikItem.nama.substring(0, 20)
                    : endemikItem.nama)
              ],
            ),
          ),
        );
      }),
    );
  }
}