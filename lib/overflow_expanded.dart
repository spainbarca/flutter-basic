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
      appBar: AppBar(title: Text("Widgets Row y Column"),backgroundColor: Colors.amber, centerTitle: true,),
      body: Container(
        //color: Colors.red,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Image(image: NetworkImage("https://www.zakkaconcept.com/cdn/shop/articles/King_Gnu_s_New_Song_AIZO_Chosen_as_Opening_Theme_2.jpg"),
                  width: 200,)
                ),
                Expanded(flex: 2,
                  child: Image(image: NetworkImage("https://www.zakkaconcept.com/cdn/shop/articles/King_Gnu_s_New_Song_AIZO_Chosen_as_Opening_Theme_2.jpg"),
                  width: 200,)
                ),
                Expanded(
                  child: Image(image: NetworkImage("https://www.zakkaconcept.com/cdn/shop/articles/King_Gnu_s_New_Song_AIZO_Chosen_as_Opening_Theme_2.jpg"),
                  width: 200,)
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.account_balance, size: 40,)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Icon(Icons.android, size: 40),
                    Text("Android")
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.apple, size: 40),
                    Text("Apple")
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.paypal, size: 40),
                    Text("Paypal")
                  ],
                ),
              ],
            ),
          ]
        )
      ),
    );
  }
}
