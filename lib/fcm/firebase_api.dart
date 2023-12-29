import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    final FCMToken = await _firebaseMessaging.getToken();
    print('Token: $FCMToken');
  }
}
