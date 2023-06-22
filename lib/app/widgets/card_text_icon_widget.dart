/*
* Created By Mirai Devs.
* On 6/22/2023.
*/

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kotobati/app/core/utils/app_theme.dart';

class CardTextIconWidget extends StatelessWidget {
  const CardTextIconWidget({
    Key? key,
    required this.text,
    required this.icon,
  }) : super(key: key);

  final String text;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: AppTheme.keyAppGrayColorDark,
        ),
      ),
      child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              color: AppTheme.keyAppColor,
              borderRadius: BorderRadius.circular(18),
            ),
            child: SvgPicture.asset(icon),
          ),
          Text(
            text,
            style: context.textTheme.bodyLarge!.copyWith(),
          ),
        ],
      ),
    );
  }
}
