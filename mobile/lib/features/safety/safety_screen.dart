import 'package:flutter/material.dart';

class SafetyScreen extends StatelessWidget {
  const SafetyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Safety')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ListTile(
            leading: const Icon(Icons.block),
            title: const Text('Block'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.flag_outlined),
            title: const Text('Report'),
            onTap: () {},
          ),
          const Divider(),
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text('正確な位置情報は他のユーザーへ公開しません。位置情報機能は権限を許可した場合のみ利用します。'),
          ),
        ],
      ),
    );
  }
}
