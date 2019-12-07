import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsScreen extends StatelessWidget {
  final coffeePlace;

  DetailsScreen({this.coffeePlace});

  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF4F6F7),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Hero(
                  tag: coffeePlace.coffee_name,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: ClipRRect(
                      clipBehavior: Clip.hardEdge,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        bottomLeft: Radius.circular(20.0),
                      ),
                      child: Image.network(
                        coffeePlace.coffee_image_url,
                        fit: BoxFit.fitHeight,
                        height: 350,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 10.0),
              child: Text(
                coffeePlace.coffee_name,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 10.0),
              child: SizedBox(
                  width: 300,
                  child: Text(
                    "A pumpkin is a cultivar of a squash plant, most commonly of Cucurbita pepo, that is round, with smooth, slightly ribbed skin, and most often deep yellow to orange in coloration. The thick shell contains the seeds and pulp.",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Color(0x7F000000)),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 20.0),
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          color: Colors.greenAccent),
                      child: Center(
                        child: Text("Loc"),
                      ),
                    ),
                    behavior: HitTestBehavior.translucent,
                    onTap: () => _launchURL(
                        "https://www.google.com/maps/search/?api=1&query=${coffeePlace.lat},${coffeePlace.long}"),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          color: Colors.greenAccent),
                      child: Center(
                        child: Text("Phone"),
                      ),
                    ),
                    behavior: HitTestBehavior.translucent,
                    onTap: () => _launchURL("tel:${coffeePlace.coffee_phone}"),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
