import 'package:flutter/material.dart';

Color bgColor = Colors.red.shade200;
void main() => runApp(const PreguntasFrecuentesScreen());

class PreguntasFrecuentesScreen extends StatelessWidget {
  const PreguntasFrecuentesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white60,
        title: const Text(
          "Preguntas frecuentes",
          style: TextStyle(color: Colors.white),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: bgColor,
          ),
        ),
      ),
      body: const _PreguntasFrecuentesScreen(),
    );
  }
}

class _PreguntasFrecuentesScreen extends StatefulWidget {
  const _PreguntasFrecuentesScreen();

  @override
  PreguntasFrecuentesState createState() => PreguntasFrecuentesState();
}

class PreguntasFrecuentesState extends State {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Preguntas frecuentes'),
      ),
    );
  }
}
