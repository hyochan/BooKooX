import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_config/flutter_config.dart';

import '../firebase_options.dart';

class FirebaseConfig {
  static initializeApp() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    if (shouldUseEmulator()) {
      String internalIP = getInternalIP();

      FirebaseFirestore.instance.settings = Settings(
        host: '$internalIP:8080',
        sslEnabled: false,
        persistenceEnabled: false,
      );
      await FirebaseAuth.instance.useAuthEmulator(internalIP, 9099);
      await FirebaseStorage.instance.useStorageEmulator(
        internalIP,
        9199,
      );
    }
  }

  static String getInternalIP() {
    final String? internalIP = FlutterConfig.get('INTERNAL_IP');

    if (internalIP == null || internalIP == "") {
      return '10.0.2.2';
    }

    return internalIP;
  }

  static bool shouldUseEmulator() =>
      FlutterConfig.get('SHOULD_USE_EMULATOR') == null
          ? false
          : FlutterConfig.get('SHOULD_USE_EMULATOR').toString().toLowerCase() ==
              'true';
}
