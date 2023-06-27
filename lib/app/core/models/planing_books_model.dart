/*
* Created By Mirai Devs.
* On 6/27/2023.
*/

import 'package:get/get.dart';
import 'package:kotobati/app/core/utils/app_icons_keys.dart';

class PlaningBooksModel {
  final int id;
  final String name;
  final String icon;

  PlaningBooksModel({
    required this.id,
    required this.name,
    required this.icon,
  });

  factory PlaningBooksModel.fromJson(Map<dynamic, dynamic> map) {
    final Map<String, dynamic> json = Map<String, dynamic>.from(map);

    return PlaningBooksModel(
      id: json['id'],
      name: json['name'],
      icon: json['icon'],
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'name': name,
        'icon': icon,
      };
}

RxList<PlaningBooksModel> listPlaningBooks = <PlaningBooksModel>[
  PlaningBooksModel(id: 1, name: "كتب  أقرأها", icon: AppIconsKeys.reading),
  PlaningBooksModel(id: 2, name: "كتب سأقرأها", icon: AppIconsKeys.readLater),
  PlaningBooksModel(id: 3, name: "كتب قرأتها", icon: AppIconsKeys.reading),
].obs;