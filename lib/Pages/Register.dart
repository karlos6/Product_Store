import 'package:flutter/material.dart';
import 'package:product_store/Backend/Services.dart';
import 'package:product_store/Backend/Models/Product.dart';
import 'package:product_store/Pages/ListWidgets.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  var dataBase;

  Future<List<Product>> products;

  final formKey = GlobalKey<FormState>();
  String product;
  String netCost;
  String grossCost;
  String quantity;
  int userID;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dataBase = Services();
    refreshList();
  }

  refreshList() {
    setState(() {
      products = dataBase.getProducts();
    });
  }

  void _accion(BuildContext context) {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      Product pro = Product(
          id: null,
          nombre: product,
          valorBruto: int.parse(grossCost),
          valorNeto: int.parse(netCost));
      dataBase.save(pro);
      refreshList();
    }
  }

  @override
  Widget build(BuildContext context) {
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
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, posicion) {
                  return Padding(
                    padding: EdgeInsets.only(right: 30, left: 30, top: 5),
                    child: MyListCard(
                        snapshot.data[posicion].nombre,
                        snapshot.data[posicion].valorNeto.toString(),
                        snapshot.data[posicion].valorBruto.toString()),
                  );
                },
              );
            }
            if (snapshot.data == null || snapshot.data.length == 0) {
              return Text('NO DATA FOUND');
            }
            return CircularProgressIndicator();
          },
        ));
  }

  listaDeCards(List<Product> pro) {
    return pro
        .map((e) => MyListCard(
            e.nombre, e.valorNeto.toString(), e.valorBruto.toString()))
        .toList();
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
                      // ignore: missing_return
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
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: Text('Guardar'),
                onPressed: () {
                  _accion(context);
                  Navigator.pop(context);
                  //refreshList();
                },
              ),
            ],
          );
        });
  }
}
