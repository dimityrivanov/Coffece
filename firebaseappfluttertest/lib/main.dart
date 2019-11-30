import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaseappfluttertest/CoffeeModel.dart';
import 'package:firebaseappfluttertest/LocationService.dart';
import 'package:firebaseappfluttertest/Locator.dart';
import 'package:flutter/material.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Coffice'),
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
  final db = Firestore.instance;
  var coffeePlaces = [];

  @override
  void initState() {
    super.initState();

    var location = locator<LocationService>().getLocation();

    location.then((userLocation) {
      var mitko = 5;
    });

    db.collection("Sofia").snapshots().listen((snapshot) {
      snapshot.documents.forEach((coffeePlace) {
        final coffeeModel = CoffeeModel.fromJson(coffeePlace.data);
        setState(() {
          coffeePlaces.add(coffeeModel);
        });
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
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
      backgroundColor: Color(0xFFF4F6F7),
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: ListView.builder(
          itemCount: coffeePlaces.length,
          itemBuilder: (context, position) {
            return Padding(
              padding:
                  const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
              child: Container(
                height: 120,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xEDEDEDED),
                        blurRadius: 1.5,
                        spreadRadius: 1.5,
                      )
                    ],
                    color: const Color(0xFFFCFDFD),
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10.0),
                                bottomLeft: Radius.circular(10.0)),
                            child: Image.network(
                              coffeePlaces[position].coffee_image_url,
                              fit: BoxFit.fitHeight,
                              width: 120,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            child: Text(
                              coffeePlaces[position].coffee_name,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            width: 150,
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 8.0),
                          ),
                          Row(
                            children: <Widget>[
                              Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    "Затворено",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.0)),
                                  color: Colors.red,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 20.0),
                              ),
                              Text(
                                "3.4 Miles",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    Icon(
                      Icons.audiotrack,
                      color: Colors.green,
                      size: 30.0,
                    ),
                  ],
                ),
              ),
            );
          }), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
