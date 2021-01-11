import 'package:flutter/material.dart';
import 'package:product_store/Backend/Services.dart';
import 'package:product_store/Backend/Models/Product.dart';
import 'package:product_store/Pages/RegisterProducts/CardComponent.dart';
import 'package:provider/provider.dart';

class Register extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  String product;
  String netCost;
  String grossCost;
  String quantity;
  int userID;

  void _accion(BuildContext context) {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      Product pro = Product(
          id: null,
          nombre: product.toUpperCase(),
          valorBruto: int.parse(grossCost),
          valorNeto: int.parse(netCost));

      final dataB = Provider.of<Services>(context, listen: false);
      dataB.save(pro, int.parse(quantity));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final dataB = Provider.of<Services>(context);
    Future<List<Product>> products = dataB.getProducts();

    return new Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _insertProduct(context);
          },
          child: Icon(Icons.add),
        ),
        body: FutureBuilder(
          future: products,
          builder: (context, snapshot) {
            if (snapshot.data == null || snapshot.data.length == 0) {
              return Padding(
                padding: EdgeInsets.only(top: 15),
                child: Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      'NO DATA FOUND',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    )),
              );
            } else if (snapshot.data != null) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, posicion) {
                  return Padding(
                    padding: EdgeInsets.only(right: 30, left: 30, top: 5),
                    child: MyCard(
                        snapshot.data[posicion].nombre,
                        snapshot.data[posicion].valorNeto.toString(),
                        snapshot.data[posicion].valorBruto.toString(),
                        snapshot.data[posicion].id,
                        snapshot.data[posicion].cantidad.toString()),
                  );
                },
              );
            }

            return CircularProgressIndicator();
          },
        ));
  }

  _insertProduct(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Ingrese el producto'),
            content: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Producto',
                        icon: new Icon(Icons.receipt),
                      ),
                      onSaved: (value) => product = value,
                      validator: (value) =>
                          value.isEmpty ? 'Campo Vacio' : null),
                  TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: 'Costo Unitario',
                          icon: new Icon(Icons.monetization_on)),
                      onSaved: (value) => netCost = value,
                      validator: (value) =>
                          value.isEmpty ? 'Campo Vacio' : null),
                  TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: 'Valor a vender',
                          icon: new Icon(Icons.monetization_on)),
                      onSaved: (value) => grossCost = value,
                      validator: (value) =>
                          value.isEmpty ? 'Campo Vacio' : null),
                  TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: 'Cantidad',
                          icon: new Icon(Icons.monetization_on)),
                      onSaved: (value) => quantity = value,
                      validator: (value) =>
                          value.isEmpty ? 'Campo Vacio' : null)
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Cancelar'),
                onPressed: () {
                  final dataB = Provider.of<Services>(context, listen: false);
                  dataB.quantityProduct(1);
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: Text('Guardar'),
                onPressed: () {
                  _accion(context);
                },
              ),
            ],
            elevation: 24.5,
          );
        });
  }
}
