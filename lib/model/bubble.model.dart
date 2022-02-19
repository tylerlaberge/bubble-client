import 'package:mybubble/model/location.model.dart';

class Bubble {
  String id;
  String data;
  Location location;

  Bubble({required this.id, required this.data, required this.location});

  Bubble.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        data = json["data"],
        location = Location(
            latitude: json["location"]["latitude"],
            longitude: json["location"]["longitude"]
        );

  Map<String, dynamic> toJson() =>
      {
        "id": id,
        "data": data,
        "location": {
          "latitude": location.latitude,
          "longitude": location.longitude
        }
      };
}