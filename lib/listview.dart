import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          itemExtent: 90.0,
          scrollDirection: Axis.horizontal,
          children: [
            ListTile(
              leading: Icon(Icons.map, size: 50,),
              title: Text("Rutas"),
              subtitle: Text("Km. Recorridos"),
              trailing: Icon(Icons.add),
              onTap: () {},
              tileColor: Colors.blue.shade50,
            ),
            ListTile(
              leading: Icon(Icons.directions_car, size: 50,),
              title: Text("Vehículos"),
              subtitle: Text("Modelo de Auto"),
              trailing: Icon(Icons.add),
            ),
            ListTile(
              leading: Icon(Icons.account_box, size: 50,),
              title: Text("Choferes"),
              subtitle: Text("Datos del conductor"),
              trailing: Icon(Icons.add),
            )
          ],
        )
      ),
    );
  }
}
