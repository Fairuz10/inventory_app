import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class DataSantriPage extends StatefulWidget {
  @override
  _DataSantriPageState createState() => _DataSantriPageState();
}

class _DataSantriPageState extends State<DataSantriPage> {
  final List<Map<String, String>> _dataSantri = [];
  List<Map<String, String>> _filteredSantri = [];

  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _nisController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Future<void> _fetchDataSantri() async {
    final response = await http.get(Uri.parse('http://172.20.10.3:8000/api/santri')); // Ganti IP sesuai backend kamu

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      setState(() {
        _dataSantri.clear();
        _dataSantri.addAll(data.map((item) => {
          'nama': item['nama'] ?? '',
          'alamat': item['alamat_santri'] ?? '',
          'kelas': item['kelas'] ?? '',
          'kamar': item['kamar'] ?? '',
          'wali_santri': item['wali_santri'] ?? '',
          'no_telp_wali_santri': item['no_telp_wali_santri'] ?? '',
          'tanggal_masuk': item['tanggal_masuk'] ?? '',
          'image': item['image'] ?? '',
        }));
        _filteredSantri = _dataSantri;
      });
    } else {
      _showSnackbar('Gagal mengambil data santri. Status: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchDataSantri();
    _searchController.addListener(_searchSantri);
  }

  @override
  void dispose() {
    _namaController.dispose();
    _nisController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _searchSantri() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredSantri = _dataSantri.where((santri) {
        final nama = santri['nama']!.toLowerCase();
        final nis = santri['nis']?.toLowerCase() ?? '';
        return nama.contains(query) || nis.contains(query);
      }).toList();
    });
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Santri'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(56),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Cari nama atau NIS...',
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
      body: _filteredSantri.isEmpty
          ? Center(child: Text('Data santri kosong atau tidak ditemukan'))
          : ListView.builder(
              itemCount: _filteredSantri.length,
              itemBuilder: (context, index) {
                final santri = _filteredSantri[index];
                return ListTile(
                  title: Text(santri['nama']!),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Alamat: ${santri['alamat']}'),
                      Text('Kelas: ${santri['kelas']}'),
                      Text('Kamar: ${santri['kamar']}'),
                      Text('Wali Santri: ${santri['wali_santri']}'),
                      Text('No. Telp Wali Santri: ${santri['no_telp_wali_santri']}'),
                      Text('Tanggal Masuk: ${santri['tanggal_masuk']}'),
                    ],
                  ),
                  leading: santri['image'] != null && santri['image']!.isNotEmpty
                      ? Image.network(santri['image']!, width: 50, height: 50, fit: BoxFit.cover)
                      : CircleAvatar(child: Icon(Icons.person)),
                );
              },
            ),
    );
  }
}
