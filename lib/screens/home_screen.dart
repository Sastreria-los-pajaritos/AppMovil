import 'package:app_los_pajaritos/components/app_bar_widget.dart';
import 'package:app_los_pajaritos/components/card_category_widget.dart';
import 'package:app_los_pajaritos/components/spinner_widget.dart';
import 'package:app_los_pajaritos/screens/acerca_de_screen.dart';
import 'package:app_los_pajaritos/screens/aviso_privacidad_screen.dart';
import 'package:app_los_pajaritos/screens/log_in_screen.dart';
import 'package:app_los_pajaritos/screens/mis_compras_screen.dart';
import 'package:app_los_pajaritos/screens/mis_favoritos_screen.dart';
import 'package:app_los_pajaritos/screens/perfil_screen.dart';
import 'package:app_los_pajaritos/screens/preguntas_frecuentes.dart';
import 'package:app_los_pajaritos/screens/product_detail_screen.dart';
import 'package:app_los_pajaritos/screens/categories_screen.dart';
import 'package:app_los_pajaritos/screens/products_category_screen.dart';
import 'package:app_los_pajaritos/screens/search_screen.dart';
import 'package:app_los_pajaritos/services/home_service.dart';
import 'package:app_los_pajaritos/services/ventas_service.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

final List<String> imgList = [
  'https://sastrerialospajaritos.proyectowebuni.com/assets//resources/sld1.png',
  'https://sastrerialospajaritos.proyectowebuni.com/assets//resources/sld2.png',
  'https://sastrerialospajaritos.proyectowebuni.com/assets//resources/sld3.png',
];

final numberFormat = NumberFormat.currency(locale: 'es_MX', symbol: "\$");

void main() => runApp(const HomeScreen());

final List<Widget> imageSliders = imgList
    .map((item) => Container(
          margin: const EdgeInsets.all(2.0),
          child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              child: Stack(
                children: <Widget>[
                  Image.network(
                    item,
                    fit: BoxFit.fitHeight,
                    height: 1000,
                  ),
                  Positioned(
                    bottom: 0.0,
                    left: 0.0,
                    right: 0.0,
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(50, 0, 0, 0),
                            Color.fromARGB(0, 0, 0, 0)
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10.0),
                    ),
                  ),
                ],
              )),
        ))
    .toList();

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  SharedPreferences? _prefs;
  bool? isAuth;
  String? name = '';
  String? email = '';
  String? id = '';
  final _vs = VentasServices();

  final Color bgColor = Colors.red.shade200;

  @override
  void initState() {
    super.initState();
    _cargarPreferencias();
  }

  _cargarPreferencias() async {
    _prefs = await SharedPreferences.getInstance();
    isAuth = _prefs!.getBool('isAuth');
    id = _prefs!.getString('token');
    if (id != null) {
      if (isAuth == true) {
        name = _prefs!.getString('name');
        email = _prefs!.getString('email');
      }
    }
  }

  _cerrarSesion() {
    _prefs!.remove('isAuth');
    _prefs!.remove('token');
    _prefs!.remove('name');
    _prefs!.remove('email');
    isAuth = false;
    name = '';
    email = '';
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MyHomePage()),
    );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: const Text(
          'Se cerró sesión correctamente',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.red.shade300,
      ),
    );
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget.getAppBar(context, true, ''),
      body: const HomeScreen(),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Builder(builder: (context) {
              if (isAuth == true) {
                return UserAccountsDrawerHeader(
                    decoration: BoxDecoration(
                      color: bgColor,
                    ),
                    accountName: Text(
                      name ?? '',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    accountEmail: Text(
                      email ?? '',
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    currentAccountPicture: CircleAvatar(
                        radius: (52),
                        backgroundColor: Colors.white,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.asset("assets/images/logo/user.png"),
                        )));
              } else {
                return DrawerHeader(
                    decoration: BoxDecoration(
                      color: bgColor,
                    ),
                    child: ListView(
                      children: [
                        const Text(
                          'Ingresa a tu cuenta',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const Text(
                          'Podrás comprar en la tienda y ver el detalle de tus pedidos.',
                          style: TextStyle(fontSize: 14),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        ElevatedButton(
                          child: const Text('Inicia sesión'),
                          onPressed: () => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LogInScreen()),
                            )
                          },
                        )
                      ],
                    ));
              }
            }),
            ListTile(
              leading: const Icon(Icons.home_outlined),
              title: const Text('Home'),
              selected: _selectedIndex == 0,
              onTap: () {
                _onItemTapped(0);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => (const MyHomePage())),
                );
              },
              selectedColor: bgColor,
            ),
            ListTile(
              leading: const Icon(Icons.search_outlined),
              title: const Text('Buscar'),
              selected: _selectedIndex == 1,
              onTap: () {
                _onItemTapped(1);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => (const SearchScreen())),
                );
              },
              selectedColor: bgColor,
            ),
            ListTile(
              leading: const Icon(Icons.person_outline_outlined),
              title: const Text('Mi perfil'),
              selected: _selectedIndex == 2,
              onTap: () {
                _onItemTapped(2);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => (isAuth == true
                          ? PerfilScreen(
                              userName: name ?? '',
                              userEmail: email ?? '',
                              id: id ?? '')
                          : const LogInScreen())),
                );
              },
              selectedColor: bgColor,
            ),
            ListTile(
              leading: const Icon(Icons.shopping_cart_outlined),
              title: const Text('Mis compras'),
              selected: _selectedIndex == 3,
              onTap: () {
                _onItemTapped(3);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => (isAuth == true
                          ? MisComprasScreen(
                              clienteID: id ?? '',
                            )
                          : const LogInScreen())),
                );
              },
              selectedColor: bgColor,
            ),
            ListTile(
              leading: const Icon(Icons.favorite_border),
              title: const Text('Favoritos'),
              selected: _selectedIndex == 4,
              onTap: () {
                _onItemTapped(4);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => (isAuth == true
                          ? const FavoritosScreen()
                          : const LogInScreen())),
                );
              },
              selectedColor: bgColor,
            ),
            ListTile(
              leading: const Icon(Icons.format_list_bulleted),
              title: const Text('Categorías'),
              selected: _selectedIndex == 5,
              onTap: () {
                _onItemTapped(5);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CategoryScreen()),
                );
              },
              selectedColor: bgColor,
            ),
            const Divider(
              color: Colors.black12,
            ),
            ListTile(
              leading: const Icon(Icons.privacy_tip_outlined),
              title: const Text('Aviso de privacidad'),
              selected: _selectedIndex == 6,
              onTap: () {
                _onItemTapped(6);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AvisoPrivacidadScreen()),
                );
              },
              selectedColor: bgColor,
            ),
            ListTile(
              leading: const Icon(Icons.question_answer_outlined),
              title: const Text('Preguntas frecuentes'),
              selected: _selectedIndex == 7,
              onTap: () {
                _onItemTapped(7);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PreguntasFrecuentesScreen()),
                );
              },
              selectedColor: bgColor,
            ),
            const Divider(
              color: Colors.black12,
            ),
            ListTile(
              title: const Text('Acerca de Los Pajaritos'),
              selected: _selectedIndex == 8,
              onTap: () {
                _onItemTapped(8);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AcercaDeScreen()),
                );
              },
              selectedColor: bgColor,
            ),
            const Divider(
              color: Colors.black12,
            ),
            Builder(builder: (context) {
              if (isAuth == true) {
                return ListTile(
                  leading: const Icon(Icons.logout_rounded),
                  title: const Text('Cerrar sesión'),
                  onTap: () {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Cerrar sesión'),
                        content:
                            const Text('¿Seguro que deseas cerrar sesión?'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Cancelar'),
                          ),
                          TextButton(
                            onPressed: () => _cerrarSesion(),
                            child: const Text('Confirmar'),
                          ),
                        ],
                      ),
                    );
                  },
                  selectedColor: bgColor,
                );
              } else {
                return ListTile(
                  leading: const Icon(Icons.login_rounded),
                  title: const Text('Ingresar'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LogInScreen()),
                    );
                  },
                  selectedColor: bgColor,
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [0.008, 0.18, 0.2, 0.5],
            colors: [
              Colors.red.shade200,
              Colors.white,
              Colors.white,
              Colors.white,
            ],
          ),
        ),
        child: ListView(
          children: [
            Column(children: <Widget>[
              carouselSection,
              categoriesButtonSection,
              categoriesPerSex('man', 'caballero'),
              categoriesPerSex('woman', 'dama'),
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Text(
                  'Productos principales',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              principalesProductosWidget(),
            ]),
          ],
        ),
      ),
    );
  }
}

// WIDGETS

Widget carouselSection = CarouselSlider(
  options: CarouselOptions(
      autoPlayAnimationDuration: const Duration(seconds: 2),
      autoPlay: true,
      aspectRatio: 3.3,
      enlargeCenterPage: true,
      enlargeStrategy: CenterPageEnlargeStrategy.height,
      viewportFraction: 0.95),
  items: imageSliders,
);

Widget categoriesButtonSection = Column(
  children: <Widget>[
    const Padding(
      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: Text(
        'Categorías',
        textAlign: TextAlign.left,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    ),
    FutureBuilder(
      future: HomeServices.getCategories(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return Container(
            margin: const EdgeInsets.fromLTRB(20, 5, 0, 0),
            height: 60.0,
            child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.fromLTRB(2, 8, 0, 8),
                children: snapshot.data!
                    .map((categoria) => Padding(
                        padding: const EdgeInsets.all(5),
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ProductsCategoryScreen(
                                            id: categoria.id,
                                            categoryName: categoria.name)),
                              );
                            },
                            child: Text(categoria.name))))
                    .toList()),
          );
        } else {
          return const Padding(
            padding: EdgeInsets.all(15),
            child: SpinnerWidget(),
          );
        }
      },
    ),
  ],
);

Widget categoriesPerSex(String type, String name) => Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
          child: Text(
            "Principales categorías para $name",
            textAlign: TextAlign.left,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        FutureBuilder(
          future: HomeServices.getCategoriesPerSex(type, 2),
          builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
            if (snapshot.hasData) {
              return Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  alignment: WrapAlignment.start,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  direction: Axis.horizontal,
                  runAlignment: WrapAlignment.start,
                  verticalDirection: VerticalDirection.down,
                  clipBehavior: Clip.none,
                  children: snapshot.data!
                      .map(
                        (categoria) => CardCategory(
                          categoria: categoria,
                          muestraDescripcion: false,
                        ),
                      )
                      .toList(),
                ),
              );
            } else {
              return const Padding(
                padding: EdgeInsets.all(15),
                child: SpinnerWidget(),
              );
            }
          },
        ),
      ],
    );

Widget principalesProductosWidget() => FutureBuilder(
      future: HomeServices.getProducts(6),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return Padding(
            padding: const EdgeInsets.all(0),
            child: Wrap(
              children: snapshot.data!
                  .map(
                    (producto) => Container(
                      margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                      width: MediaQuery.sizeOf(context).width,
                      height: 110,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 3,
                            color: Color(0x411D2429),
                            offset: Offset(0, 2),
                          )
                        ],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ProductDetailView(productoID: producto.id)),
                          );
                        },
                        child: Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.network(
                                    producto.getImage(),
                                    width: 70,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      8, 8, 4, 0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        producto.title,
                                        style: const TextStyle(
                                          fontFamily: 'Outfit',
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        softWrap: true,
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(0, 4, 8, 0),
                                          child: Text(
                                            producto.description,
                                            textAlign: TextAlign.start,
                                            style: const TextStyle(
                                              fontFamily: 'Outfit',
                                              color: Color(0xFF7C8791),
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            softWrap: true,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 4, 0, 0),
                                    child: IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ProductDetailView(
                                                        productoID:
                                                            producto.id)),
                                          );
                                        },
                                        icon: const Icon(
                                          Icons.chevron_right_rounded,
                                          color: Color(0xFF57636C),
                                          size: 30,
                                        )),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 4, 8),
                                    child: Text(
                                      numberFormat.format(producto.precio),
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Colors.red.shade300),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          );
        } else {
          return const SpinnerWidget();
        }
      },
    );
