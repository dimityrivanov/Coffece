import 'package:firebaseappfluttertest/widgets/WorkingTimeWidget.dart';
import 'package:flutter/material.dart';

class CoffeeListElement extends StatelessWidget {
  final coffeePlace;
  final distance;

  CoffeeListElement({this.coffeePlace, this.distance});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
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
                      coffeePlace.coffee_image_url,
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
                      coffeePlace.coffee_name,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    width: 150,
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                  ),
                  Row(
                    children: <Widget>[
                      WorkingTimeWidget(isOpened: false),
                      Padding(
                        padding: EdgeInsets.only(left: 20.0),
                      ),
                      Text(
                        "$distance KM",
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
  }
}
