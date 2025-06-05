import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:EndemikDB/screen/home_page.dart';
import 'package:EndemikDB/model/endemik.dart';
import 'package:EndemikDB/service/endemik_service.dart';

class MockEndemikService extends EndemikService {
  @override
  Future<List<Endemik>> getData() async {
    // Mengembalikan data dummy
    return [
      Endemik(id: '1', nama: 'Endemik 1', nama_latin: 'Endemik Latin 1', deskripsi: 'Deskripsi 1', asal: 'Asal 1', foto: 'https://example.com/image1.jpg', status: 'Status 1'),
      Endemik(id: '2', nama: 'Endemik 2', nama_latin: 'Endemik Latin 2', deskripsi: 'Deskripsi 2', asal: 'Asal 2', foto: 'https://example.com/image2.jpg', status: 'Status 2'),
    ];
  }
}

void main() {
  testWidgets('MyHomePage displays data in GridView', (WidgetTester tester) async {
    // Buat instance dari MockEndemikService
    final mockService = MockEndemikService();

    // Buat widget MyHomePage dengan MockEndemikService
    await tester.pumpWidget(
      MaterialApp(
        home: MyHomePage(endemikService: mockService),
      ),
    );

    // Pastikan loading indicator ditampilkan
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // Tunggu hingga widget selesai membangun
    await tester.pumpAndSettle();

    // Pastikan loading indicator tidak ditampilkan lagi
    expect(find.byType(CircularProgressIndicator), findsNothing);

    // Pastikan data ditampilkan dalam GridView
    expect(find.text('Endemik 1'), findsOneWidget);
    expect(find.text('Endemik 2'), findsOneWidget);
  });
}