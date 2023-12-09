import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:insta_assets_picker/insta_assets_picker.dart';
import 'package:lottie/lottie.dart' as ltt;
import 'package:provider/provider.dart';
import 'package:timelines/timelines.dart';
import 'package:vidurakshak_sih/modules/documentation/ui/upload_screen.dart';
import 'package:vidurakshak_sih/modules/map/models/marker_model.dart';
import 'package:vidurakshak_sih/modules/tasks/enums/tasks_priority_enum.dart';
import 'package:vidurakshak_sih/modules/tasks/models/document_model.dart';
import 'package:vidurakshak_sih/modules/tasks/providers/document_provider.dart';
import 'package:vidurakshak_sih/modules/tasks/ui/widgets/alert_red_icon.dart';
import 'package:vidurakshak_sih/modules/tasks/ui/widgets/single_document_widget.dart';
import 'package:vidurakshak_sih/modules/tasks/ui/widgets/status_timeline.dart';
import 'package:vidurakshak_sih/utils/screen_util/gap.dart';
import 'package:vidurakshak_sih/utils/screen_util/screen_sizes.dart';
import 'package:vidurakshak_sih/utils/styles/text_styles.dart';
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
      body: SingleChildScrollView(
        child: Column(
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
            ),
            SizedBox(
              height: Gap.mh,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: ScreenSizes.screenWidth! * 0.07),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sangli district regular check',
                    style: TextStyles.ts600l,
                  ),
                  SizedBox(
                    height: Gap.sh,
                  ),
                  const DetailRowWidget(
                      fieldName: 'Priority: ', fieldProperty: 'Medium'),
                  SizedBox(
                    height: Gap.sh,
                  ),
                  Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                    style: TextStyles.ts300s,
                    maxLines: 6,
                  ),
                  SizedBox(
                    height: Gap.mh,
                  ),
                  Text(
                    'Task Status',
                    style: TextStyles.ts600l,
                  ),
                  SizedBox(
                    height: Gap.sh,
                  ),
                ],
              ),
            ),
            Align(alignment: Alignment.center, child: ProcessTimelinePage()),
            SizedBox(
              height: Gap.mh,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: ScreenSizes.screenWidth! * 0.07),
                child: Text(
                  'Documentation',
                  style: TextStyles.ts600l,
                ),
              ),
            ),
            SizedBox(
              height: Gap.sh,
            ),
            Consumer<DocumentProvider>(
              builder: (context, document, child) {
                if (document.items.isNotEmpty) {
                  return SizedBox(
                    child: ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return SingleDocumentWidget(
                              documentModel: document.items[index]);
                        },
                        separatorBuilder: (context, index) => SizedBox(
                              height: Gap.sh,
                            ),
                        itemCount: document.items.length),
                  );
                }
                return Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: ScreenSizes.screenWidth! * 0.07),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          InstaAssetPicker.pickAssets(context,
                              title: 'Select Images', maxAssets: 5, onCompleted:
                                  (Stream<InstaAssetsExportDetails> stream) {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    UploadScreen(photoStream: stream)));
                          });
                        },
                        child: ClipRect(
                          child: ltt.Lottie.asset('assets/upload_doc.json',
                              height: ScreenSizes.screenHeight! * 0.2,
                              width: ScreenSizes.screenWidth!),
                        ),
                      ),
                      Center(
                        child: Text(
                          'Add Images and document your work!',
                          style: TextStyles.ts300s,
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
            SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }
}

class DetailRowWidget extends StatelessWidget {
  final String fieldName;
  final String fieldProperty;

  const DetailRowWidget(
      {super.key, required this.fieldName, required this.fieldProperty});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          fieldName,
          style: TextStyles.ts400m,
        ),
        SizedBox(
          width: Gap.sw,
        ),
        GlowingAlertIcon(
          tasksPriority: TasksPriority.medium,
        ),
        SizedBox(
          width: Gap.sw,
        ),
        Text(
          fieldProperty,
          style: TextStyles.ts300m,
        )
      ],
    );
  }
}
