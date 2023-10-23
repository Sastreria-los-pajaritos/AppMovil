import 'package:app_los_pajaritos/components/app_bar_widget.dart';
import 'package:app_los_pajaritos/components/snackbar_notifiction_widget.dart';
import 'package:app_los_pajaritos/components/spinner_widget.dart';
import 'package:app_los_pajaritos/environment/environment.dart';
import 'package:app_los_pajaritos/models/home_models.dart';
import 'package:app_los_pajaritos/screens/log_in_screen.dart';
import 'package:app_los_pajaritos/screens/sing_up_screen.dart';
import 'package:app_los_pajaritos/services/home_service.dart';
import 'package:app_los_pajaritos/services/ventas_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Color bgColor = Colors.red.shade200;
final numberFormat = NumberFormat.currency(locale: 'es_MX', symbol: "\$");

class ProductDetailView extends StatefulWidget {
  final String productoID;
  const ProductDetailView({Key? key, required this.productoID})
      : super(key: key);

  @override
  State<ProductDetailView> createState() =>
      _ProductDetailState(productoID: this.productoID);
}

class _ProductDetailState extends State<ProductDetailView> {
  String productoID;
  String precio = '0';
  String productName = '';
  Inventario? tallasDisponibles;
  Product? objProducto;
  late ProductCarritoModelo objCarritoProducto;
  late List<Category> objCategories;
  int cantidad = 1;
  String category = '';
  Inventario? objTalla;
  _ProductDetailState({required this.productoID});
  @override
  void initState() {
    getProduct();
    precio = numberFormat.format(0);
    super.initState();
  }

  void getProduct() {
    HomeServices.getProduct(productoID).then((value) {
      setState(() {
        objProducto = value;
        getCaterories();
        precio = numberFormat.format(objProducto!.precio);
        productName = objProducto!.title;
        setDatoDefaultTalla(objProducto!);
      });
    });
  }

  void getCaterories() {
    HomeServices.getCategories().then((value) {
      setState(() {
        if (value.isEmpty) return;
        objCategories = value;
        category = objCategories
            .firstWhere((cat) => (cat.id == objProducto!.categoryID))
            .name;
      });
    });
  }

  String getImageUrl(String productName) {
    return "$urlImages$productName";
  }

  void agregarAlCarrito() {
    if (objTalla == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBarWidget.snackMessage(
            context, 'El producto no cuenta con categorías', Colors.red,
            textColor: Colors.white),
      );
      return;
    }
    setState(() {
      setDatoscarrito();
      objCarritoProducto.cantidad = cantidad;
    });
    VentasServices.setProductoCarrito(objCarritoProducto);
  }

  void setDatoscarrito() {
    setState(() {
      objCarritoProducto =
          ProductCarritoModelo.fromJson(objProducto!, category, objTalla!);
    });
  }

  void setDatoDefaultTalla(Product prod) {
    prod.inventario.forEach((i) => {if (i.inventario > 0) objTalla = i});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBarWidget.getAppBar(context, false, productName),
      body: objProducto != null
          ? ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: ClipRRect(
                    child: Image.network(
                      getImageUrl(objProducto!.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const Padding(
                  padding:
                      EdgeInsets.only(left: 14, right: 14, top: 20, bottom: 0),
                  child: Text(
                    'Categoria',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black54),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 14, right: 14, top: 0, bottom: 0),
                  child: Text(
                    'Disponible',
                    textAlign: TextAlign.end,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.red.shade200),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 14, right: 14, top: 5, bottom: 5),
                  child: Text(
                    objProducto!.title,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.w500),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: 14,
                      right: 14,
                      top: 5,
                      bottom: MediaQuery.of(context).padding.bottom),
                  child: Text(
                    // widget.product.description,
                    objProducto!.description,
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(14, 5, 14, 0),
                  height: 55.0,
                  child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                      children: objProducto?.inventario != null
                          ? objProducto!.inventario
                              .map((inv) => Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: OutlinedButton(
                                      onPressed: () => print('sss'),
                                      child: Text(inv.talla.toUpperCase()))))
                              .toList()
                          : const [Text('No hay tallas disponibles.')]),
                )
              ],
            )
          : const SpinnerWidget(),
      bottomNavigationBar: Container(
        color: Colors.black87,
        height: 80 + MediaQuery.of(context).padding.bottom,
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).padding.bottom + 10,
          top: 10,
          left: 20,
          right: 20,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Precio",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                Text(
                  // '\$${_selectedPriceTag.price}',
                  precio,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Spacer(),
            SizedBox(
              child: ElevatedButton(
                onPressed: () {
                  agregarAlCarrito();
                },
                child: const Text("Agregar al carrito"),
              ),
            ),
            // const SizedBox(
            //   width: 6,
            // ),
            // SizedBox(
            //   child: ElevatedButton(
            //     onPressed: () {},
            //     child: const Text("Comprar ahora"),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}