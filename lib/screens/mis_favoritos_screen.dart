import 'package:flutter/material.dart';

Color bgColor = Colors.red.shade200;
void main() => runApp(const FavoritosScreen());

class FavoritosScreen extends StatelessWidget {
  const FavoritosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white60,
        title: const Text(
          "Favoritos",
          style: TextStyle(color: Colors.white),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: bgColor,
          ),
        ),
      ),
      body: const _FavoritosScreen(),
    );
  }
}

class _FavoritosScreen extends StatefulWidget {
  const _FavoritosScreen({super.key});

  @override
  FavoritosState createState() => FavoritosState();
}

class FavoritosState extends State {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Mis Favoritos'),
      ),
    );
  }
}
