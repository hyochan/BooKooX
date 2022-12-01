import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_native_image/flutter_native_image.dart';

class FireStorageService {
  static final FireStorageService _instance = FireStorageService();
  static FireStorageService get instance => _instance;

  Future<String> uploadImage({
    File? file,
    required String uploadDir,
    String? imgStr,
    String metaData = '',
    bool compressed = false,
  }) async {
    /// Upload thumb
    if (compressed) {
      file = await FlutterNativeImage.compressImage(file!.path,
          quality: 100, targetWidth: 120, targetHeight: 120);
    }

    /// Upload image
    final Reference ref =
        FirebaseStorage.instance.ref().child(uploadDir).child('$imgStr.png');

    UploadTask uploadTask = ref.putFile(
      file!,
      SettableMetadata(
        contentLanguage: 'en',
        customMetadata: <String, String>{'activity': metaData},
      ),
    );

    var downloadUrl =
        await (await uploadTask.whenComplete(() => ref.getDownloadURL()))
            .ref
            .getDownloadURL();
    return downloadUrl;
  }
}
