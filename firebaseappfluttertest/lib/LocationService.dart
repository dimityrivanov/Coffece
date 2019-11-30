import 'package:location/location.dart';

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
}
