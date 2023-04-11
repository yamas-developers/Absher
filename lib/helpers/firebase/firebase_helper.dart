import 'dart:async';
import 'dart:developer';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

class FirebaseHelper extends ChangeNotifier {
  // static String users = "/admin";
  StreamSubscription<DatabaseEvent>? chatMessagesRef = null;
  final database = FirebaseDatabase.instance;
  var orderRef = null;
  // bool initNewOrderFun = false;

  initOrder(orderId, {onSuccess = null, onError = null}) async {
        log('MK: status listening to order: ${orderId}');
    if(orderRef != null){
      orderRef.cancel;
      orderRef = null;
    }

    orderRef = database.ref("orders/${orderId}").onValue.listen((DatabaseEvent event) {
      if (event.snapshot.value != null) {
        notifyListeners();
        log('MK: status changed of order: ${event.snapshot.value.toString()}');
        if (onSuccess != null) onSuccess(event);
      }
      // initNewOrderFun = true;
      notifyListeners();
    }, onError: (error) {
      if (onError != null) onError(error);
    });
  }

// initChatMessagesNotifications() async {
//   User user = (await getUser())!;
//   if(chatMessagesRef != null){
//     chatMessagesRef!.cancel();
//   }
//   chatMessagesRef = database
//       .ref("users/${user.id}/chat_notifications")
//       .onValue
//       .listen((event) {
//     if(event.snapshot.value != null) {
//       chatMessageNotifications = (event.snapshot.value as Map)['count'];
//       if(chatMessageNotifications > 0 && initChatNotification){
//         showSnakBar(title: "New Message", message: "You have received new message");
//       }
//       initChatNotification = true;;
//       notifyListeners();
//       debugPrint(event.snapshot.value.toString());
//     }
//   }, onError: (error) {});
// }
//
  updateOrder(orderId, status) async {
    log('MK: deactivating order');
    database.ref('orders/${orderId}').update({"status": status});
  }
  deactiveOrder(riderId) async {
    log('MK: deactivating order');
  database.ref('riders/${riderId}/new_order').update({"check": true});
}
// setMessageNotification({required userId, required count, required message}){
//   print('users/${userId}/chat_notifications');
//   database.ref('users/${userId}/chat_notifications').set({"count": count,"message":"${message}"});
// }

}
