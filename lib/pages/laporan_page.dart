import 'package:flutter/material.dart';

class LaporanPage extends StatefulWidget {
  const LaporanPage({Key? key}) : super(key: key);

  @override
  State<LaporanPage> createState() => _LaporanPageState();
}

class _LaporanPageState extends State<LaporanPage> {
  final Map<String, int> _itemsCount = {
    'Pensil': 20,
    'Buku': 15,
    'Penghapus': 10,
    'Pulpen': 25,
    'Penggaris': 5,
  };

  @override
  Widget build(BuildContext context) {
    int totalItems = _itemsCount.values.fold(0, (sum, val) => sum + val);

    return Scaffold(
      appBar: AppBar(
        title: Text('Laporan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              elevation: 4,
              child: ListTile(
                title: Text('Total Barang'),
                trailing: Text(
                  totalItems.toString(),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _itemsCount.length,
                itemBuilder: (context, index) {
                  String key = _itemsCount.keys.elementAt(index);
                  int value = _itemsCount[key]!;
                  return ListTile(
                    title: Text(key),
                    trailing: Text(value.toString()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
