/*
* Created By Mirai Devs.
* On 6/24/2023.
*/

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kotobati/app/core/utils/app_icons_keys.dart';
import 'package:kotobati/app/core/utils/app_theme.dart';

class TextBottomSheet {
  static Future<void> showTextBottomSheet({required String text}) async {
    await Get.bottomSheet(
      TextBottomSheetWidget(text: text),
    );
  }
}

class TextBottomSheetWidget extends StatelessWidget {
  const TextBottomSheetWidget({super.key, required this.text});

  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.height * 0.6,
      color: Colors.transparent,
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: InkWell(
              onTap: () {
                Get.back();
              },
              child: Container(
                height: 20,
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 2),
                decoration: const BoxDecoration(
                  color: AppTheme.keyAppWhiteColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(26),
                    topRight: Radius.circular(26),
                  ),
                ),
                child: SvgPicture.asset(
                  AppIconsKeys.arrowBottom,
                  color: AppTheme.keyAppBlackColor,
                ),
              ),
            ),
          ),
          Positioned(
            top: 20,
            bottom: 0,
            child: Container(
              width: context.width,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              decoration: const BoxDecoration(
                color: AppTheme.keyAppGrayColorDark,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(26),
                  topRight: Radius.circular(26),
                ),
              ),
              child: Text(
                text,
                style: context.textTheme.bodyLarge!.copyWith(
                  color: AppTheme.keyAppWhiteColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}