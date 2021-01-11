import 'package:flutter/material.dart';
import 'package:product_store/Backend/Services.dart';
import 'package:provider/provider.dart';
import 'DetailsComponent.dart';

class MyCard extends StatefulWidget {
  int id;
  String product;
  String netCost;
  String grossCost;
  String quantity;

  MyCard(this.product, this.netCost, this.grossCost, this.id, this.quantity);

  @override
  _MyListCardState createState() => _MyListCardState();
}

class _MyListCardState extends State<MyCard> {
  _verificacion(BuildContext context) {
    final dataB = Provider.of<Services>(context, listen: false);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Verificación'),
            content: Text(
                'Se eliminara toda la informacion relacionada al producto. \n\n ¿Desea continuar?'),
            actions: <Widget>[
              TextButton(
                child: Text('Cancelar'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: Text('Aceptar'),
                onPressed: () {
                  dataB.delete(widget.id);
                  Navigator.pop(context);
                },
              ),
            ],
            elevation: 24.0,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Center(
        child: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text(widget.product,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(
                  'Costo de compra: ' +
                      widget.netCost +
                      '\n' +
                      'Costo de venta: ' +
                      widget.grossCost +
                      '\n' +
                      'Cantidad: ' +
                      widget.quantity,
                  textAlign: TextAlign.center,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextButton(
                    child: const Text('Vender'),
                    onPressed: () {/* ... */},
                  ),
                  const SizedBox(width: 8),
                  TextButton(
                    child: const Text('Comprar'),
                    onPressed: () {/* ... */},
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _verificacion(context);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {},
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Detail()));
      },
    );
  }
}
