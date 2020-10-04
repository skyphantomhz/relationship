

import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileRepository {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<String> saveFile(File file, String path) async {
    File newImage = await file.copy('$_localPath/$path');
    return newImage.path;
  }

  Future deleteFile(String path){
    final dir = Directory(path);
    dir.deleteSync(recursive: true);
  }

  static String generateImageName(){
    return "image/${DateTime.now().millisecondsSinceEpoch.toString()}.png";
  }
}
