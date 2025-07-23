import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final List<Map<String, String>> _allHistory = [
    {
      'title': 'Peminjaman Laptop',
      'subtitle': '12 April 2025 - 10:00',
      'description': 'Dipinjam oleh Ahmad',
    },
    {
      'title': 'Pengembalian Proyektor',
      'subtitle': '10 April 2025 - 14:30',
      'description': 'Dikembalikan dalam kondisi baik',
    },
    {
      'title': 'Peminjaman Speaker',
      'subtitle': '5 April 2025 - 08:45',
      'description': 'Dipinjam oleh Siti',
    },
  ];

  List<Map<String, String>> _filteredHistory = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredHistory = _allHistory;
    _searchController.addListener(_filterHistory);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterHistory() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredHistory = _allHistory.where((entry) {
        return entry['title']!.toLowerCase().contains(query) ||
               entry['subtitle']!.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Riwayat"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(56),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Cari riwayat...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
        ),
      ),
      body: _filteredHistory.isEmpty
          ? Center(child: Text('Tidak ada data riwayat.'))
          : ListView.separated(
              padding: EdgeInsets.all(16),
              itemCount: _filteredHistory.length,
              separatorBuilder: (_, __) => SizedBox(height: 12),
              itemBuilder: (context, index) {
                final item = _filteredHistory[index];
                return Card(
                  elevation: 2,
                  child: ListTile(
                    leading: Icon(Icons.history, color: Colors.blue),
                    title: Text(item['title']!),
                    subtitle: Text(item['subtitle']!),
                    trailing: Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: Text(item['title']!),
                          content: Text(item['description'] ?? 'Tidak ada deskripsi.'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text('Tutup'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
