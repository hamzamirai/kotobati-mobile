import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:kotobati/app/core/models/book_model.dart';
import 'package:kotobati/app/data/persistence/hive_data_store.dart';
import 'package:kotobati/app/modules/reading/views/components/book_widget.dart';
import 'package:kotobati/app/widgets/common_scaffold.dart';

import '../../../core/utils/app_theme.dart';
import '../controllers/planing_details_controller.dart';

class PlaningDetailsView extends StatefulWidget {
  const PlaningDetailsView({Key? key}) : super(key: key);

  @override
  State<PlaningDetailsView> createState() => _PlaningDetailsViewState();
}

class _PlaningDetailsViewState extends State<PlaningDetailsView> {
  /// BookDetailsController
  late PlaningDetailsController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put<PlaningDetailsController>(
      PlaningDetailsController(),
      tag: '${UniqueKey()}',
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        systemNavigationBarColor: AppTheme.keyAppBlackColor,
      ),
      child: CommonScaffold(
        backButton: true,
        child: ValueListenableBuilder<Box<Map<dynamic, dynamic>>>(
          valueListenable: HiveDataStore().booksListenable(),
          builder: (_, Box<Map<dynamic, dynamic>> box, __) {
            final List<Map<dynamic, dynamic>> books = box.values.toList();

            List<Book> castBooks = <Book>[];

            debugPrint("planingBooksModel: ${controller.planingBooksModel}");

            for (int i = 0; i < books.length; i++) {
              final Book book = Book.fromJson(books[i]);

              if (book.planingBook != null && book.planingBook == controller.planingBooksModel) {
                castBooks.add(Book.fromJson(books[i]));
              }
            }

            if (castBooks.isNotEmpty) {
              return ListView.builder(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  bottom: 90,
                ),
                itemCount: castBooks.length,
                itemBuilder: (_, int index) {
                  return BookWidget(book: castBooks[index]);
                },
              );
            } else {
              return Center(
                child: Text(
                  'لاتوجد بيانات',
                  style: context.textTheme.displayLarge!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
