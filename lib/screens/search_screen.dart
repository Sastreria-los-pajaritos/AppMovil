import 'package:flutter/material.dart';

Color bgColor = Colors.red.shade200;
void main() => runApp(const SearchScreen());

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 5,
          shadowColor: Colors.red.shade100,
          foregroundColor: Colors.red.shade200,
          title: const Center(
              child: TextField(
            decoration: InputDecoration(
              hintText: 'Buscar en Sastrería Los Pajaritos',
              hintStyle: TextStyle(color: Colors.black26),
              // contentPadding: EdgeInsets.all(12),
              border: InputBorder.none,
              fillColor: Colors.white,
            ),
          ))),
      body: const _SearchScreen(),
    );
  }
}

class _SearchScreen extends StatefulWidget {
  const _SearchScreen({super.key});

  @override
  SearchState createState() => SearchState();
}

class SearchState extends State {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Resultado'),
      ),
    );
  }
}