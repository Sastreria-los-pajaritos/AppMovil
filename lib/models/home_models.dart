import 'dart:convert';
import 'package:app_los_pajaritos/environment/environment.dart';
import 'package:flutter/material.dart';

class Category {
  String id;
  String name;
  String description;
  String categorySex;
  String imageUrl;

  Category({
    required this.id,
    required this.name,
    required this.description,
    required this.categorySex,
    required this.imageUrl,
  });

  static Category fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['_id']['\$oid'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      categorySex: json['categorySex'] as String,
      imageUrl: json['imageUrl'] as String,
    );
  }

  String getImage() {
    return "$urlImages$imageUrl";
  }
}

class Categories {
  Categories();

  static List<Category> fromJsonList(List<dynamic> jsonList) {
    List<Category> arrCategories = [];
    if (jsonList.isNotEmpty) {
      for (var cat in jsonList) {
        final category = Category.fromJson(cat);
        arrCategories.add(category);
      }
    }
    return arrCategories;
  }
}

class Inventario {
  String talla;
  int inventario;

  Inventario({
    required this.talla,
    required this.inventario,
  });

  static Inventario fromJson(Map<String, dynamic> json) {
    return Inventario(
      talla: json['talla'] as String,
      inventario: json['inventario'] as int,
    );
  }
}

class Inventarios {
  Inventarios();

  static List<Inventario> fromJsonList(List<dynamic> jsonList) {
    List<Inventario> arrInventario = [];
    if (jsonList.isNotEmpty) {
      for (var inv in jsonList) {
        final inventario = Inventario.fromJson(inv);
        arrInventario.add(inventario);
      }
    }
    return arrInventario;
  }
}

class Product {
  String id;
  String categoryID;
  String title;
  String description;
  String categorySex;
  String imageUrl;
  List<Inventario> inventario;
  int precio;

  Product({
    required this.id,
    required this.categoryID,
    required this.title,
    required this.description,
    required this.categorySex,
    required this.imageUrl,
    required this.inventario,
    required this.precio,
  });

  static Product fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id']['\$oid'] as String,
      categoryID:
          json['categoryID'] != null ? json['categoryID'] as String : '',
      title: json['title'] != null ? json['title'] as String : '',
      description:
          json['description'] != null ? json['description'] as String : '',
      categorySex:
          json['categorySex'] != null ? json['categorySex'] as String : '',
      imageUrl: json['imageUrl'] != null ? json['imageUrl'] as String : '',
      inventario: Inventarios.fromJsonList(json['inventario'] ?? []),
      precio: json['precio'] != null ? json['precio'] as int : 0,
    );
  }

  String getImage() {
    return "$urlImages$imageUrl";
  }
}

class Products {
  Products();

  static List<Product> fromJsonList(List<dynamic> jsonList) {
    List<Product> arrProducts = [];
    if (jsonList.isNotEmpty) {
      for (var prod in jsonList) {
        final producto = Product.fromJson(prod);
        arrProducts.add(producto);
      }
    }
    return arrProducts;
  }
}

class Cliente {
  String id;
  String email;
  String name;
  String password;
  bool isAdmin;

  Cliente({
    required this.id,
    required this.email,
    required this.name,
    required this.password,
    required this.isAdmin,
  });

  static Cliente fromJson(Map<String, dynamic> json) {
    return Cliente(
      id: json['_id']['\$oid'] as String,
      email: json['email'] as String,
      name: json['name'] != null ? json['name'] as String : '',
      password: json['password'] != null ? json['password'] as String : '',
      isAdmin: json['isAdmin'] != null ? json['isAdmin'] as bool : false,
    );
  }
}

class Clientes {
  Clientes();

  static List<Cliente> fromJsonList(List<dynamic> jsonList) {
    List<Cliente> arrClientes = [];
    if (jsonList.isNotEmpty) {
      for (var c in jsonList) {
        final cliente = Cliente.fromJson(c);
        arrClientes.add(cliente);
      }
    }
    return arrClientes;
  }
}

class Direccion {
  String id;
  String clienteID;
  String nombre;
  String estado;
  String municipio;
  String colonia;
  String calle;
  String telefono;
  String indicaciones;

  Direccion({
    required this.id,
    required this.clienteID,
    required this.nombre,
    required this.estado,
    required this.municipio,
    required this.colonia,
    required this.calle,
    required this.telefono,
    required this.indicaciones,
  });

  static Direccion fromJson(Map<String, dynamic> json) {
    return Direccion(
      id: json['_id']['\$oid'] as String,
      clienteID: json['clienteID'] as String,
      nombre: json['nombre'] as String,
      estado: json['estado'] as String,
      municipio: json['municipio'] as String,
      colonia: json['colonia'] as String,
      calle: json['calle'] as String,
      telefono: json['telefono'] as String,
      indicaciones: json['indicaciones'] as String,
    );
  }
}

class Direcciones {
  Direcciones();

  static List<Direccion> fromJsonList(List<dynamic> jsonList) {
    List<Direccion> arrDirecciones = [];
    if (jsonList.isNotEmpty) {
      for (var c in jsonList) {
        final direccion = Direccion.fromJson(c);
        arrDirecciones.add(direccion);
      }
    }
    return arrDirecciones;
  }
}

class AltaCarrito {
  String id;
  DateTime? fechaVenta;
  int total;
  List<Product>? productos;
  String clienteID;
  String nombreCliente;
  String emailCliente;
  Direccion? direccionEntrega;

  AltaCarrito({
    this.id = '',
    this.fechaVenta,
    this.total = 0,
    this.productos,
    this.clienteID = '',
    this.nombreCliente = '',
    this.emailCliente = '',
    this.direccionEntrega,
  });

  static AltaCarrito fromJson(Map<String, dynamic> json) {
    return AltaCarrito(
      id: json['_id']['\$oid'] as String,
      fechaVenta: json['fechaVenta'] != null
          ? json['fechaVenta'] as DateTime
          : DateTime.now(),
      total: json['total'] != null ? json['total'] as int : 0,
      productos: Products.fromJsonList(json['productos'] ?? []),
      clienteID: json['clienteID'] != null ? json['clienteID'] as String : '',
      nombreCliente:
          json['nombreCliente'] != null ? json['nombreCliente'] as String : '',
      emailCliente:
          json['emailCliente'] != null ? json['emailCliente'] as String : '',
      direccionEntrega: json['direccionEntrega'] as Direccion,
    );
  }
}

class ProductCarritoModelo {
  String categoryID;
  String productoID;
  String category;
  String title;
  String description;
  String categorySex;
  String imageUrl;
  String talla;
  int cantidad;
  int existencia;
  int precio;
  int subtotal;

  ProductCarritoModelo({
    required this.categoryID,
    required this.productoID,
    required this.category,
    required this.title,
    required this.description,
    required this.categorySex,
    required this.imageUrl,
    required this.talla,
    required this.cantidad,
    required this.existencia,
    required this.precio,
    required this.subtotal,
  });

  static ProductCarritoModelo fromJson(
      Product data, String categoria, Inventario objTalla) {
    return ProductCarritoModelo(
        categoryID: data.categoryID,
        productoID: data.id,
        category: categoria,
        title: data.title,
        description: data.description,
        categorySex: data.categorySex,
        imageUrl: data.imageUrl,
        talla: objTalla.talla,
        cantidad: 0,
        existencia: objTalla.inventario,
        precio: data.precio,
        subtotal: 0);
  }

  static ProductCarritoModelo paseJson(Map<String, dynamic> data) {
    return ProductCarritoModelo(
        categoryID: data['categoryID'],
        productoID: data['productoID'],
        category: data['category'],
        title: data['title'],
        description: data['description'],
        categorySex: data['categorySex'],
        imageUrl: data['imageUrl'],
        talla: data['talla'],
        cantidad: data['cantidad'],
        existencia: data['existencia'],
        precio: data['precio'],
        subtotal: data['subtotal']);
  }

  String getImage() {
    return "$urlImages$imageUrl";
  }

  Map<String, dynamic> toJson(ProductCarritoModelo prod) => {
        "categoryID": prod.categoryID,
        "productoID": prod.productoID,
        "category": prod.category,
        "title": prod.title,
        "description": prod.description,
        "categorySex": prod.categorySex,
        "imageUrl": prod.imageUrl,
        "talla": prod.talla,
        "cantidad": prod.cantidad,
        "existencia": prod.existencia,
        "precio": prod.precio,
        "subtotal": prod.subtotal
      };
}

String cartItemModelToJson(List<ProductCarritoModelo> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson(x))));

class ProductsCarritoModelo {
  ProductsCarritoModelo();

  static List<ProductCarritoModelo> fromJsonList(List<dynamic> jsonList) {
    List<ProductCarritoModelo> arrProducts = [];
    if (jsonList.isNotEmpty) {
      for (var prod in jsonList) {
        final producto = ProductCarritoModelo.paseJson(prod);
        arrProducts.add(producto);
      }
    }
    return arrProducts;
  }
}

class BasicForm {
  TextEditingController? _name;
  BasicForm(String cantidad) {
    _name = TextEditingController(text: cantidad);
  }
  TextEditingController get name => _name!;
}