import 'dart:convert';
import 'package:app_los_pajaritos/models/home_models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VentasServices {
  static List<ProductCarritoModelo> arrProductos = [];
  static AltaCarrito? altaCarrito;
  // static int cantProductosCarrito = 0;
  static String? userID = '';

  static SharedPreferences? _sharedPrefs;

  init() async {
    _cargarPreferencias();
    userID = _sharedPrefs!.getString('token');
  }

  static _cargarPreferencias() async {
    _sharedPrefs ??= await SharedPreferences.getInstance();
  }

  static int cantProductosCarrito() {
    _cargarPreferencias();
    if (arrProductos.isNotEmpty) return arrProductos.length;
    getProductosCarrito();
    return arrProductos.length;
  }

  static void getProductosCarrito() async {
    _sharedPrefs ??= await SharedPreferences.getInstance();
    var productos = _sharedPrefs!.getString('carrito');
    if (productos != null) {
      arrProductos = ProductsCarritoModelo.fromJsonList(jsonDecode(productos!));
    } else {
      arrProductos = [];
    }
    calculaSubtotales();
    // getAltaCarrito();
  }

  static void deleteCart() {
    _sharedPrefs!.remove('carrito');
  }

  static void calculaSubtotales() {
    arrProductos.map((prod) => prod.subtotal = prod.cantidad * prod.precio);
  }

  static void getAltaCarrito() {
    var altaCarritoLS = _sharedPrefs!.getString('altaCarrito');
    if (altaCarrito != null) {
      altaCarrito = json.decode(altaCarritoLS ?? '');
    }
  }

  static void setProductoCarrito(ProductCarritoModelo producto) async {
    // print(producto);
    // getProductosCarrito();
    bool encontrado = false;
    if (arrProductos.isNotEmpty) {
      for (var i = 0; i < arrProductos.length; i++) {
        if (arrProductos[i].productoID == producto.productoID &&
            arrProductos[i].talla == producto.talla) {
          arrProductos[i].cantidad =
              (arrProductos[i].cantidad + producto.cantidad >
                      producto.existencia)
                  ? producto.existencia
                  : (arrProductos[i].cantidad + producto.cantidad);
          arrProductos[i].existencia = producto.existencia;
          encontrado = true;
        }
      }
      // arrProductos.forEach((prod) => {
      //   if (prod.productoID == producto.productoID &&
      //       prod.talla == producto.talla) {
      //     prod.cantidad =
      //         (prod.cantidad + producto.cantidad > producto.existencia)
      //             ? producto.existencia
      //             : (prod.cantidad + producto.cantidad);
      //     prod.existencia = producto.existencia;
      //     encontrado = true;
      //   }
      // });
    }
    if (!encontrado) arrProductos.add(producto);
    // arrProductos = [];
    calculaSubtotales();
    _sharedPrefs!.setString(
      'carrito',
      cartItemModelToJson(arrProductos),
    );
    // var prods = json.encode(arrProductos);
    // var url = "$apiURL/carts/createCart.php?clienteID=$userID&productos=$prods";
    // print(url);
    // final respuesta = await http.get(Uri.parse(url));
    // print(respuesta.body);
  }

  static void setAltaCarrito(AltaCarrito alta) {
    getProductosCarrito();
    _sharedPrefs!.setString('altaCarrito', json.encode(alta));
  }

  static void setCantidadProductoCarrito(ProductCarritoModelo producto) {
    for (var i = 0; i < arrProductos.length; i++) {
      if (arrProductos[i].productoID == producto.productoID &&
          arrProductos[i].talla == producto.talla) {
        arrProductos[i].existencia = producto.existencia;
      }
    }
    calculaSubtotales();
    _sharedPrefs!.setString(
      'carrito',
      cartItemModelToJson(arrProductos),
    );
  }

  static void deleteProductoCarrito(ProductCarritoModelo producto) {
    getProductosCarrito();
    for (var i = 0; i < arrProductos.length; i++) {
      if (arrProductos[i].productoID == producto.productoID &&
          arrProductos[i].talla == producto.talla) {
        arrProductos.remove(arrProductos[i]);
      }
    }
    _sharedPrefs!.setString(
      'carrito',
      cartItemModelToJson(arrProductos),
    );
  }

  static void cleanCarrito() {
    arrProductos = [];
    _sharedPrefs!.setString(
      'carrito',
      cartItemModelToJson(arrProductos),
    );
  }

  static void cleanAltaCarrito() {
    _sharedPrefs!.setString('altaCarrito', json.encode('{}'));
  }
}