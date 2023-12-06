import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vidurakshak_sih/modules/map/models/marker_model.dart';

class MapViewScreen extends StatefulWidget {
  const MapViewScreen({super.key});

  @override
  State<MapViewScreen> createState() => _MapViewScreenState();
}

class _MapViewScreenState extends State<MapViewScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  final Set<Marker> _markers = {};
  MapType _mapType = MapType.normal;

  static const CameraPosition _sangliRegion = CameraPosition(
    target: LatLng(17.1707, 74.6869),
    zoom: 14.4746,
  );

  void changeMapType() {
    setState(() {
      _mapType = (_mapType == MapType.normal) ? MapType.hybrid : MapType.normal;
    });
  }

  void addMarkers() {
    _markers.addAll(MarkerModel.markerList);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(children: [
        GoogleMap(
          initialCameraPosition: _sangliRegion,
          onTap: (latLong) {
            print(latLong);
          },
          mapType: _mapType,
          markers: _markers,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
            addMarkers();
          },
        ),
        Positioned(
            right: 10,
            top: 30,
            child: Column(
              children: [
                FloatingActionButton(
                    child: Icon(_mapType == MapType.normal
                        ? Icons.satellite_alt
                        : Icons.map),
                    onPressed: () {
                      changeMapType();
                    })
              ],
            ))
      ]),
    );
  }
}
