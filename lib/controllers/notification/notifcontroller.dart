import 'package:get/get.dart';

import '../../socket/socket.dart';
import '../../sources/api/notification/notification.dart';

class NotificationController extends GetxController{
  RxList<String> notifs = <String>[].obs;
  RxList<String> instructorNotifs = <String>[].obs;


  void listenNotifications(){
    IDanceSocket.socket!.on("send-notification", (data) { 
      print("received a socker ${data.toString()}");
      notifs.insert(0,"${data['name']} added a new booking");
    });
  }

  Future<bool> getNotificationsOfUser(String id, int type) async {
    notifs.clear();
    try {
      final response = await NotificationAPI.getNotificationsOfUser(id);
      print(response);
      for(int i = 0; i < response.length; i++){
        if(response[i]['notif_type'] == type){
          notifs.insert(0, response[i]['msg']);
        }
      }
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

}