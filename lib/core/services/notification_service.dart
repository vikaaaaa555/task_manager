import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationService {
  final notificationPlugin = FlutterLocalNotificationsPlugin();

  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;

  Future<void> initNotification() async {
    if (_isInitialized) return;

    await _requestNotificationPermission();

    const initSettingsAndroid = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    const initSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const initSettings = InitializationSettings(
      android: initSettingsAndroid,
      iOS: initSettingsIOS,
    );

    await notificationPlugin.initialize(initSettings);
    _isInitialized = true;
  }

  NotificationDetails notificationDetails() => const NotificationDetails(
    android: AndroidNotificationDetails(
      'tasks_channel_id',
      'Tasks notifications',
      channelDescription: 'Tasks notification channel',
      importance: Importance.max,
      priority: Priority.high,
    ),
    iOS: DarwinNotificationDetails(),
  );

  Future<void> showNotification({
    int id = 0,
    String? title,
    String? body,
  }) async =>
      notificationPlugin.show(id, title, body, notificationDetails());

  Future<void> _requestNotificationPermission() async {
    if (await Permission.notification.isGranted) {
      return;
    }
    await Permission.notification.request();
  }
}
