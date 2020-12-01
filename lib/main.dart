import 'package:flutter/material.dart';
import 'package:product_store/Pages/Home.dart';
import 'package:product_store/Pages/List.dart';
import 'package:product_store/Pages/Register.dart';

void main() {
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyTabs(),
  ));
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
        children: [new Home(), new List(), new Register()],
        controller: controller,
      ),
    );
  }
}
