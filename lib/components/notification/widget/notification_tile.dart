import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gia_pdg_partenaire/components/const/colors.dart';
import 'package:gia_pdg_partenaire/components/const/number.dart';
import 'package:gia_pdg_partenaire/components/show_info.dart';
import 'package:gia_pdg_partenaire/components/validation_inscription/validate_registration.dart';
import 'package:gia_pdg_partenaire/components/validation_order/validate_order.dart';
import 'package:gia_pdg_partenaire/datas/datas.dart';
import 'package:gia_pdg_partenaire/models/notifications.dart';
import 'package:gia_pdg_partenaire/models/user.dart';
import 'package:gia_pdg_partenaire/provider/notifications_provider.dart';
import 'package:gia_pdg_partenaire/services/const.dart';
import 'package:gia_pdg_partenaire/services/notifications_service.dart';

class NotificationTile extends ConsumerStatefulWidget {
  const NotificationTile({
    super.key,
    required this.notification,
    this.user,
  });
  final UserNotification notification;
  final User? user;

  @override
  ConsumerState<NotificationTile> createState() => _NotificationTileState();
}

class _NotificationTileState extends ConsumerState<NotificationTile> {
  bool isLoading = false;

  final _notificationsService = NotificationService();

  UserNotification? userNotif;
  String? notifTitle;
  String? notifContent;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    userNotif = widget.notification;
    final notifKey = userNotif!.type!.split("\\")[2];
    for (var notif in notifData) {
      if (notif["key"] == notifKey) {
        setState(() {
          notifTitle = notif["title"];
          notifContent = notif["content"];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 10,
      ),
      decoration: BoxDecoration(
        color: myWhite,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            offset: Offset(0, 0),
            blurRadius: 1,
            spreadRadius: 0.1,
            color: myGrisFonce22,
          ),
        ],
      ),
      child: ListTile(
        onTap: () {
          if (userNotif!.readAt == null) {
            markedAsRead();
          }
          if (userNotif!.type!.contains("CmdNotification")) {
            if (userNotif?.data?.orderId != null) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) {
                  return ValidateOrder(
                    orderID: userNotif!.data!.orderId!,
                  );
                }),
              );
            }
          } else if (userNotif!.type!.contains("ValidInscription")) {
            if (widget.user != null) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) {
                  return ValidateRegistration(
                    user: widget.user!,
                  );
                }),
              );
            }
          }
        },
        leading: Image.asset(
          notificationData[0]["imgPath"],
        ),
        title: Text(
          notifTitle ?? "",
          style: const TextStyle(
            fontFamily: "Manrope",
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              notifContent ?? "",
              maxLines: 2,
              style: const TextStyle(
                fontFamily: "Manrope",
                fontWeight: FontWeight.w500,
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                dateFormatDH.format(
                  (widget.notification.createdAt ?? DateTime.now()).add(
                    const Duration(hours: 1),
                  ),
                ),
                style: const TextStyle(
                  fontFamily: "Manrope",
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
        trailing: widget.notification.readAt == null
            ? Container(
                width: 10,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: myPink,
                ),
              )
            : null,
      ),
    );
  }

  markedAsRead() async {
    final internetConnexion = await checkUserConnexion();
    if (internetConnexion) {
      setState(() {
        isLoading = true;
      });
      try {
        await _notificationsService.markNotificationsAsRead(userNotif!.id!);
        loadReadNotifications();
        loadUnReadNotifications();
      } on DioException catch (e) {
        // ignore: use_build_context_synchronously
        messenger(context, e.response!.data["message"]);
        return List.empty();
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    } else {
      // ignore: use_build_context_synchronously
      messenger(context, "Connectez-vous à internet");
      return List.empty();
    }
  }

  loadReadNotifications() async {
    final internetConnexion = await checkUserConnexion();
    if (internetConnexion) {
      setState(() {
        isLoading = true;
      });
      try {
        final response = await _notificationsService.getReadNotifications();
        final readNotifNotifier = ref.read(readNotifProvider.notifier);
        readNotifNotifier.updateUserNotif(response.notifications!);
      } on DioException catch (e) {
        // ignore: use_build_context_synchronously
        messenger(context, e.response!.data["message"]);
        return List.empty();
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    } else {
      // ignore: use_build_context_synchronously
      messenger(context, "Connectez-vous à internet");
      return List.empty();
    }
  }

  loadUnReadNotifications() async {
    final internetConnexion = await checkUserConnexion();
    if (internetConnexion) {
      setState(() {
        isLoading = true;
      });
      try {
        final response = await _notificationsService.getUnreadNotifications();
        final unreadNotifNotifier = ref.read(unreadNotifProvider.notifier);
        unreadNotifNotifier.updateUserNotif(response.notifications!);
      } on DioException catch (e) {
        // ignore: use_build_context_synchronously
        messenger(context, e.response!.data["message"]);
        return List.empty();
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    } else {
      // ignore: use_build_context_synchronously
      messenger(context, "Connectez-vous à internet");
      return List.empty();
    }
  }
}
