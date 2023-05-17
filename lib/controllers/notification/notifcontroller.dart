import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../../socket/socket.dart';

class NotificationController extends GetxController{
  RxList<String> notifs = ['Notif 1', 'Notif 2', ' Notif 3'].obs;


  void listenNotifications(){
    IDanceSocket.socket!.on("send-notification", (data) { 
      print("received a socker ${data.toString()}");
      notifs.add(" added a new booking");
    });
  }
}