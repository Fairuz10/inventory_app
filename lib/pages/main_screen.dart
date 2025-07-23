import 'package:flutter/material.dart';
import 'package:inventory_app/pages/home_page.dart'; // ignore: unused_import
import 'package:inventory_app/pages/profile_page.dart'; // ignore: unused_import
import 'package:inventory_app/pages/settings_page.dart'; // ignore: unused_import

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("")),
      drawer: AnimatedDrawer(),
      body: HomePage(),
    );
  }
}

class AnimatedDrawer extends StatefulWidget {
  final Function()? onClose;

  const AnimatedDrawer({Key? key, this.onClose}) : super(key: key);

  @override
  _AnimatedDrawerState createState() => _AnimatedDrawerState();
}

class _AnimatedDrawerState extends State<AnimatedDrawer>
    with SingleTickerProviderStateMixin {
  late AnimationController _iconController;
  bool _isDrawerOpen = false;

  @override
  void initState() {
    super.initState();
    _iconController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _iconController.dispose();
    super.dispose();
  }

  void toggleDrawer() {
    setState(() {
      _isDrawerOpen = !_isDrawerOpen;
      _isDrawerOpen ? _iconController.forward() : _iconController.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text("Admin"),
            accountEmail: Text("admin@example.com"),
            currentAccountPicture: CircleAvatar(
              backgroundColor: colorScheme.onPrimary,
              child: Icon(Icons.person, size: 40, color: colorScheme.primary),
            ),
          ),
          _buildDrawerItem(
            icon: Icons.person,
            text: "Profil",
            onTap: () {
              Navigator.popAndPushNamed(context, '/profil');
            },
          ),
          _buildDrawerItem(
            icon: Icons.settings,
            text: "Pengaturan",
            onTap: () {
              Navigator.popAndPushNamed(context, '/settings');
            },
          ),
          _buildDrawerItem(
            icon: Icons.lock,
            text: "Ganti Password",
            onTap: () {
              Navigator.popAndPushNamed(context, '/ganti_password');
            },
          ),
          Divider(),
          _buildDrawerItem(
            icon: Icons.help,
            text: "Bantuan / FAQ",
            onTap: () {
              Navigator.popAndPushNamed(context, '/faq');
            },
          ),
          _buildDrawerItem(
            icon: Icons.info,
            text: "Tentang Aplikasi",
            onTap: () {
              Navigator.popAndPushNamed(context, '/tentang_aplikasi');
            },
          ),
          Divider(),
          _buildDrawerItem(
            icon: Icons.logout,
            text: "Logout",
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
            },
            iconColor: Colors.red,
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
    Color? iconColor,
  }) {
    bool tapped = false;
    return StatefulBuilder(
      builder: (context, setInnerState) {
        final colorScheme = Theme.of(context).colorScheme;
        return GestureDetector(
          onTapDown: (_) => setInnerState(() => tapped = true),
          onTapUp: (_) => setInnerState(() => tapped = false),
          onTapCancel: () => setInnerState(() => tapped = false),
          child: AnimatedScale(
            scale: tapped ? 1.1 : 1.0,
            duration: Duration(milliseconds: 200),
            child: ListTile(
              leading: Icon(icon, color: iconColor ?? colorScheme.onSurface),
              title: Text(text),
              onTap: onTap,
            ),
          ),
        );
      },
    );
  }
}
