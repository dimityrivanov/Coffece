import 'package:firebaseappfluttertest/widgets/WorkingTimeWidget.dart';
import 'package:flutter/material.dart';

class CoffeeListElement extends StatelessWidget {
  final coffeePlace;
  final distance;

  CoffeeListElement({this.coffeePlace, this.distance});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0),
      child: Container(
        height: 100,
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
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                    child: Hero(
                      tag: coffeePlace.coffee_name,
                      child: Image.network(
                        coffeePlace.coffee_image_url,
                        fit: BoxFit.fitHeight,
                        width: 100,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 4.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    child: Text(
                      coffeePlace.coffee_name,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    width: 150,
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                  ),
                  Row(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Image.asset(
                            "assets/car.png",
                            width: 10,
                            height: 10,
                          ),
                          Text(
                            " $distance km",
                            style: TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 12),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20.0),
                      ),
                      WorkingTimeWidget(isOpened: false),
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
