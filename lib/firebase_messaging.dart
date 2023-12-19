import 'package:firebase_messaging/firebase_messaging.dart';

class CustomFirebaseMessaging {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    // If you're going to use other Firebase services in the background, such as Firestore,
    // make sure you call `initializeApp` before using other Firebase services.

    print("Handling a background message: ${message.messageId}");
  }

  Future<void> initNotifications() async {
    await messaging.requestPermission();
    final fcmToken = await messaging.getToken();
    print('Tpken: ${fcmToken}');

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }
}
