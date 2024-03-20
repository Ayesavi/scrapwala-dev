import 'dart:async';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

enum NotificationKeys { requests, recommendations }

abstract class NotificationService {
  Future<void> initialize();

  Future<String?> getToken();

  Stream<String> get onTokenRefresh;

  Stream<RemoteMessage?> get onMessageReceived;

  Stream<RemoteMessage?> get onMessageOpenedApp;
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
        // Assets.images.icLauncher.path\
        null,
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
}

@pragma('vm:entry-point')
Future<void> _onBackgroundMessage(RemoteMessage message) async {}

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
    _service.onMessageReceived.listen(onMessageRecieved);
    _service.onMessageOpenedApp.listen(onMessageOpenedRecieved);
  }

  void onTokenRefresh(String token) async {
    await _supabaseClient.from('fcm_tokens').insert({'token': token});
  }

  void syncToken(){
    
  }

  void onMessageRecieved(RemoteMessage? message) async {}

  onMessageOpenedRecieved(RemoteMessage? message) async {}

  void _showRequestNotification(RemoteMessage message) {
    print(message);
    // final model = RequestNotificationModel.fromJson(message.data);
    // _notifications.createNotification(
    //     content: NotificationContent(
    //         id: Random().nextInt(200),
    //         channelKey: NotificationKeys.requests.name,
    //         body: model.textMessage,
    //         title: model.title));
  }
}


// Request Accepted
// Request Denied
// Request Going to piced up