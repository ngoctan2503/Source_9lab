import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.teal.shade800,
    body: SafeArea(child: Center(child: SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 480),
        child: const Column(mainAxisSize: MainAxisSize.min, children: [
          CircleAvatar(radius: 56,
            backgroundImage: AssetImage('assets/images/avatar.png')),
          SizedBox(height: 16),
          Text('ĐẶNG NGỌC TÂN', style: TextStyle(fontSize: 30,
            color: Colors.white, fontWeight: FontWeight.bold)),
          Text('FLUTTER DEVELOPER', style: TextStyle(color: Colors.white70,
            letterSpacing: 3)),
          Divider(height: 40, color: Colors.white54),
          Card(child: ListTile(leading: Icon(Icons.phone),
            title: Text('0932581317'))),
          Card(child: ListTile(leading: Icon(Icons.email),
            title: Text('tandn.23ite@vku.udn.vn'))),
        ]),
      ),
    ))),
  );
}
