// ignore_for_file: non_constant_identifier_names, avoid_print

import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:permission_handler/permission_handler.dart';

class ClsLogs {
  static Future<void> API_SUCCESS(String apiName, String txt) async {
    // final Directory? directory = await getExternalStorageDirectory();
    // final File file = File('${directory!.path}/API_SUCCESS.txt');
    // final Directory customDirectory = Directory(
    //     '/storage/emulated/0/ccc_logs'); // Specify the custom directory path
    // customDirectory.createSync(
    //     recursive: true); // Create the directory if it doesn't exist
    // final File file = File('${customDirectory.path}/API_SUCCESS.txt');
    // print("file path= $file");
    // final sink = file.openWrite(mode: FileMode.append);

    // sink.write('$apiName\n$txt\n\n');
    // await sink.flush();
    // await sink.close();
    var status = await Permission.storage.request();
    if (status.isGranted) {
      final Directory customDirectory =
          Directory('/storage/emulated/0/ccc_logs');
      customDirectory.createSync(recursive: true);
      // final Directory? directory = await getExternalStorageDirectory();
      // final String customDirectoryPath = '${directory!.path}/ccc_logs';
      // final Directory customDirectory = Directory(customDirectoryPath);

      // try {
      //   await customDirectory.create(recursive: true);
      // } catch (e) {
      //   print('Error creating directory: $e');
      //   return;
      // }

      final File file = File('${customDirectory.path}/API_SUCCESS.txt');
      print("file path= $file");
      final sink = file.openWrite(mode: FileMode.append);

      sink.write('$apiName\n$txt\n\n');
      await sink.flush();
      await sink.close();
    } else {
      // Handle permission denied
      print('Storage permission is denied');
    }
  }

  static Future<void> API_FAILURE(String txt) async {
    var status = await Permission.storage.request();

    if (status.isGranted) {
      //   // final Directory? directory = await getExternalStorageDirectory();
      //   // final File file = File('${directory!.path}/API_FAILURE.txt');
      //   final Directory? directory = await getExternalStorageDirectory();
      //   final String customDirectoryPath = '${directory!.path}/ccc_logs';
      //   final Directory customDirectory = Directory(customDirectoryPath);

      //   try {
      //     await customDirectory.create(recursive: true);
      //   } catch (e) {
      //     print('Error creating directory: $e');
      //     return;
      //   }
      final Directory customDirectory =
          Directory('/storage/emulated/0/ccc_logs');
      customDirectory.createSync(recursive: true);
      final File file = File('${customDirectory.path}/API_FAILURE.txt');
      print("file path= $file");
      final sink = file.openWrite(mode: FileMode.append);
      sink.write('$txt\n\n');
      await sink.flush();
      await sink.close();
    } else {
      // Handle permission denied
      print('Storage permission is denied');
    }
  }

  static Future<void> API_HIT(String txt) async {
    var status = await Permission.storage.request();
    if (status.isGranted) {
      // final Directory? directory = await getExternalStorageDirectory();
      // final File file = File('${directory!.path}/API_HIT.txt');
      // final Directory? directory = await getExternalStorageDirectory();
      // final String customDirectoryPath = '${directory!.path}/ccc_logs';
      // final Directory customDirectory = Directory(customDirectoryPath);

      // try {
      //   await customDirectory.create(recursive: true);
      // } catch (e) {
      //   print('Error creating directory: $e');
      //   return;
      // }
      final Directory customDirectory =
          Directory('/storage/emulated/0/ccc_logs');
      customDirectory.createSync(recursive: true);
      final File file = File('${customDirectory.path}/API_HIT.txt');
      print("file path= $file");
      final sink = file.openWrite(mode: FileMode.append);

      sink.write('$txt\n\n');
      await sink.flush();
      await sink.close();
    } else {
      // Handle permission denied
      print('Storage permission is denied');
    }
  }

  static Future<void> shareLogFile(String logFileName) async {
    final Directory? directory = await getExternalStorageDirectory();
    final File file = File('${directory!.path}/$logFileName');

    if (file.existsSync()) {
      try {
        await FlutterShare.shareFile(
          title: 'Log File',
          text: 'Sharing $logFileName',
          filePath: file.path,
        );
      } catch (e) {
        print('Error sharing file: $e');
      }
    } else {
      print('File not found: $logFileName');
    }
  }
}
