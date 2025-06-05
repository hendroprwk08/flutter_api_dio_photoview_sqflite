import 'package:EndemikDB/model/endemik.dart';
import 'package:flutter/material.dart';
import '../../helper/database_helper.dart';

class DetailPage extends StatefulWidget {
  DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final _databaseHelper = DatabaseHelper();
  late String _id = "",
      _tag = "",
      _nama = "",
      _nama_latin = "",
      _deskripsi = "",
      _asal = "",
      _foto = "",
      _status = "";
  late bool _is_favorit = false;

  @override
  void initState() {
    super.initState();

    // Pastikan _id sudah di-set sebelum cek favorit
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final Map? arguments = ModalRoute.of(context)?.settings.arguments as Map?;
      if (arguments != null) {
        setState(() {
          _id = arguments['a_id'];
          _tag = arguments['a_tag'];
        });

        getDetail(_id);
      }
    });
  }

  void getDetail(String id) async {
    var data = await _databaseHelper.getById(id);

    setState(() {
      _id = data!.id;
      _nama = data.nama;
      _nama_latin = data.nama_latin;
      _deskripsi = data.deskripsi;
      _asal = data.asal;
      _foto = data.foto;
      _status = data.status;
      _is_favorit = data.is_favorit == "true"; // konversi ke boolean
    });
  }

  @override
  Widget build(BuildContext context) {
    // tampilkan
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: Text(_nama),
            backgroundColor: getStatusColor(_status),
            leading: BackButton(
              onPressed: () => Navigator.of(context).pop(),
            ),
            actions: [
              Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: _is_favorit
                      ? IconButton(
                          icon: Icon(Icons.favorite), // Ikon pencarian
                          onPressed: () async {
                            await _databaseHelper.setFavorit(_id, "false");

                            setState(() {
                              _is_favorit = false;
                            });
                          },
                        )
                      : IconButton(
                          icon: Icon(Icons.favorite_border), // Ikon pencarian
                          onPressed: () async {
                            await _databaseHelper.setFavorit(_id, "true");

                            setState(() {
                              _is_favorit = true;
                            });
                          },
                        )),
            ]),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/image', arguments: {
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
              Text(
                _nama_latin,
                style: TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                ),
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
      case 'Punah':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
