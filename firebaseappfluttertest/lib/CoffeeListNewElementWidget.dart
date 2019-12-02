import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class CoffeeListNewElementWidget extends StatelessWidget {
  final coffeePlace;
  final distance;

  CoffeeListNewElementWidget({this.coffeePlace, this.distance});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Center(child: CircularProgressIndicator()),
        Positioned(
          top: 0,
          bottom: 0,
          child: FadeInImage.memoryNetwork(
            placeholder: kTransparentImage,
            image: coffeePlace.coffee_image_url,
            fit: BoxFit.contain,
          ),
        ),
        Positioned(
          bottom: 40,
          left: 20,
          child: SafeArea(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                coffeePlace.coffee_name,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              ),
              Text(
                "$distance KM",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                    fontSize: 20),
              ),
            ],
          )),
        ),
      ],
    );
  }
}
