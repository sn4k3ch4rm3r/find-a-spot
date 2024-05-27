import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_a_spot/router.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'firebase_options.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseFirestore.instance.settings = const Settings(persistenceEnabled: true);

  if (kDebugMode) {
    String emulatorHost = dotenv.env["FIREBASE_EMULATOR_HOST"] ?? "localhost";
    await FirebaseAuth.instance.useAuthEmulator(emulatorHost, 9099);
    FirebaseFirestore.instance.useFirestoreEmulator(emulatorHost, 8080);
    await FirebaseStorage.instance.useStorageEmulator(emulatorHost, 9199);
    FirebaseFirestore.instance.settings = const Settings(persistenceEnabled: false, cacheSizeBytes: null);
  }

  FirebaseUIAuth.configureProviders([
    EmailAuthProvider(),
  ]);

  GoRouter router = createRouter();
  runApp(NatureFinderApp(
    router: router,
  ));

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.transparent,
  ));
}
