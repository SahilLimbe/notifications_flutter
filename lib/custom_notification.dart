import 'package:flutter/material.dart';

class CustomNotification {
  int id;
  String title;
  String body;
  String payload;

  CustomNotification(
      {@required this.id,
      @required this.title,
      @required this.body,
      @required this.payload});
}

CustomNotification object0 = CustomNotification(
  id: 0,
  title: 'TITLE0',
  body: 'BODY OF NOTIFICATION 0',
  payload: 'WHATEVER',
);
CustomNotification object1 = CustomNotification(
  id: 1,
  title: 'TITLE1',
  body: 'BODY OF NOTIFICATION 1',
  payload: 'WHATEVER',
);
CustomNotification object2 = CustomNotification(
  id: 2,
  title: 'TITLE2',
  body: 'BODY OF NOTIFICATION 2',
  payload: 'WHATEVER',
);
CustomNotification object3 = CustomNotification(
  id: 3,
  title: 'TITLE3',
  body: 'BODY OF NOTIFICATION 3',
  payload: 'WHATEVER',
);

List listOfNotifications = [object0, object1, object2, object3];
