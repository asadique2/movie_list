import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constant/colors.dart';
import 'common_container.dart';

class MovieListWidget extends StatelessWidget {
  final String title;
  final String image;
  final String director;
  final String releaseYear;
  final onEdit;
  const MovieListWidget({
    Key? key,
    required this.title,
    required this.image,
    required this.onEdit,
    required this.releaseYear,
    required this.director,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonContainer(
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.whiteColor,
            border: Border.all(color: AppColors.disableBorderColor),
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        height: 100,
        width: Get.width,
        child: Row(
          children: [
            Expanded(
                flex: 2,
                child: Container(
                  decoration: const BoxDecoration(
                      color: AppColors.activeBackgroundColor,
                      borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(20))),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                    ),
                    child: Image.file(
                      File(image),
                      fit: BoxFit.cover,
                    ),
                  ),
                )),
            Expanded(
                flex: 5,
                child: Container(
                    decoration: const BoxDecoration(
                        borderRadius:
                            BorderRadius.only(topLeft: Radius.circular(20))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                                child: Text(
                              title,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            )),
                            SizedBox(width: 10),
                            InkWell(
                              onTap: onEdit,
                              child: Text(
                                'Edit',
                                style: TextStyle(color: AppColors.baseColor),
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'By: $director',
                              style: const TextStyle(fontSize: 14),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              releaseYear,
                              style: const TextStyle(
                                  fontSize: 12, color: AppColors.disableColor),
                            )
                          ],
                        ).paddingOnly(bottom: 5),
                      ],
                    ).paddingOnly(left: 20, top: 12, bottom: 10, right: 10)))
          ],
        ),
      ),
    );
  }
}
