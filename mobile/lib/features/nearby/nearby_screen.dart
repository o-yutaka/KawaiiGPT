import 'package:flutter/material.dart';

class NearbyScreen extends StatelessWidget {
  const NearbyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final people = [
      ('Mika', '120 m', 'LIVE'),
      ('Ren', '240 m', 'JUST NOW'),
      ('Aoi', '410 m', 'RECENT'),
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('NEAR')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('いちばん近い', style: TextStyle(fontSize: 13)),
          const SizedBox(height: 8),
          ...people.map((p) => Card(
                child: ListTile(
                  leading: const CircleAvatar(child: Icon(Icons.person)),
                  title: Text(p.$1),
                  subtitle: Text('${p.$2} · ${p.$3}'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => Navigator.of(context).pushNamed('/chat'),
                ),
              )),
          const SizedBox(height: 18),
          const Text('10分圏', style: TextStyle(fontSize: 13)),
          const SizedBox(height: 8),
          const Text('近い順に表示しています。正確な位置は他のユーザーには公開されません。'),
        ],
      ),
    );
  }
}
