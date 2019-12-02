import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  final coffeePlace;

  DetailsScreen({this.coffeePlace});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF4F6F7),
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(coffeePlace.coffee_name),
        ),
        body: Column(
          children: <Widget>[
            Hero(
              tag: coffeePlace.coffee_name,
              child: Image.network(
                coffeePlace.coffee_image_url,
                fit: BoxFit.fitWidth,
              ),
            ),
            Text("123"),
            Text(coffeePlace.coffee_description),
          ],
        ));
  }
}
