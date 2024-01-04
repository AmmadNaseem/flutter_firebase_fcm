import 'package:flutter/material.dart';
import 'package:flutter_firebase_fcm/notification_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  NotificationService notificationService = NotificationService();
  @override
  void initState() {
    super.initState();
    notificationService.requestNotificationPermission();
    notificationService.firebaseInit(context);
    notificationService.setupInteractMessage(context);
    notificationService.isTokenRefresh();
    notificationService.getDeviceToken().then((value) {
      print('=========Device Token: ');
      print(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          NotificationButton(),
          TextButton(
            onPressed: () {},
            child: const Text('Send Notification'),
          ),
        ]),
      ),
    );
  }
}

class NotificationButton extends StatelessWidget {
  final NotificationService notificationService = NotificationService();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        _showNotification();
      },
      child: Text('Show Notification'),
    );
  }

  void _showNotification() {
    String title = 'Notification Title 1';
    String body = 'Notification Body 1';
    String payload = 'Notification Payload';

    notificationService.showSimpleNotification(
      title: title,
      body: body,
      payload: payload,
    );
  }
}
