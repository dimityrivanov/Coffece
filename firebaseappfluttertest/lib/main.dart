import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaseappfluttertest/CoffeeModel.dart';
import 'package:firebaseappfluttertest/LocationService.dart';
import 'package:firebaseappfluttertest/Locator.dart';
import 'package:firebaseappfluttertest/UserLocation.dart';
import 'package:firebaseappfluttertest/widgets/CoffeListElementWidget.dart';
import 'package:firebaseappfluttertest/widgets/WorkingTimeWidget.dart';
import 'package:flutter/material.dart';

void main() {
  setupLocator();
  runApp(CoffeeList());
}

class CoffeeList extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coffice',
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
      home: CoffeeListPage(title: 'Coffice'),
    );
  }
}

class CoffeeListPage extends StatefulWidget {
  CoffeeListPage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _CoffeeListPageState createState() => _CoffeeListPageState();
}

class _CoffeeListPageState extends State<CoffeeListPage> {
  final db = Firestore.instance;
  List<CoffeeModel> coffeePlaces = [];

  UserLocation userLocation;
  var locationService = locator<LocationService>();

  @override
  void initState() {
    super.initState();

    locationService.getLocation().then((userLocation) {
      setState(() {
        this.userLocation = userLocation;
      });
    });

    db.collection("Sofia").snapshots().listen((snapshot) {
      snapshot.documents.forEach((coffeePlace) {
        final coffeeModel = CoffeeModel.fromJson(coffeePlace.data);
        setState(() {
          coffeePlaces.addAll([coffeeModel]);
          //TODO: Fix sort
          coffeePlaces.sort((firstCoffee, secondCoffee) {
//            var firstCoffeLocation = new UserLocation(
//              latitude: firstCoffee.lat,
//              longitude: firstCoffee.long,
//            );
//
//            var secondCoffeLocation = new UserLocation(
//              latitude: secondCoffee.lat,
//              longitude: secondCoffee.long,
//            );
            
            return firstCoffee.coffee_name.compareTo(secondCoffee.coffee_name);
          });
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
      body: (userLocation == null)
          ? Center(child: Text("Fetching Location..."))
          : ListView.builder(
              itemCount: coffeePlaces.length,
              itemBuilder: (context, position) {
                final coffeePlace = coffeePlaces[position];
                final coffeeDistance = locationService.calculateDistance(
                    coffeePlace.lat,
                    coffeePlace.long,
                    userLocation.latitude,
                    userLocation.longitude);

                return CoffeeListElement(
                  coffeePlace: coffeePlace,
                  distance: coffeeDistance,
                );
              }), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
