import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(MyApp());
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
  List<String> names = ['Ana','Jorge','Alba'];
  List<String> cities = ['Cusco','Brasilia','Londres'];
  List<int> balance = [2300, 5400, 1700];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView.builder(
          itemCount: names.length,
          itemBuilder: (context, index){
            return ListTile(
              leading: CircleAvatar(child: Text(names[index]),),
              title: Text(names[index]),
              subtitle: Text(cities[index]),
              trailing: Text(balance[index].toString()),
            );
          }
          )
      ),
    );
  }
}
