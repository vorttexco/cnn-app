import 'package:flutter/services.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class MDMNotificationService {
  static const MethodChannel _channel = MethodChannel('mdm_notification_channel');

  static Future<void> handleRemoteMessage(RemoteMessage message) async {
    final data = message.data;
    
    if (data.isEmpty) {
      print('Mensagem recebida sem data.');
      return;
    }

    try {
      final bool isMDM = await _channel.invokeMethod('isMDMNotification', data);
      if (isMDM) {
        await _channel.invokeMethod('processMDMNotification', data);
      }
    } on PlatformException catch (e) {
      print('Erro no canal de comunicação: $e');
    }
  }
}
