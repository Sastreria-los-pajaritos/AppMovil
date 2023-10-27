import 'package:app_los_pajaritos/screens/mis_compras_screen.dart';
import 'package:flutter/material.dart';

Color bgColor = Colors.red.shade200;

class PerfilScreen extends StatelessWidget {
  final String userEmail;
  final String userName;
  final String id;
  const PerfilScreen(
      {super.key,
      required this.userName,
      required this.userEmail,
      required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white60,
        title: const Text(
          "Mi perfil",
          style: TextStyle(color: Colors.white),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: bgColor,
          ),
        ),
      ),
      body: _PerfilScreen(userName: userName, userEmail: userEmail, id: id),
    );
  }
}

class _PerfilScreen extends StatefulWidget {
  final String userEmail;
  final String userName;
  final String id;
  const _PerfilScreen(
      {required this.userName, required this.userEmail, required this.id});

  @override
  PerfilState createState() =>
      PerfilState(userName: userName, userEmail: userEmail, id: id);
}

class PerfilState extends State {
  final String userEmail;
  final String userName;
  final String id;

  PerfilState(
      {required this.userName, required this.userEmail, required this.id});

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        child: ListView(
          children: [
            Hero(
              tag: "C001",
              child: CircleAvatar(
                radius: 75.0,
                backgroundColor: Colors.grey.shade200,
                child: Image.asset('assets/images/logo/user.png'),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            const Divider(
              color: Colors.black12,
            ),
            const SizedBox(
              height: 12,
            ),
            const Text(
              "Nombre",
              style: TextStyle(color: Colors.black54),
            ),
            Text(
              userName,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 12,
            ),
            const Text(
              "Correo electrónico",
              style: TextStyle(color: Colors.black54),
            ),
            Text(
              userEmail,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 15,
            ),
            const Divider(
              color: Colors.black12,
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                // padding: EdgeInsets.symmetric(horizontal: 16),
                maximumSize: MaterialStateProperty.all<Size>(
                    const Size(double.maxFinite, 50)),
                minimumSize: MaterialStateProperty.all<Size>(
                    const Size(double.maxFinite, 50)),
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.black87),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0)),
                ),
              ),
              child: const Text(
                'Mis direcciones',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => (MisComprasScreen(clienteID: id)),
                    ));
              },
              style: ButtonStyle(
                // padding: EdgeInsets.symmetric(horizontal: 16),
                maximumSize: MaterialStateProperty.all<Size>(
                    const Size(double.maxFinite, 50)),
                minimumSize: MaterialStateProperty.all<Size>(
                    const Size(double.maxFinite, 50)),
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.black87),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0)),
                ),
              ),
              child: const Text(
                'Ir a mis compras',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
