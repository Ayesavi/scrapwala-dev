import 'dart:async';
import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:scrapwala_dev/core/extensions/object_extension.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

enum NotificationKeys { requests, recommendations }

abstract class NotificationService {
  Future<void> initialize();

  Future<String?> getToken();

  Stream<String> get onTokenRefresh;

  Stream<RemoteMessage?> get onMessageReceived;

  Stream<RemoteMessage?> get onMessageOpenedApp;

  Future<AuthorizationStatus> requestPermission();
}

class FirebaseNotificationService implements NotificationService {
  FirebaseNotificationService._();

  static final FirebaseNotificationService _instance =
      FirebaseNotificationService._();

  // Static getter to get the singleton instance
  static NotificationService get instance => _instance;

  FirebaseMessaging get messaging => FirebaseMessaging.instance;

  @override
  Future<String?> getToken() async {
    return messaging.getToken();
  }

  @override
  Future<void> initialize() async {
    await AwesomeNotifications().initialize(
        'resource://drawable/ic_launcher_foreground',
        [
          NotificationChannel(
            channelKey: NotificationKeys.requests.name,
            channelName: 'Request Notifications',
            channelDescription:
                'It delivers timely updates and alerts regarding pickup requests, ensuring seamless communication for all stakeholders involved.',
            playSound: true,
            onlyAlertOnce: true,
            groupAlertBehavior: GroupAlertBehavior.Children,
            importance: NotificationImportance.High,
            defaultPrivacy: NotificationPrivacy.Private,
          ),
          NotificationChannel(
            channelKey: NotificationKeys.recommendations.name,
            channelName: 'Recommendations',
            channelDescription:
                'Delivers timely updates and alerts akin to recommendations for pickup requests, facilitating seamless communication among stakeholders.',
            playSound: true,
            onlyAlertOnce: true,
            groupAlertBehavior: GroupAlertBehavior.Children,
            importance: NotificationImportance.High,
            defaultPrivacy: NotificationPrivacy.Private,
          )
        ],
        debug: true);

    FirebaseMessaging.onBackgroundMessage(_onBackgroundMessage);
  }

  @override
  Stream<RemoteMessage?> get onMessageOpenedApp =>
      FirebaseMessaging.onMessageOpenedApp;

  @override
  Stream<RemoteMessage?> get onMessageReceived => FirebaseMessaging.onMessage;

  @override
  Stream<String> get onTokenRefresh =>
      FirebaseMessaging.instance.onTokenRefresh;

  @override
  Future<AuthorizationStatus> requestPermission() async {
    final status = (await FirebaseMessaging.instance.requestPermission())
        .authorizationStatus;
    return status;
  }
}

@pragma('vm:entry-point')
Future<void> _onBackgroundMessage(RemoteMessage message) async {
  if (message.isNotNull) {
    if (message.isNotNull) {
      // if (message.notification != null) {

      // AwesomeNotifications().createNotification(
      //     content: NotificationContent(
      //         id: Random().nextInt(100000),
      //         channelKey: message.notification!.android?.channelId ??
      //             NotificationKeys.recommendations.name,
      //         title: message.notification!.title,
      //         bigPicture: message.notification!.android?.imageUrl,
      //         body: message.notification!.body));
      // }
      if (message.data.isNotEmpty) {
        final channel = message.data.containsKey('channel')
            ? message.data['channel']
            : null;
        final title =
            message.data.containsKey('title') ? message.data['title'] : null;
        final body =
            message.data.containsKey('body') ? message.data['body'] : null;
        final bigPicture = message.data.containsKey('image_url')
            ? message.data['image_url']
            : null;
        final id = message.data.containsKey('id') ? message.data['id'] : null;
        final groupKey = message.data.containsKey('group_key')
            ? message.data['group_key']
            : null;
        AwesomeNotifications().createNotification(
            content: NotificationContent(
                id: int.parse(id),
                channelKey: channel,
                title: title,
                bigPicture: bigPicture,
                body: body,
                groupKey: groupKey));
      }
    }
  }
}

abstract class NotificationWrapper {}

class SupabaseNotificationWrapper {
  SupabaseNotificationWrapper._();

  static final SupabaseNotificationWrapper _instance =
      SupabaseNotificationWrapper._();

  // Static getter to get the singleton instance
  static SupabaseNotificationWrapper get instance => _instance;

  final _service = FirebaseNotificationService.instance;

  final _notifications = AwesomeNotifications();

  final _supabaseClient = Supabase.instance.client;

  initialize() {
    _service.onTokenRefresh.listen(onTokenRefresh);
    _service.onMessageReceived.listen(_showRequestNotification);
    _service.onMessageOpenedApp.listen(_showRequestNotification);
    syncToken();
    _service.requestPermission();
  }

  void onTokenRefresh(String token) async {
    await _supabaseClient.from('fcm_tokens').insert({'token': token});
  }

  void syncToken() async {
    try {
      _service.getToken().then((value) async =>
          _supabaseClient.from('fcm_tokens').insert({'token': value}));
    } catch (e) {
      // ignore error if duplicate
      return;
    }
  }
}

void _showRequestNotification(RemoteMessage? message) {
  if (message.isNotNull) {
    if (message!.notification != null) {
      AwesomeNotifications().createNotification(
          content: NotificationContent(
              id: Random().nextInt(100000),
              channelKey: message.notification!.android?.channelId ??
                  NotificationKeys.recommendations.name,
              title: message.notification!.title,
              bigPicture: message.notification!.android?.imageUrl,
              body: message.notification!.body));
    } else if (message.data.isNotEmpty) {
      final channel =
          message.data.containsKey('channel') ? message.data['channel'] : null;
      final title =
          message.data.containsKey('title') ? message.data['title'] : null;
      final body =
          message.data.containsKey('body') ? message.data['body'] : null;
      final bigPicture = message.data.containsKey('image_url')
          ? message.data['image_url']
          : null;
      final id = message.data.containsKey('id') ? message.data['id'] : null;
      final groupKey = message.data.containsKey('group_key')
          ? message.data['group_key']
          : null;
      AwesomeNotifications().createNotification(
          content: NotificationContent(
              id: int.parse(id),
              channelKey: channel,
              title: title,
              bigPicture: bigPicture,
              body: body,
              groupKey: groupKey));
    }
  }
}




// Request Accepted
// Request Denied
// Request Going to piced up
