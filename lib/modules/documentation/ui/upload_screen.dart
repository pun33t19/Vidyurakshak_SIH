import 'dart:io';
import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:insta_assets_picker/insta_assets_picker.dart';
import 'package:provider/provider.dart';
import 'package:vidurakshak_sih/modules/tasks/models/document_model.dart';
import 'package:vidurakshak_sih/modules/tasks/providers/document_provider.dart';
import 'package:vidurakshak_sih/modules/tasks/providers/task_list_provider.dart';
import 'package:vidurakshak_sih/modules/tasks/ui/task_details_screen.dart';
import 'package:vidurakshak_sih/utils/screen_util/gap.dart';
import 'package:vidurakshak_sih/utils/screen_util/screen_sizes.dart';
import 'package:vidurakshak_sih/utils/styles/text_styles.dart';
import 'package:vidurakshak_sih/utils/theme/app_colors.dart';

class UploadScreen extends StatefulWidget {
  final Stream<InstaAssetsExportDetails> photoStream;

  const UploadScreen({super.key, required this.photoStream});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  String currentLocation = "";
  List<File> imageList = [];
  final TextEditingController _textEditingController = TextEditingController();

  void adressFromLatLong() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    var address = await GeocodingPlatform.instance
        .placemarkFromCoordinates(position.latitude, position.longitude);

    currentLocation =
        "${address.first.street}, ${address.first.locality}, ${address.first.country}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Document Work',
          style: TextStyles.ts600l,
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            StreamBuilder(
              stream: widget.photoStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    imageList.isEmpty) {
                  imageList.addAll(snapshot.data!.croppedFiles);
                }
                return SizedBox(
                  height: ScreenSizes.screenHeight! * 0.4,
                  width: ScreenSizes.screenWidth,
                  child: CarouselSlider(
                    options: CarouselOptions(
                      autoPlay: true,
                      aspectRatio: 1,
                      enlargeCenterPage: true,
                    ),
                    items: snapshot.data!.croppedFiles
                        .map(
                          (item) => Container(
                            margin: EdgeInsets.all(5.0),
                            child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                                child: Image.file(item)),
                          ),
                        )
                        .toList(),
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Description',
                    style: TextStyles.ts400m,
                  ),
                  SizedBox(
                    height: Gap.sh,
                  ),
                  TextField(
                    controller: _textEditingController,
                    decoration: InputDecoration(
                        hintText: 'Add a description',
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColors.primaryColor.withOpacity(0.5),
                                width: 2)),
                        focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColors.primaryColor, width: 2)),
                        filled: true),
                    maxLines: 4,
                  ),
                  SizedBox(
                    height: Gap.sh,
                  ),
                  Text(
                    'Location',
                    style: TextStyles.ts400m,
                  ),
                  SizedBox(
                    height: Gap.xsh,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        adressFromLatLong();
                      });
                    },
                    child: currentLocation.isNotEmpty
                        ? Text(
                            currentLocation,
                            style: TextStyles.ts300s
                                .apply(color: AppColors.primaryColor),
                          )
                        : Row(
                            children: [
                              Icon(
                                Icons.gps_fixed,
                                color: AppColors.primaryColor,
                              ),
                              SizedBox(
                                width: Gap.xsw,
                              ),
                              Text(
                                'Get your current location',
                                style: TextStyles.ts300s
                                    .apply(color: AppColors.primaryColor),
                              )
                            ],
                          ),
                  ),
                  SizedBox(
                    height: Gap.lh,
                  ),
                  Center(
                    child: SizedBox(
                      width: ScreenSizes.screenWidth! - 50,
                      height: ScreenSizes.screenHeight! * 0.05,
                      child: ElevatedButton(
                        onPressed: () {
                          Provider.of<DocumentProvider>(context, listen: false)
                              .addDocumentItem(
                            DocumentModel(
                              images: imageList,
                              description: _textEditingController.text,
                              location: currentLocation,
                              timestamp: DateTime.now(),
                            ),
                          );
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (context) => TaskDetailsScreen(
                                  taskModel:
                                      Provider.of<TaskListProvider>(context)
                                          .tasksModel,
                                ),
                              ),
                              (route) =>
                                  route.settings.name == 'task_details_screen');
                        },
                        child: Text('POST'),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor),
                      ),
                    ),
                  )
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
