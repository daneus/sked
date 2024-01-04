import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    final fcmToken = await _firebaseMessaging.getToken();
    print('Token: $fcmToken');
  }
}
