import 'package:app_los_pajaritos/components/snackbar_notifiction_widget.dart';
import 'package:app_los_pajaritos/screens/home_screen.dart';
import 'package:app_los_pajaritos/screens/sing_up_screen.dart';
import 'package:app_los_pajaritos/services/home_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

Color bgColor = const Color.fromARGB(255, 248, 249, 250);
void main() => runApp(const LogInScreen());

class LogInScreen extends StatelessWidget {
  const LogInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: bgColor,
          ),
        ),
      ),
      body: const _LogInScreen(),
    );
  }
}

class _LogInScreen extends StatefulWidget {
  const _LogInScreen({super.key});

  @override
  LogInScreenState createState() => LogInScreenState();
}

class LogInScreenState extends State {
  SharedPreferences? _prefs;

  TextEditingController emailTxt = TextEditingController();
  TextEditingController passTxt = TextEditingController();

  void _login(BuildContext context) {
    var usuario = emailTxt.text.toString();
    var contra = passTxt.text.toString();
    HomeServices.logIn(usuario, contra).then((res) {
      if (res.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBarWidget.snackMessage(
              context, 'Email o contraseña incorrectos', Colors.red,
              textColor: Colors.white),
        );
      } else {
        final cliente = res[0];
        if (cliente.isAdmin) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBarWidget.snackMessage(context, 'Acceso no válido', Colors.red,
                textColor: Colors.white),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBarWidget.snackMessage(
                context, 'Bienvenido', Colors.green.shade300,
                textColor: Colors.white),
          );
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MyHomePage()),
          );
          _prefs!.setBool('isAuth', true);
          _prefs!.setString('token', cliente.id);
          _prefs!.setString('email', cliente.email);
          _prefs!.setString('name', cliente.name);
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _cargarPreferencias();
  }

  _cargarPreferencias() async {
    _prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: bgColor,
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                color: bgColor,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Por favor,',
                            style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.w900,
                                color: Colors.black),
                          ),
                        ),
                        const Text(
                          'Inicia sesión para continuar.',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        Center(
                            child: Padding(
                          padding: const EdgeInsets.only(top: 40),
                          child: Image.asset(
                            'assets/images/logo/logo.png',
                            scale: 4.5,
                          ),
                        )),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black26,
                        offset: Offset(-0, -2),
                        blurRadius: 30)
                  ],
                  gradient: LinearGradient(
                    colors: [
                      Colors.red.shade200,
                      Colors.red.shade300,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(10),
                  ),
                ),
                child: Form(
                  // key: logInKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 40,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextFormField(
                            decoration: InputDecoration(
                              hoverColor: Colors.grey.shade200,
                              isDense: true,
                              isCollapsed: true,
                              hintText: 'Correo electrónico',
                              hintStyle: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade600,
                                  fontWeight: FontWeight.bold),
                              contentPadding: const EdgeInsets.all(25),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Icon(
                                  Icons.email_rounded,
                                  size: 25,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                              fillColor: Colors.grey.shade50,
                              focusColor: Colors.grey.shade50,
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 3,
                                  color: Colors.grey.shade300,
                                ),
                              ),
                              filled: true,
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                            ),
                            controller: emailTxt,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return 'Por favor ingresa tu correo electrónico';
                              }
                              return null;
                            },
                            // onSaved: (val) {
                            //   logEmail = val;
                            // },
                          ),
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextFormField(
                            obscureText: true,
                            decoration: InputDecoration(
                              hoverColor: Colors.grey.shade200,
                              hintText: 'Contraseña',
                              hintStyle: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade600,
                                  fontWeight: FontWeight.bold),
                              contentPadding: const EdgeInsets.all(25),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Icon(
                                  Icons.password,
                                  size: 25,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                              fillColor: Colors.grey.shade50,
                              focusColor: Colors.grey.shade50,
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 3,
                                  color: Colors.grey.shade300,
                                ),
                              ),
                              filled: true,
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                            ),
                            obscuringCharacter: '*',
                            // obscureText: logViewPassword,
                            controller: passTxt,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return 'Por favor ingresa tu contraseña';
                              }
                              return null;
                            },
                            onSaved: (val) {
                              // setState(() {
                              //   logPassword = val;
                              // });
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: GestureDetector(
                            onTap: () {},
                            child: const Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                '¿Olvidaste tu contraseña?',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: ElevatedButton(
                            style: ButtonStyle(
                              maximumSize: MaterialStateProperty.all<Size>(
                                  const Size(double.maxFinite, 50)),
                              minimumSize: MaterialStateProperty.all<Size>(
                                  const Size(double.maxFinite, 50)),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.black87),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4.0)),
                              ),
                            ),
                            onPressed: () {
                              _login(context);
                            },
                            child: const SizedBox(
                              width: double.infinity,
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'Iniciar sesión',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 30),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SingUpScreen()),
                              );
                            },
                            child: const Align(
                              alignment: Alignment.center,
                              child: Text(
                                '¿No tienes una cuenta? Registrate',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}