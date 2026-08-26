import '../helpers/helper_functions.dart';

class LocationModel {
  final String name;
  final String region;
  final String country;
  final double lat;
  final double lon;
  final String tzId;
  final int localtimeEpoch;
  final String localtime;

  LocationModel({
    required this.name,
    required this.region,
    required this.country,
    required this.lat,
    required this.lon,
    required this.tzId,
    required this.localtimeEpoch,
    required this.localtime,
  });

  factory LocationModel.fromJson(dynamic json) {
    if (json == null || json is! Map<String, dynamic>) {
      return LocationModel.empty();
    }
    return LocationModel(
      name: HelperFunctions.toStrings(json['name']),
      region: HelperFunctions.toStrings(json['region']),
      country: HelperFunctions.toStrings(json['country']),
      lat: HelperFunctions.toDouble(json['lat']),
      lon: HelperFunctions.toDouble(json['lon']),
      tzId: HelperFunctions.toStrings(json['tz_id']),
      localtimeEpoch: HelperFunctions.toInt(json['localtime_epoch']),
      localtime: HelperFunctions.toStrings(json['localtime']),
    );
  }

  factory LocationModel.empty() => LocationModel(
    name: '',
    region: '',
    country: '',
    lat: 0,
    lon: 0,
    tzId: '',
    localtimeEpoch: 0,
    localtime: '',
  );
}
