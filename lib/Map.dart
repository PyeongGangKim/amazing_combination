import 'dart:async';

import 'package:amazing_combination/controllers/BrandController.dart';
import 'package:amazing_combination/models/Brand.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';

final LatLng initialPosition = const LatLng(36.103124, 129.388364);

class MapPage extends StatefulWidget {
  const MapPage({Key key}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final Completer<GoogleMapController> _mapController = Completer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        BrandMap(mapController: _mapController),
        BrandCarousel(mapController: _mapController),
      ],
    ));
  }
}

class BrandCarousel extends StatelessWidget {
  const BrandCarousel({Key key, @required this.mapController})
      : super(key: key);
  final Completer<GoogleMapController> mapController;

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.topLeft,
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: SizedBox(
            height: 90,
            child: BrandCarouselList(
              mapController: mapController,
            ),
          ),
        ));
  }
}

class BrandCarouselList extends StatelessWidget {
  const BrandCarouselList({Key key, @required this.mapController})
      : super(key: key);
  final Completer<GoogleMapController> mapController;

  @override
  Widget build(BuildContext context) {
    return GetX<BrandController>(
      builder: (BrandController brandController) {
        print(brandController.brandList.length);
        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: brandController.brandList.length,
          itemBuilder: (_, int index) {
            return SizedBox(
              width: 340,
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Card(
                  child: Center(
                    child: StoreListTile(
                      brand: brandController.brandList[index],
                      mapController: mapController,
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class StoreListTile extends StatefulWidget {
  const StoreListTile(
      {Key key, @required this.brand, @required this.mapController})
      : super(key: key);
  final Brand brand;
  final Completer<GoogleMapController> mapController;

  @override
  _StoreListTileState createState() => _StoreListTileState();
}

class _StoreListTileState extends State<StoreListTile> {
  @override
  Widget build(BuildContext context) {
    String tagList = widget.brand.tags[0];
    for (int i = 1; i < widget.brand.tags.length; ++i) {
      tagList += ', ' + widget.brand.tags[i];
    }

    return ListTile(
        title: Text(widget.brand.name),
        subtitle: Text(tagList),
        leading: Container(
            width: 100,
            height: 100,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(2)),
              child: Image.network(
                widget.brand.imageUrl,
                fit: BoxFit.cover,
              ),
            )),
        onTap: () async {
          final controller = await widget.mapController.future;
          await controller
              .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
            target: LatLng(widget.brand.latitude, widget.brand.longitude),
            zoom: 16,
          )));
        });
  }
}

class BrandMap extends StatelessWidget {
  const BrandMap({Key key, @required this.mapController}) : super(key: key);
  final Completer<GoogleMapController> mapController;

  @override
  Widget build(BuildContext context) {
    return GetX<BrandController>(builder: (brandController) {
      return GoogleMap(
        initialCameraPosition: CameraPosition(
          target: initialPosition,
          zoom: 12,
        ),
        markers: brandController.brandList.map((brand) {
          print(brand.name);
          String tagList = brand.tags[0];
          for (int i = 1; i < brand.tags.length; ++i) {
            tagList += ', ' + brand.tags[i];
          }
          return Marker(
            markerId: MarkerId(brand.name),
            icon: BitmapDescriptor.defaultMarker,
            position: LatLng(brand.latitude, brand.longitude),
            infoWindow: InfoWindow(
              title: brand.name,
              snippet: tagList,
            ),
          );
        }).toSet(),
        onMapCreated: (mapController) {
          this.mapController.complete(mapController);
        },
      );
    });
  }
}
