import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final formKey = GlobalKey<FormState>();
  String product;
  String netCost;
  String grossCost;
  String quantity;

  void _accion(BuildContext context) {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      print(product);
      print(netCost);
      print(grossCost);
      print(quantity);
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
    );
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
                onPressed: () {},
              ),
              TextButton(
                child: Text('Guardar'),
                onPressed: () {
                  _accion(context);
                },
              ),
            ],
          );
        });
  }
}
