import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:product_store/Backend/Models/Control.dart';
import 'package:product_store/Backend/Services.dart';
import 'package:product_store/Pages/Home.dart';
import 'package:product_store/Pages/List.dart';
import 'package:product_store/Pages/RegisterProducts/RegisterProduct.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(RunApp());
}

class RunApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Services(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyTabs(),
      ),
    );
  }
}

class MyTabs extends StatefulWidget {
  @override
  _MyTabsState createState() => _MyTabsState();
}

class _MyTabsState extends State<MyTabs> with SingleTickerProviderStateMixin {
  TabController controller;

  @override
  void initState() {
    super.initState();
    controller = new TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('StoreClean'),
        backgroundColor: Colors.blue,
        bottom: new TabBar(
          tabs: <Widget>[
            new Tab(
              icon: new Icon(Icons.home),
            ),
            new Tab(
              icon: new Icon(Icons.list),
            ),
            new Tab(
              icon: new Icon(Icons.app_registration),
            )
          ],
          controller: controller,
        ),
      ),
      body: new TabBarView(
        children: [new Register(), new Home(), new List()],
        controller: controller,
      ),
    );
  }
}

class Otra extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final heroes = Provider.of<Control>(context);
    return Container(
        child: Scaffold(
      appBar: AppBar(
        title: Text(heroes.carlos),
      ),
      body: Center(
        child: Text('naranjas'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print(heroes.carlos);
          heroes.carlos = 'tanatos';
          heroes.optener = 'Tanatos';
          print(heroes.carlos);
        },
      ),
    ));
  }
}
