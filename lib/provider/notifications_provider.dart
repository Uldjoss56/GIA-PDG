import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gia_pdg_partenaire/models/notifications.dart';

class UserNotificationNotifier extends StateNotifier<List<UserNotification>> {
  UserNotificationNotifier(super.userNotif);

  void updateUserNotif(List<UserNotification> userNotif) {
    state = userNotif;
  }
}

final unreadNotifProvider =
    StateNotifierProvider<UserNotificationNotifier, List<UserNotification>>(
  (ref) => UserNotificationNotifier(
    [],
  ),
);

final readNotifProvider =
    StateNotifierProvider<UserNotificationNotifier, List<UserNotification>>(
  (ref) => UserNotificationNotifier(
    [],
  ),
);
