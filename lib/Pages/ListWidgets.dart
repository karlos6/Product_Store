import 'package:flutter/material.dart';
import 'package:product_store/Backend/Models/Product.dart';
import 'package:product_store/Backend/Services.dart';

class MyListCard extends StatefulWidget {
  String product;
  String netCost;
  String grossCost;
  MyListCard(this.product, this.netCost, this.grossCost);

  @override
  _MyListCardState createState() => _MyListCardState();
}

class _MyListCardState extends State<MyListCard> {
  @override
  Widget build(BuildContext context) {
    return Center(
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
                    widget.grossCost,
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
                  onPressed: () {},
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
    );
  }
}
