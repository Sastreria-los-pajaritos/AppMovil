import 'package:app_los_pajaritos/components/spinner_widget.dart';
import 'package:app_los_pajaritos/screens/product_detail_screen.dart';
import 'package:app_los_pajaritos/services/home_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final numberFormat = NumberFormat.currency(locale: 'es_MX', symbol: "\$");
Color bgColor = Colors.red.shade200;

class ProductsCategoryScreen extends StatelessWidget {
  final String id;
  final String categoryName;
  const ProductsCategoryScreen(
      {super.key, required this.id, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.white60,
          title: Text(
            categoryName,
            style: const TextStyle(color: Colors.white),
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              color: bgColor,
            ),
          ),
        ),
        body: FutureBuilder(
            future: HomeServices.getCategories(),
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              if (snapshot.hasData) {
                return ListView(
                  children: [
                    Column(children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Text(
                          'Produtos de la categoría',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      principalesProductosWidget(id),
                    ]),
                  ],
                );
              } else {
                return const SpinnerWidget();
              }
            }));
  }
}

Widget principalesProductosWidget(String id) => FutureBuilder(
      future: HomeServices.getProductsPerCategory(id),
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