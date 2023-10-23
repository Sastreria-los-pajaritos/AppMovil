import 'package:app_los_pajaritos/components/snackbar_notifiction_widget.dart';
import 'package:app_los_pajaritos/screens/log_in_screen.dart';
import 'package:app_los_pajaritos/services/home_service.dart';
import 'package:flutter/material.dart';

Color bgColor = const Color.fromARGB(255, 248, 249, 250);
void main() => runApp(const SingUpScreen());

class SingUpScreen extends StatelessWidget {
  const SingUpScreen({super.key});

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
      body: const _SingUpScreen(),
    );
  }
}

class _SingUpScreen extends StatefulWidget {
  const _SingUpScreen();

  @override
  SingUpScreenState createState() => SingUpScreenState();
}

class SingUpScreenState extends State {
  TextEditingController emailTxt = TextEditingController();

  void register() {
    var email = emailTxt.text.toString();

    HomeServices.singUp(email).then((res) {
      _validateEmail(context, sendEmail: true);
    });
  }

  void _validateEmail(BuildContext context, {bool sendEmail = false}) {
    var email = emailTxt.text.toString();

    HomeServices.validaEmail(email).then((res) {
      var emailsEncontrados = res;
      if (emailsEncontrados.length == 1 && sendEmail) {
        var objUser = emailsEncontrados[0];
        _sendEmail(context, email, objUser.id);
        return;
      }
      if (emailsEncontrados.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBarWidget.snackMessage(context,
              'Ya existe una cuenta con el correo ingresado', Colors.red,
              textColor: Colors.white),
        );
        return;
      }
      register();
    });
  }

  void _sendEmail(BuildContext context, String email, String id) {
    HomeServices.sendValidateEmail(email, id).then((res) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBarWidget.snackMessage(
            context,
            'Correo enviado, para continuar, ingrese al enlace que fue enviado a su correo electrónico',
            Colors.green.shade300,
            textColor: Colors.white),
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LogInScreen()),
      );
    }).catchError((err) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBarWidget.snackMessage(
            context, 'Error al enviar correo', Colors.red,
            textColor: Colors.white),
      );
    });
  }

  @override
  void initState() {
    super.initState();
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
                            'Registro',
                            style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.w900,
                                color: Colors.black),
                          ),
                        ),
                        const Text(
                          'Ingresa tu correo electrónico para continuar.',
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
                    top: Radius.circular(5),
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
                              _validateEmail(context);
                            },
                            child: const SizedBox(
                              width: double.infinity,
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'Registrarme',
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
                                    builder: (context) => const LogInScreen()),
                              );
                            },
                            child: const Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Inciar sesión',
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