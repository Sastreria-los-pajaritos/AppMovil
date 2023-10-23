import 'dart:convert';
import 'package:app_los_pajaritos/environment/environment.dart';
import 'package:app_los_pajaritos/models/home_models.dart';
import 'package:http/http.dart' as http;

class HomeServices {
  static Map<String, dynamic> usuarioLogueado = {};

  static Future<List<Category>> getCategories() async {
    var url = "$apiURL/products/getCategories.php";
    final respuesta = await http.get(Uri.parse(url));

    if (respuesta.statusCode == 200) {
      final respuestaJSON = json.decode(respuesta.body);
      final categories = Categories.fromJsonList(respuestaJSON);
      return categories;
    }
    return <Category>[];
  }

  static Future<List<Category>> getCategoriesPerSex(
      String type, int cant) async {
    var url = "$apiURL/products/getCategoriesPerSex.php?categorySex=$type";
    final respuesta = await http.get(Uri.parse(url));

    if (respuesta.statusCode == 200) {
      final respuestaJSON = json.decode(respuesta.body);
      final categoriesPerSex = Categories.fromJsonList(respuestaJSON);
      if (cant.isNaN) return categoriesPerSex;
      if (categoriesPerSex.length > cant) {
        categoriesPerSex.length = cant;
      }
      return categoriesPerSex;
    }
    return <Category>[];
  }

  static Future<List<Product>> getProducts(int cant) async {
    var url = "$apiURL/products/getProducts.php";
    final respuesta = await http.get(Uri.parse(url));

    if (respuesta.statusCode == 200) {
      final respuestaJSON = json.decode(respuesta.body);
      final products = Products.fromJsonList(respuestaJSON);
      if (products.length > cant) {
        products.length = cant;
      }
      return products;
    }
    return <Product>[];
  }

  static Future<List<Product>> getProductsPerCategory(String id) async {
    var url = "$apiURL/products/getProductsPerCategory.php?id=$id";
    final respuesta = await http.get(Uri.parse(url));

    if (respuesta.statusCode == 200) {
      final respuestaJSON = json.decode(respuesta.body);
      final products = Products.fromJsonList(respuestaJSON);
      return products;
    }
    return <Product>[];
  }

  static Future<Cliente> getUserLoguedData(String id) async {
    var url = "$apiURL/users/getUser.php?id=$id";
    final respuesta = await http.get(Uri.parse(url));
    final respuestaJSON = json.decode(respuesta.body);
    final cliente = Cliente.fromJson(respuestaJSON[0]);
    return cliente;
  }

  static Future<List> getMisCompras(String userID) async {
    var url = "$apiURL/sales/getSales.php?clienteID=$userID";
    final respuesta = await http.get(Uri.parse(url));

    if (respuesta.statusCode == 200) {
      final respuestaJSON = json.decode(respuesta.body);
      return respuestaJSON;
    }
    return [];
  }

  static Future<Product> getProduct(String productID) async {
    var url = "$apiURL/products/getProduct.php?id=$productID";
    final respuesta = await http.get(Uri.parse(url));
    var respuestaJSON = json.decode(respuesta.body);
    final product = Product.fromJson(respuestaJSON[0]);
    return product;
  }

  static Future<List<Cliente>> logIn(String username, String pwd) async {
    var url = "$apiURL/users/login.php?email=$username&password=$pwd";
    final respuesta = await http.get(Uri.parse(url));
    if (respuesta.statusCode == 200) {
      final respuestaJSON = json.decode(respuesta.body);
      final clientes = Clientes.fromJsonList(respuestaJSON);
      return clientes;
    }
    return [];
  }

  static Future<dynamic> singUp(String email) async {
    var url = "$apiURL/users/create.php?email=$email";
    final respuesta = await http.get(Uri.parse(url));
    if (respuesta.statusCode == 200) {
      return [
        {'status': "succesfully"}
      ];
    }
    return [];
  }

  static Future<List<Cliente>> singUpAll(
      String username, String pwd, String id) async {
    var url = "$apiURL/users/singupAll.php?name=$username&password=$pwd&id=$id";
    final respuesta = await http.get(Uri.parse(url));
    if (respuesta.statusCode == 200) {
      final respuestaJSON = json.decode(respuesta.body);
      final clientes = Clientes.fromJsonList(respuestaJSON);
      return clientes;
    }
    return [];
  }

  static Future<List<Cliente>> validaEmail(String email) async {
    var url = "$apiURL/users/read_single.php?email=$email";
    final respuesta = await http.get(Uri.parse(url));
    if (respuesta.statusCode == 200) {
      final respuestaJSON = json.decode(respuesta.body);
      final clientes = Clientes.fromJsonList(respuestaJSON);
      return clientes;
    }
    return [];
  }

  static Future<dynamic> sendValidateEmail(String email, String id) async {
    var url = "$urlAPIEmail/send-validate-email";
    final respuesta = await http.post(Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{'email': email, 'id': id}));
    if (respuesta.statusCode == 200) {
      final respuestaJSON = json.decode(respuesta.body);
      return respuestaJSON;
    }
    return [];
  }

  static Future<List<Direccion>> getMisDomicilios(String userID) async {
    var url = "$apiURL/sales/getDirecciones.php?clienteID=$userID";
    final respuesta = await http.get(Uri.parse(url));

    if (respuesta.statusCode == 200) {
      final respuestaJSON = json.decode(respuesta.body);
      final direcciones = Direcciones.fromJsonList(respuestaJSON);
      return direcciones;
    }
    return [];
  }
}