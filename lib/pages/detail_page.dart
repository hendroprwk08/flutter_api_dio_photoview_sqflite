import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    // tangkap argument dari main.dart
    final Map? arguments = ModalRoute.of(context)?.settings.arguments as Map?;
    var _id = arguments?['a_id'];
    var _tag = arguments?['a_tag'];
    var _nama = arguments?['a_nama'];
    var _nama_latin = arguments?['a_nama_latin'];
    var _deskripsi = arguments?['a_deskripsi'];
    var _asal = arguments?['a_asal'];
    var _foto = arguments?['a_foto'];
    var _status = arguments?['a_status'];

    // tampilkan
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(_nama),
          leading: BackButton(
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/image',
                      arguments: {
                        'a_tag': _tag,
                        'a_foto': _foto,
                      });
                },
                child: Hero(
                  tag: _tag,
                  child: Container(
                    width: MediaQuery.of(context).size.width, // Full width,
                    height: 320,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(_foto),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text(
                _nama,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(_nama_latin,
                style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic,),
              ),
              SizedBox(height: 15),
              Text(_deskripsi),
              SizedBox(height: 10),
              Text('Asal: $_asal'),
              SizedBox(height: 20),
              Chip(
                label: Text(
                  'Status konservasi: $_status',
                  style: const TextStyle(color: Colors.white),
                ),
                backgroundColor: getStatusColor(_status),
                side: BorderSide.none,
              ),
            ],
          ),
        ));
  }

  Color getStatusColor(String status) {
    // Sesuaikan warna status sesuai kebutuhan
    switch (status) {
      case 'Aman':
        return Colors.green;
      case 'Terancam Punah':
        return Colors.orange;
      case 'Punah' :
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

}
