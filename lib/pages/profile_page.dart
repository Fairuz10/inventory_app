import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String userName = "Fairuz Ayu Wijaya";
  String userEmail = "fairuz.ayu@example.com";
  String userStatus = "Keep calm and code on! 🚀";
  String userAvatarUrl = "";

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Logout"),
        content: Text("Apakah kamu yakin ingin logout?"),
        actions: [
          TextButton(
            child: Text("Batal"),
            onPressed: () => Navigator.of(ctx).pop(),
          ),
          TextButton(
            child: Text("Logout"),
            onPressed: () {
              Navigator.of(ctx).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Logout berhasil!")),
              );
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  void _changeAvatar() {
    // Dummy fungsi ganti avatar, bisa diganti dengan pick image
    setState(() {
      userAvatarUrl =
          "https://i.pravatar.cc/150?img=${DateTime.now().second % 70}"; // random avatar dari pravatar.cc
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            tooltip: 'Edit Profil',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Fitur edit profil belum tersedia.")),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: _changeAvatar,
              child: CircleAvatar(
                radius: 54,
                backgroundColor: Colors.blue.shade100,
                backgroundImage:
                    userAvatarUrl.isNotEmpty ? NetworkImage(userAvatarUrl) : null,
                child: userAvatarUrl.isEmpty
                    ? Icon(Icons.account_circle, size: 108, color: Colors.blue)
                    : null,
              ),
            ),
            SizedBox(height: 16),
            Text(
              userName,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade800,
              ),
            ),
            SizedBox(height: 8),
            Text(
              userStatus,
              style: TextStyle(
                fontStyle: FontStyle.italic,
                color: Colors.blueGrey.shade700,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),
            Text(
              userEmail,
              style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 24),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                _buildBadge("🏆 Achievement", Colors.amber.shade600),
                _buildBadge("⭐ Favorite", Colors.pink.shade400),
                _buildBadge("💡 Ideas", Colors.green.shade400),
                _buildBadge("🚀 Projects", Colors.blue.shade400),
              ],
            ),
            Spacer(),
            ElevatedButton.icon(
              onPressed: () => _showLogoutDialog(context),
              icon: Icon(Icons.logout),
              label: Text("Logout"),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBadge(String label, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color.darken(0.2),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

extension ColorExtension on Color {
  Color darken([double amount = .1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(this);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
    return hslDark.toColor();
  }
}
