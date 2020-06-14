import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_native_image/flutter_native_image.dart';

class FireStorageService {
  static FireStorageService _instance = FireStorageService();
  static FireStorageService get instance => _instance;

  Future<String> uploadImage({
    File file,
    String uploadDir,
    String imgStr,
    String metaData = '',
    bool compressed = false,
  }) async {
    /// Upload thumb
    if (compressed) {
      file = await FlutterNativeImage.compressImage(
          file.path,
          quality: 100,
          targetWidth: 120, targetHeight: 120);
    }

    /// Upload image
    final StorageReference ref = FirebaseStorage.instance.ref().child(uploadDir).child('$imgStr.png');
    StorageUploadTask uploadTask = ref.putFile(
      file,
      StorageMetadata(
        contentLanguage: 'en',
        customMetadata: <String, String>{'activity': metaData},
      ),
    );

    var downloadUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
    return downloadUrl;
  }
}
