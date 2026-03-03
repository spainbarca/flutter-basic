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
      body: Center(
        child: Container(
          width: 250,
          height: 250,
          color: Colors.black,
          child: Stack(
           // fit: StackFit.expand,
            alignment: Alignment.topRight,
            children: [
              Container(
                color: Colors.yellow,
                height: 200,
                width: 200,
              ),
              Container(
                color: Colors.blue,
                height: 150,
                width: 150,
              ),
              Container(
                  color: Colors.red,
                  height: 80,
                  width: 80,
              )
              /*Positioned(
                bottom: 0,
                left: 20,
                right: 20,
                child: Container(
                  color: Colors.red,
                  height: 80,
                  width: 80,
                ),
              )*/
            ],
          ),
        ),
      )
      
    );
  }
}
