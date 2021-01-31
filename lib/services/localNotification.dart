import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:open_file/open_file.dart';

class LocalNotificationService {
  static final LocalNotificationService instance = LocalNotificationService();

  FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  
  LocalNotificationService() {
    final initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    final initializationSettingsIOs = IOSInitializationSettings();
    final initSettings = InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOs);

    _flutterLocalNotificationsPlugin.initialize(initSettings, onSelectNotification: _openFile);
  }
  
  void showNotification(String title, [String description, String path]) {
    final androidNotificationDetails = AndroidNotificationDetails('id', 'channel ', 'description', priority: Priority.high, importance: Importance.max);
    final iosNotificationDetails = IOSNotificationDetails();
    final platform = new NotificationDetails(android: androidNotificationDetails, iOS: iosNotificationDetails);
    _flutterLocalNotificationsPlugin.show(0, title, description != null ? description : '', platform, payload: path); 
  }


  Future<String> _openFile(String path) {
    print('abrindo arquivo $path');
    return OpenFile.open(path).then((value) => value.message);
  }
}