import 'package:cron/cron.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_notification/custom_notification.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Notification',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  var currentTimeZone;

  @override
  void initState() {
    super.initState();
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
    // flutterLocalNotificationsPlugin.initialize(initializationSettings,
    //     onSelectNotification: notificationSelected);

    // repeatedNotifications(); // Comment this if annoying
    repeatedCronNotifications();
  }

  Future showNotification(
      {@required String notificationTitle,
      @required String notificationBody}) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
            'your channel id', 'your channel name', 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            showWhen: false);
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, notificationTitle, notificationBody, platformChannelSpecifics,
        payload: 'item x');
  }

  // Repeated Notification using flutter_local_notification plugin itself
  // Future repeatedNotifications() async {
  //   const AndroidNotificationDetails androidPlatformChannelSpecifics =
  //       AndroidNotificationDetails('repeating channel id',
  //           'repeating channel name', 'repeating description');
  //   const NotificationDetails platformChannelSpecifics =
  //       NotificationDetails(android: androidPlatformChannelSpecifics);
  //   await flutterLocalNotificationsPlugin.periodicallyShow(0, object0.title,
  //       object0.body, RepeatInterval.everyMinute, platformChannelSpecifics,
  //       androidAllowWhileIdle: true);
  // }

  // Repeated Notification using CRON plugin
  repeatedCronNotifications() {
    int counter = 0;
    print('CRON STARTED');
    final cron = Cron();
    cron.schedule(Schedule.parse('* * * * *'), () async {
      print(counter);
      showNotification(
          notificationTitle: listOfNotifications[counter].title,
          notificationBody: listOfNotifications[counter].body);
      counter++;
      if (counter == 4) {
        counter = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: showNotification,
          child: Text('Send notification'),
        ),
      ),
    );
  }
}
