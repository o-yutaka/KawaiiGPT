import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _name = TextEditingController();
  final _bio = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _bio.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ME')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const CircleAvatar(radius: 38, child: Icon(Icons.person, size: 34)),
          const SizedBox(height: 18),
          TextField(controller: _name, decoration: const InputDecoration(labelText: '表示名')),
          const SizedBox(height: 12),
          TextField(controller: _bio, maxLines: 3, decoration: const InputDecoration(labelText: '自己紹介')),
          const SizedBox(height: 18),
          FilledButton(onPressed: () => Navigator.of(context).maybePop(), child: const Text('保存')),
        ],
      ),
    );
  }
}
