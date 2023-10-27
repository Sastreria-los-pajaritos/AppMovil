import 'package:flutter/material.dart';

Color bgColor = Colors.red.shade200;
void main() => runApp(const AcercaDeScreen());

class AcercaDeScreen extends StatelessWidget {
  const AcercaDeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white60,
        title: const Text(
          "Acerca de Sastrería Los Pajaritos",
          style: TextStyle(color: Colors.white),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: bgColor,
          ),
        ),
      ),
      body: const _AcercaDeScreen(),
    );
  }
}

class _AcercaDeScreen extends StatefulWidget {
  const _AcercaDeScreen({super.key});

  @override
  AcercaDeState createState() => AcercaDeState();
}

class AcercaDeState extends State {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Acerca de'),
      ),
    );
  }
}
