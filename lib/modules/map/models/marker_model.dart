import 'package:google_maps_flutter/google_maps_flutter.dart';

class MarkerModel {
  static final List<Marker> markerList = [
    Marker(
        markerId: const MarkerId('marker1'),
        position: const LatLng(17.1707, 74.6869),
        infoWindow:
            const InfoWindow(title: 'Corridor 1', snippet: 'Medium priority'),
        icon:
            BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow)),
    Marker(
        markerId: const MarkerId('marker2'),
        position: const LatLng(17.170840650634776, 74.68710612505674),
        infoWindow:
            const InfoWindow(title: 'Corridor 2', snippet: 'Low Priority'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen)),
    Marker(
        markerId: const MarkerId('marker3'),
        position: const LatLng(17.1710267636918, 74.6871704980731),
        infoWindow:
            const InfoWindow(title: 'Corridor 3', snippet: 'High Priority'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed)),
    Marker(
        markerId: const MarkerId('marker4'),
        position: const LatLng(17.17114080189262, 74.68728851526976),
        infoWindow:
            const InfoWindow(title: 'Corridor 4', snippet: 'Medium Priority'),
        icon:
            BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow)),
    const Marker(
        markerId: MarkerId('marker5'),
        position: LatLng(17.17120102428499, 74.68727979809046),
        infoWindow: InfoWindow(title: 'Corridor 5')),
  ];
}
