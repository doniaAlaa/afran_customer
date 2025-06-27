// import 'dart:convert';
//
// import 'package:afran/constant/app_strings.dart';
// import 'package:afran/constant/secure_storage.dart';
// import 'package:afran/entity/user_model.dart';
// import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
//
//
//
//
//
// late PusherChannelsFlutter pusher;
//
// Future<void> initPusher() async {
//   // print('object${user}');
//   final secureStorage = SecureStorageService();
//
//   String? userData = await secureStorage.read(user);
//
//   pusher = PusherChannelsFlutter();
//  try{
//    if(userData != null){
//      UserModel userModel = UserModel.fromJson(jsonDecode(userData));
//      final String channelName = "notifications.${userModel.id}"; // Interpolated once correctly
//      // final String channelName = "my-channel"; // Interpolated once correctly
//      print(userModel.id);
//      await pusher.init(
//        logToConsole: true,
//        // apiKey: "89b897f40a812084df08",
//        apiKey: "ef482180ec86015c2ee1",
//        cluster: "ap2",
//        onConnectionStateChange: (currentState, previousState) {
//          print("Connection: $currentState");
//        },
//        onError: (message, code, error) {
//          print("Error: $message ($code) $error");
//        },
//        onEvent: (PusherEvent event) {
//          print(" Event received: ${event.eventName} on ${event.channelName}");
//
//          // Filter event using correctly interpolated channel name
//          if (event.channelName == channelName && event.eventName == "new-notification") {
//          // if (event.channelName == channelName && event.eventName == "my-event") {
//            print('✅ Matched event: ${event.data}');
//
//            final data = event.data != null ? jsonDecode(event.data!) : null;
//            if (data != null) {
//              print('📦 Order Status: ${data['status']}');
//            }
//          }
//        },
//      );
//
//      await pusher.connect();
//      await pusher.subscribe(channelName: channelName);
//      print("📡 Subscribed to channel: $channelName");
//
//
//    }
//  }catch(e){
//    print(e);
//  }
//
// }
//
// ////////////////////////////////////

import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

class PusherService {
  static final PusherChannelsFlutter _pusher = PusherChannelsFlutter.getInstance();

  static PusherChannelsFlutter get instance => _pusher;

  static Future<void> initialize({
    required String apiKey,
    required String cluster,
  }) async {
    await _pusher.init(
      apiKey: apiKey,
      cluster: cluster,
      onConnectionStateChange: (current, previous) {
        print("Pusher state changed: $current");
      },
      onError: (message, code, e) {
        print("Pusher error: $message");
      },
    );

    await _pusher.connect();
  }
}
