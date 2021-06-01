
import 'package:cloud_firestore/cloud_firestore.dart';

class Brand {
  String name;
  String imageUrl;
  List<String> tags;
  double latitude;
  double longitude;
  String placeId;

  Brand({
    this.name,
    this.imageUrl,
    this.tags,
    this.latitude,
    this.longitude,
    this.placeId,
  });

  factory Brand.fromFirebase(DocumentSnapshot snapshot) {
    Map data = snapshot.data();
    return Brand(
      name: data['name'],
      imageUrl: data['imageUrl'],
      tags: data['tags'].cast<String>(),
      latitude: data['location'].latitude as double,
      longitude: data['location'].longitude as double,
      placeId: data['placeId'],
    );
  }
}
