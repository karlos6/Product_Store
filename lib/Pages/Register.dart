import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final formKey = GlobalKey<FormState>();
  String product;
  String cost;

  void _accion(BuildContext context) {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
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
                    validator: (value) {
                      String campo = '';
                      if (value.isEmpty) {
                        campo = 'Campo vacio';
                      }
                      return campo;
                    },
                  ),
                  TexNumber('Costo Unitario'),
                  TexNumber('Valor a vender'),
                  TexNumber('Cantidad'),
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

class TexNumber extends StatelessWidget {
  String label;
  String cost;

  TexNumber(this.label);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            labelText: this.label, icon: new Icon(Icons.monetization_on)),
        onSaved: (value) => this.cost = value,
        validator: (value) {
          String campo = '';
          if (value.isEmpty) {
            campo = 'Campo vacio';
          }
          return campo;
        });
  }
}
