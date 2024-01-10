import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_firebase_fcm/notification_service.dart';
import 'package:http/http.dart' as http;

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
    notificationService.foregroundMessage();
    notificationService.firebaseInit(context);
    notificationService.setupInteractMessage(context);
    notificationService.isTokenRefresh();

    notificationService.getDeviceToken().then((value) {
      print('=========Device Token: ');
      print(value);
    });
    notificationService.getDeviceInfo().then((deviceInfo) {
      print('=========Device Info: ');
      print(deviceInfo);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          NotificationButton(),
          TextButton(
            onPressed: () {
              notificationService.getDeviceToken().then((value) async {
                print('=========Device Token: ');
                print(value);
                var data = {
                  'to': value.toString(),
                  'priority': 'high',
                  'notification': {
                    'title': 'title app to app',
                    'body': 'This is body app to app'
                  },
                  'data': {
                    'type': 'msg',
                    'id': '1',
                    'title': 'title app to app',
                    'body': 'This is body app to app',
                    'status': 'done',
                    'click_action': 'FLUTTER_NOTIFICATION_CLICK',
                  },
                };

                await http.post(
                    Uri.parse('https://fcm.googleapis.com/fcm/send'),
                    body: jsonEncode(data),
                    headers: {
                      'Content-Type': 'application/json; charset=UTF-8',
                      'Authorization':
                          'key=AAAALLJcVgc:APA91bFMR3RgQey2ByRzFreuCkwZkw5c11JmoE1GdN6VH0g9dclzHyXuP-bVhdYib6At2fVwt3zG6Su8q_uI-CGzuMJSjhtKkQywEKDg5yX75NYSCL70-DiUoXZZcdfD-2djvGJP0-FN'
                    });
              });
            },
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
