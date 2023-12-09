import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:vidurakshak_sih/modules/tasks/models/document_model.dart';
import 'package:vidurakshak_sih/utils/screen_util/gap.dart';
import 'package:vidurakshak_sih/utils/screen_util/screen_sizes.dart';
import 'package:vidurakshak_sih/utils/styles/text_styles.dart';
import 'package:vidurakshak_sih/utils/theme/app_colors.dart';

class SingleDocumentWidget extends StatefulWidget {
  final DocumentModel documentModel;

  const SingleDocumentWidget({super.key, required this.documentModel});

  @override
  State<SingleDocumentWidget> createState() => _SingleDocumentWidgetState();
}

class _SingleDocumentWidgetState extends State<SingleDocumentWidget> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          child: CarouselSlider(
            items: widget.documentModel.images.map((item) {
              return Container(
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    child: Image.file(
                      item,
                      fit: BoxFit.fill,
                    )),
              );
            }).toList(),
            carouselController: _controller,
            options: CarouselOptions(
                aspectRatio: 1.1,
                viewportFraction: 1,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                }),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            widget.documentModel.images.length,
            (index) {
              return GestureDetector(
                onTap: () => _controller.animateToPage(index),
                child: Container(
                  width: 10.0,
                  height: 10.0,
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: (Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : AppColors.primaryColor)
                          .withOpacity(_current == index ? 0.9 : 0.4)),
                ),
              );
            },
          ),
        ),
        SizedBox(
          height: Gap.sh,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'John Happy',
                style: TextStyles.ts400m,
              ),
              SizedBox(
                height: Gap.sh,
              ),
              Text(
                widget.documentModel.description,
                style: TextStyles.ts300s,
                maxLines: null,
              ),
            ],
          ),
        ),
        SizedBox(
          height: Gap.mh,
        ),
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Text(
              widget.documentModel.location,
              style: TextStyles.ts400xs,
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Text(
              widget.documentModel.timestamp.toString(),
              style: TextStyles.ts400xs,
            ),
          ),
        ),
      ],
    );
  }
}
