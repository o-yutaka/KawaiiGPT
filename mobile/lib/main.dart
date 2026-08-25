import 'package:flutter/material.dart';

void main() => runApp(const NearApp());

class NearUser {
  final String name;
  final int age;
  final int distance;
  final String activity;
  final String recent;
  final List<String> interests;
  final bool verified;

  const NearUser({
    required this.name,
    required this.age,
    required this.distance,
    required this.activity,
    this.recent = '',
    this.interests = const [],
    this.verified = false,
  });
}

const users = <NearUser>[
  NearUser(name: 'Aki', age: 24, distance: 42, activity: 'LIVE', interests: ['Cafe', 'Music'], verified: true),
  NearUser(name: 'Rin', age: 26, distance: 95, activity: 'JUST NOW', interests: ['Travel', 'Food']),
  NearUser(name: 'Sora', age: 23, distance: 180, activity: 'LIVE', interests: ['Gaming', 'Anime'], verified: true),
  NearUser(name: 'Mio', age: 25, distance: 310, activity: 'RECENT', recent: '5分前にこの周辺', interests: ['Fashion', 'Movies']),
  NearUser(name: 'Ren', age: 28, distance: 520, activity: 'RECENT', recent: '12分前にこの周辺', interests: ['Sports', 'Cafe']),
];

class NearApp extends StatelessWidget {
  const NearApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark, scaffoldBackgroundColor: const Color(0xFF07080C)),
      home: const NearHome(),
    );
  }
}

class NearHome extends StatefulWidget {
  const NearHome({super.key});

  @override
  State<NearHome> createState() => _NearHomeState();
}

class _NearHomeState extends State<NearHome> {
  int tab = 0;
  Offset touch = Offset.zero;
  bool touchActive = false;

  void openChat(NearUser user) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => NearChat(user: user)));
  }

  @override
  Widget build(BuildContext context) {
    final nearest = users.first;
    return Listener(
      onPointerDown: (e) => setState(() { touch = e.position; touchActive = true; }),
      onPointerMove: (e) => setState(() => touch = e.position),
      onPointerUp: (_) => setState(() => touchActive = false),
      onPointerCancel: (_) => setState(() => touchActive = false),
      child: Scaffold(
        body: Stack(children: [
          SafeArea(
            child: CustomScrollView(slivers: [
              SliverToBoxAdapter(child: Padding(padding: const EdgeInsets.fromLTRB(16, 12, 16, 8), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const Text('NEAR', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, letterSpacing: -1)),
                Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7), decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(99), border: Border.all(color: Colors.white12)), child: const Text('10分圏 • Live', style: TextStyle(color: Colors.white60, fontSize: 12))),
              ]))),
              const SliverToBoxAdapter(child: Padding(padding: EdgeInsets.fromLTRB(16, 12, 16, 18), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('YOUR WORLD, RIGHT NOW', style: TextStyle(color: Color(0xFF67F7C4), fontSize: 12, fontWeight: FontWeight.w800, letterSpacing: 1)),
                SizedBox(height: 7),
                Text('近くにいる。\n今つながる。', style: TextStyle(fontSize: 36, fontWeight: FontWeight.w900, height: 1.02)),
                SizedBox(height: 8),
                Text('自分の10分圏を、リアルタイムのSocial Worldに。', style: TextStyle(color: Colors.white54)),
              ]))),
              SliverToBoxAdapter(child: _section('いちばん近い', 'Closest First', [ _userCard(nearest, nearest: true) ])),
              SliverToBoxAdapter(child: _section('近くでアクティブ', '10分圏', users.skip(1).take(3).map(_userCard).toList())),
              SliverToBoxAdapter(child: _section('RECENT HERE', '少し前までここにいた', users.where((u) => u.recent.isNotEmpty).map(_userCard).toList())),
              SliverToBoxAdapter(child: _section('NOW', '24h', const [ _NowCard(name: 'Aki', area: '心斎橋周辺', text: 'この辺でカフェ探してる ☕'), _NowCard(name: 'Sora', area: '難波周辺', text: '今からちょっとゲームする') ])),
              const SliverToBoxAdapter(child: SizedBox(height: 110)),
            ]),
          ),
          if (touchActive) Positioned(left: touch.dx - 46, top: touch.dy - 46, child: IgnorePointer(child: Container(width: 92, height: 92, decoration: const BoxDecoration(shape: BoxShape.circle, gradient: RadialGradient(colors: [Color(0x4D9BA6FF), Color(0x169BA6FF), Colors.transparent]))))),
        ]),
        bottomNavigationBar: NavigationBar(
          selectedIndex: tab,
          onDestinationSelected: (value) => setState(() => tab = value),
          destinations: const [
            NavigationDestination(icon: Icon(Icons.near_me_outlined), selectedIcon: Icon(Icons.near_me), label: 'NEAR'),
            NavigationDestination(icon: Icon(Icons.chat_bubble_outline), selectedIcon: Icon(Icons.chat_bubble), label: 'CHAT'),
            NavigationDestination(icon: Icon(Icons.flash_on_outlined), selectedIcon: Icon(Icons.flash_on), label: 'NOW'),
            NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'ME'),
          ],
        ),
      ),
    );
  }

  Widget _section(String title, String sub, List<Widget> children) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(title, style: const TextStyle(fontWeight: FontWeight.w850)), Text(sub, style: const TextStyle(color: Colors.white38, fontSize: 12))]),
      const SizedBox(height: 8),
      ...children,
    ]),
  );

  Widget _userCard(NearUser user, {bool nearest = false}) => GestureDetector(
    onTap: () => openChat(user),
    child: TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 220),
      tween: Tween(begin: 1, end: 1),
      builder: (context, scale, child) => Transform.scale(scale: scale, child: child),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(color: nearest ? const Color(0xFF151824) : const Color(0xFF10121A), borderRadius: BorderRadius.circular(23), border: Border.all(color: nearest ? const Color(0x52626CFF) : const Color(0x2529333C))),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Container(width: 48, height: 48, alignment: Alignment.center, decoration: BoxDecoration(color: const Color(0xFF202640), borderRadius: BorderRadius.circular(16)), child: Text(user.name.characters.first, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900))),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('${user.name} ${user.verified ? '✓' : ''}', style: const TextStyle(fontWeight: FontWeight.w900)), const SizedBox(height: 5), Wrap(spacing: 5, children: user.interests.map((x) => Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(99)), child: Text(x, style: const TextStyle(fontSize: 11, color: Colors.white60)))).toList())])),
            Column(crossAxisAlignment: CrossAxisAlignment.end, children: [Text(user.activity, style: const TextStyle(color: Color(0xFF67F7C4), fontSize: 11, fontWeight: FontWeight.w800)), const SizedBox(height: 4), Text('${user.distance}m', style: const TextStyle(color: Colors.white54, fontSize: 11))]),
          ]),
          if (user.recent.isNotEmpty) Padding(padding: const EdgeInsets.only(top: 11), child: Text(user.recent, style: const TextStyle(color: Colors.white54, fontSize: 12))),
          const SizedBox(height: 13),
          SizedBox(width: double.infinity, child: FilledButton(onPressed: () => openChat(user), child: const Text('話してみる', style: TextStyle(fontWeight: FontWeight.w900)))),
        ]),
      ),
    ),
  );
}

class _NowCard extends StatelessWidget {
  final String name; final String area; final String text;
  const _NowCard({required this.name, required this.area, required this.text});
  @override
  Widget build(BuildContext context) => Container(margin: const EdgeInsets.only(bottom: 10), padding: const EdgeInsets.all(15), decoration: BoxDecoration(color: const Color(0xFF111722), borderRadius: BorderRadius.circular(23), border: Border.all(color: Colors.white10)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Row(children: [Container(width: 42, height: 42, alignment: Alignment.center, decoration: BoxDecoration(color: const Color(0xFF202640), borderRadius: BorderRadius.circular(14)), child: Text(name.characters.first, style: const TextStyle(fontWeight: FontWeight.w900))), const SizedBox(width: 10), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(name, style: const TextStyle(fontWeight: FontWeight.w900)), Text(area, style: const TextStyle(color: Colors.white45, fontSize: 11))])]), const SizedBox(height: 10), Text(text, style: const TextStyle(color: Colors.white70)), const SizedBox(height: 8), const Text('今この街で見る • 24h', style: TextStyle(color: Colors.white38, fontSize: 11))]));
}

class NearChat extends StatefulWidget {
  final NearUser user;
  const NearChat({super.key, required this.user});
  @override
  State<NearChat> createState() => _NearChatState();
}
class _NearChatState extends State<NearChat> {
  final controller = TextEditingController();
  final messages = <String>['近くにおるやん', '近くにいるから話してみた。'];
  @override
  void dispose(){ controller.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(widget.user.name, style: const TextStyle(fontWeight: FontWeight.w900)), const Text('● JUST NOW', style: TextStyle(color: Color(0xFF67F7C4), fontSize: 11))])), body: Column(children: [Expanded(child: ListView(padding: const EdgeInsets.all(14), children: [for(final m in messages) Align(alignment: m.startsWith('近くにいる') ? Alignment.centerRight : Alignment.centerLeft, child: Container(margin: const EdgeInsets.symmetric(vertical: 5), padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 11), decoration: BoxDecoration(color: m.startsWith('近くにいる') ? const Color(0xFFECEFFF) : const Color(0xFF141824), borderRadius: BorderRadius.circular(18)), child: Text(m, style: TextStyle(color: m.startsWith('近くにいる') ? Colors.black : Colors.white)))),]), const SafeArea(child: Padding(padding: EdgeInsets.all(10), child: _Composer()))]));
}

class _Composer extends StatefulWidget { const _Composer(); @override State<_Composer> createState()=>_ComposerState(); }
class _ComposerState extends State<_Composer> {
  final c=TextEditingController();
  @override void dispose(){c.dispose(); super.dispose();}
  @override Widget build(BuildContext context)=>Row(children:[Expanded(child:TextField(controller:c, decoration:InputDecoration(hintText:'メッセージ…',filled:true,fillColor:const Color(0xFF10131B),border:OutlineInputBorder(borderRadius:BorderRadius.circular(15),borderSide:BorderSide.none)))),const SizedBox(width:8),FilledButton(onPressed:(){c.clear();},child:const Text('送信'))]);
}
