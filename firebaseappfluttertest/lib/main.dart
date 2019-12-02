import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaseappfluttertest/CoffeeListNewElementWidget.dart';
import 'package:firebaseappfluttertest/CoffeeModel.dart';
import 'package:firebaseappfluttertest/Details.dart';
import 'package:firebaseappfluttertest/LocationService.dart';
import 'package:firebaseappfluttertest/Locator.dart';
import 'package:firebaseappfluttertest/UserLocation.dart';
import 'package:firebaseappfluttertest/extents_page_view.dart';
import 'package:firebaseappfluttertest/widgets/CoffeListElementWidget.dart';
import 'package:flare_flutter/flare_actor.dart';
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
  var coffeePlaces = [];

  UserLocation userLocation;
  var locationService = locator<LocationService>();
  final _controller = PageController(viewportFraction: 1.0);

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
          coffeePlaces.add(coffeeModel);
          //TODO: Fix sort
//          coffeePlaces.sort((firstCoffee, secondCoffee) {
//            return firstCoffee.coffee_name.comparedTo(secondCoffee.coffee_name);
//          });
        });
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _coffeeUI() {
    return ListView.builder(
      itemCount: coffeePlaces.length,
      itemBuilder: (BuildContext context, int index) {
        return _getCoffeeElement(coffeePlaces[index]);
      },
    );
  }

  Widget _getCoffeeAnimation() {
    return Center(
        child: FlareActor(
      "assets/coffee.flr",
      alignment: Alignment.center,
      fit: BoxFit.contain,
      animation: "heat",
    ));
  }

  Widget _getCoffeeElement(coffeeShop) {
    final coffeeDistance = locationService.calculateDistance(coffeeShop.lat,
        coffeeShop.long, userLocation.latitude, userLocation.longitude);

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailsScreen(
                      coffeePlace: coffeeShop,
                    )))
      },
      child: CoffeeListElement(
        coffeePlace: coffeeShop,
        distance: coffeeDistance,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (userLocation == null)
          ? Center(
              child: CircularProgressIndicator(
              backgroundColor: Colors.red,
            ))
          : _coffeeUI(), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
