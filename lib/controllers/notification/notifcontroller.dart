import 'package:get/get.dart';

import '../../socket/socket.dart';
import '../../sources/api/notification/notification.dart';

class NotificationController extends GetxController {
  RxList<String> notifs = <String>[].obs;
  RxList<String> instructorNotifs = <String>[].obs;
  RxInt newNotifications = 0.obs;

  void listenNotifications() {
    IDanceSocket.socket!.on("send-notification", (data) {
      print("received a socker ${data.toString()}");
      notifs.insert(0, data['msg']);
      newNotifications.value++;
    });

    IDanceSocket.socket!.on("send-student-notification", (data) {
      print("received a socker ${data.toString()}");
      notifs.insert(0, data['msg']);
      newNotifications.value++;
    });

    IDanceSocket.socket!.on("send-rejectcancel-notification", (data) {
      print("received a socker ${data.toString()}");
      notifs.insert(0, data['msg']);
      newNotifications.value++;
    });

    IDanceSocket.socket!.on("send-acceptcancel-notification", (data) {
      print("received a socker ${data.toString()}");
      notifs.insert(0, data['msg']);
      newNotifications.value++;
    });

    IDanceSocket.socket!.on("send-cancelbooking-notification", (data) {
      print("received a socker ${data.toString()}");
      notifs.insert(0, data['msg']);
      newNotifications.value++;
    });
  }

  Future<bool> getNotificationsOfUser(String id, int type) async {
    notifs.clear();
    try {
      final response = await NotificationAPI.getNotificationsOfUser(id);
      print(response);
      for (int i = 0; i < response.length; i++) {
        if (response[i]['notif_type'] == type) {
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
