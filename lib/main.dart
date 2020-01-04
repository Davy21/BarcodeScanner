import 'package:barcode_scanner_flutter/dialog.dart';
import 'package:barcode_scanner_flutter/dialogAction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gofo Barcode Scanner',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: MaterialColor(Colors.black.value, {
          50:Color.fromRGBO(0,0,0, .1),
          100:Color.fromRGBO(0,0,0, .2),
          200:Color.fromRGBO(0,0,0, .3),
          300:Color.fromRGBO(0,0,0, .4),
          400:Color.fromRGBO(0,0,0, .5),
          500:Color.fromRGBO(0,0,0, .6),
          600:Color.fromRGBO(0,0,0, .7),
          700:Color.fromRGBO(0,0,0, .8),
          800:Color.fromRGBO(0,0,0, .9),
          900:Color.fromRGBO(0,0,0, 1),
        }),
      ),
      home: MyHomePage(title: 'Gofo Barcode Scanner'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String value;

  @override
  void initState() {
    super.initState();
    value = "Welcome to Gofo";
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _scanBarcode());
  }

  Future<void> _scanBarcode() async {
    value = await FlutterBarcodeScanner.scanBarcode(
        "#000FFF", "Cancel", false, ScanMode.DEFAULT);
    if (value == "-1") {
      value = "No barcode is found";
      DialogAction action = await confirmationDialog(context, "No barcode is found. Do you want to retry ?");
      print(action);
      if(action == DialogAction.retry){
        _scanBarcode();
      }
    }

    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      value = value;
      //_counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InkWell(
              onTap: () async {
                if(await canLaunch(value)){
                  await launch(value);
                }
                else{
                  alertDialog(context,"This is not a valid URL.");
                }
              },
              child: Text(
                '$value',
                style: Theme.of(context).textTheme.display1,
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: _scanBarcode,
        tooltip: 'Scan',
        child: Icon(Icons.scanner),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
