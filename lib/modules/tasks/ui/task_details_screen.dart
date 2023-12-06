import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vidurakshak_sih/modules/map/models/marker_model.dart';
import 'package:vidurakshak_sih/utils/screen_util/gap.dart';
import 'package:vidurakshak_sih/utils/screen_util/screen_sizes.dart';
import 'package:vidurakshak_sih/utils/theme/app_colors.dart';

class TaskDetailsScreen extends StatefulWidget {
  const TaskDetailsScreen({super.key});

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  Set<Marker> _marker = {};
  late Future<String> addressFuture;

  Future<String> adressFromLatLong(LatLng coordinates) async {
    var address = await GeocodingPlatform.instance
        .placemarkFromCoordinates(coordinates.latitude, coordinates.longitude);

    return "${address.first.street}, ${address.first.locality}, ${address.first.country}";
  }

  @override
  void initState() {
    super.initState();
    _marker.add(MarkerModel.markerList[0]);
    addressFuture = adressFromLatLong(MarkerModel.markerList[0].position);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.primaryTextColor,
        elevation: 0,
        title: FutureBuilder(
          future: addressFuture,
          builder: (context, snapshot) {
            return Row(children: [
              Icon(Icons.gps_fixed),
              SizedBox(
                width: Gap.sw,
              ),
              Text(snapshot.data ?? "Location")
            ]);
          },
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            width: ScreenSizes.screenWidth,
            height: ScreenSizes.screenHeight! * 0.3,
            child: GoogleMap(
              mapType: MapType.hybrid,
              markers: _marker,
              initialCameraPosition: CameraPosition(
                target: MarkerModel.markerList[0].position,
                zoom: 14,
              ),
            ),
          )
        ],
      ),
    );
  }
}
