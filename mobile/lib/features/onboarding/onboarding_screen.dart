import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _step = 0;
  final _name = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  void _next() {
    if (_step < 2) {
      setState(() => _step++);
    } else {
      Navigator.of(context).pushReplacementNamed('/nearby');
    }
  }

  @override
  Widget build(BuildContext context) {
    final titles = ['NEARへようこそ', '名前を決める', '位置情報を許可'];
    final descriptions = [
      '今いる10分圏をリアルタイムのSocial Worldにします。',
      '近くの人に表示する名前です。',
      '近い順のDiscoveryに使います。正確な位置は公開しません。',
    ];
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              Text(titles[_step], style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 16),
              Text(descriptions[_step]),
              if (_step == 1) ...[
                const SizedBox(height: 24),
                TextField(controller: _name, decoration: const InputDecoration(labelText: '表示名')),
              ],
              const Spacer(),
              FilledButton(onPressed: _next, child: Text(_step == 2 ? 'はじめる' : '次へ')),
            ],
          ),
        ),
      ),
    );
  }
}
