import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'package:get/get.dart';
import 'package:kotobati/app/core/helpers/common_function.dart';
import 'package:kotobati/app/core/models/book_model.dart';
import 'package:kotobati/app/core/utils/app_custom_dialog.dart';
import 'package:kotobati/app/data/persistence/hive_data_store.dart';

import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeController extends GetxController {
  /// A Value Notifier to store chosen Book...
  final ValueNotifier<Book?> chosenBook = ValueNotifier<Book?>(null);

  // The app name is:
  static const String appName = 'Kotobati';

  // @override
  // void onInit() {
  //   super.onInit();
  // }
  //
  // @override
  // void onReady() {
  //   super.onReady();
  // }

  @override
  void onClose() {
    chosenBook.value = null;
    chosenBook.dispose();
    super.onClose();
  }



  Future<void> onDownloadStartRequest(
    InAppWebViewController controller,
    DownloadStartRequest downloadStartRequest,
  ) async {
    await requestPermission();
    miraiPrint("<========================>");
    miraiPrint("DownloadStartRequest: ${downloadStartRequest.toString()}");
    String filename = extractFilename(downloadStartRequest.contentDisposition.toString())
        .replaceAll('.pdf', '');
    miraiPrint("DownloadStartRequest: filename $filename");
    miraiPrint("onDownloadStart URL ${downloadStartRequest.url.toString()}");
    miraiPrint("<========================>");

    /// Create App Folder

    final String path = await createFolder(appName);
    final Book book = chosenBook.value!;
    book.path = '$path/$filename';

    /// Save book to Hive
    final HiveDataStore dataStore = HiveDataStore();
    dataStore.saveBook(book: book);

    try {
      // enqueue
      final String? taskId = await FlutterDownloader.enqueue(
        url: downloadStartRequest.url.toString(),
        savedDir: path,
        fileName: filename,
        // show download progress in status bar (for Android)
        showNotification: true,
        // click on notification to open downloaded file (for Android)
        openFileFromNotification: false,
      );
      miraiPrint('FlutterDownloader taskId: $taskId');

      /// registerCallback
      await FlutterDownloader.registerCallback((
        String id,
        int status,
        int progress,
      ) {
        miraiPrint("FlutterDownloader: id $id, status: $status, progress: $progress");
        // if (status == DownloadTaskStatus.complete) {
        //   // Download completed
        //   print('Download with ID $id completed');
        // }
      });
    } catch (ex) {
      miraiPrint("FlutterDownloader.enqueue Exception");
    }
  }

  /// If you name your createFolder(".folder") that folder will be hidden.
  /// If you create a .nomedia file in your folder, other apps won't be able to scan your folder.
  Future<String> createFolder(String cow) async {
    /// getExternalStorageDirectory For Android, and getApplicationSupportDirectory For iOS...
    final Directory dir = Directory(
      '${(Platform.isAndroid ? await getExternalStorageDirectory() : await getApplicationSupportDirectory())!.path}/$cow',
    );

    /// Let's Check permission...
    PermissionStatus status = await Permission.storage.status;
    if (!status.isGranted) {
      await requestPermission();
    }

    /// Let's check if the directory is exists...
    if ((await dir.exists())) {
      return dir.path;
    } else {
      dir.create();
      return dir.path;
    }
  }

  String extractFilename(String value) {
    RegExp filenameRegex = RegExp(r'filename[^;=\n]*=["\"]?([^;"\"]*)');
    Match? match = filenameRegex.firstMatch(value);

    if (match != null) {
      String filename = match.group(1) ?? '';
      return Uri.decodeComponent(filename);
    }

    return '';
  }
}
