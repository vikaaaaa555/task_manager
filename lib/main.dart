import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'app.dart';
import 'core/options/firebase_options.dart';
import 'core/services/app_dependencies.dart';
import 'core/services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Initialize Firebase with platform-specific options.
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  NotificationService().initNotification();

  await registerAppDependencies();
  runApp(const MyApp());
}
