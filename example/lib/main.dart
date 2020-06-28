import 'package:flutter/material.dart';
import 'package:tellam/tellam.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Tellam.initialize(
    secretKey: "",
    databaseUrl: "https://tellam-6ee8e.firebaseio.com/",
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tellam Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Tellam Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Text("Tellam Inc."),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Tellam.show(context);
        },
        tooltip: 'Help',
        child: Icon(Icons.chat),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
