import 'package:app_los_pajaritos/screens/search_screen.dart';
import 'package:app_los_pajaritos/screens/shopping_cart.dart';
import 'package:app_los_pajaritos/services/ventas_service.dart';
import 'package:flutter/material.dart';

Color bgColor = Colors.red.shade200;

class AppBarWidget {
  static getAppBar(BuildContext context, bool isAppBarHome, String title) {
    return AppBar(
      backgroundColor: bgColor,
      foregroundColor: Colors.white,
      title: isAppBarHome
          ? Center(
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.white,
                    width: 1,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(40),
                  ),
                ),
                child: TextField(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => (const SearchScreen())),
                    );
                  },
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: 'Buscar en la tienda',
                    hintStyle: const TextStyle(color: Colors.grey),
                    prefixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {},
                      iconSize: 20,
                    ),
                    contentPadding: const EdgeInsets.all(0),
                    border: InputBorder.none,
                    fillColor: Colors.white,
                  ),
                ),
              ),
            )
          : Text(title),
      elevation: 0,
      actions: isAppBarHome
          ? [
              IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ShoppingCart()),
                    );
                  },
                  icon: Badge(
                    label:
                        Text(VentasServices.cantProductosCarrito().toString()),
                    backgroundColor: Colors.black87,
                    child: const Icon(Icons.shopping_cart, color: Colors.white),
                  )),
            ]
          : [
              IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => (const SearchScreen())),
                    );
                  },
                  icon: const Icon(Icons.search)),
              IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ShoppingCart()),
                    );
                  },
                  icon: Badge(
                    label:
                        Text(VentasServices.cantProductosCarrito().toString()),
                    backgroundColor: Colors.black87,
                    child: const Icon(Icons.shopping_cart, color: Colors.white),
                  )),
            ],
    );
  }
}
