import 'package:location/location.dart';
import 'dart:math';
import 'UserLocation.dart';

class LocationService {
  var location = Location();

  UserLocation _currentLocation;

  Future<UserLocation> getLocation() async {
    try {
      var userLocation = await location.getLocation();

      _currentLocation = UserLocation(
        latitude: userLocation.latitude,
        longitude: userLocation.longitude,
      );
    } on Exception catch (e) {
      print('Could not get location: ${e.toString()}');
    }

    return _currentLocation;
  }

  int calculateDistance(lat1, lon1, lat2, lon2) {
    var radlat1 = pi * lat1 / 180;
    var radlat2 = pi * lat2 / 180;
//    var radlon1 = pi * lon1 / 180;
//    var radlon2 = pi * lon2 / 180;
    var theta = lon1 - lon2;
    var radtheta = pi * theta / 180;
    var dist = sin(radlat1) * sin(radlat2) +
        cos(radlat1) * cos(radlat2) * cos(radtheta);
    dist = acos(dist);
    dist = dist * 180 / pi;
    dist = dist * 60 * 1.1515;

    dist = dist * 1.609344;
    return dist.round().toInt();
  }
}
