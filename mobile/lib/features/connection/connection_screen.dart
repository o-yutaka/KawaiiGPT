import 'package:flutter/material.dart';

class ConnectionScreen extends StatelessWidget {
  const ConnectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Connection')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          Card(child: ListTile(title: Text('相互Connection'), subtitle: Text('お互いに承認した相手だけ外部連絡先交換へ進めます。'))),
          Card(child: ListTile(title: Text('安全設計'), subtitle: Text('Block / Report はいつでも利用できます。'))),
        ],
      ),
    );
  }
}
