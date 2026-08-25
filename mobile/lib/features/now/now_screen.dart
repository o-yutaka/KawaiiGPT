import 'package:flutter/material.dart';

class NowScreen extends StatelessWidget {
  const NowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('NOW')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add_a_photo),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          Card(child: ListTile(title: Text('今、ここにいる'), subtitle: Text('10分圏のNOW。24時間で消えます。'))),
          Card(child: ListTile(title: Text('Recent Here'), subtitle: Text('5分前にこの周辺にいた'))),
        ],
      ),
    );
  }
}
