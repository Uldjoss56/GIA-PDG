import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gia_pdg_partenaire/components/const/colors.dart';
import 'package:gia_pdg_partenaire/components/notification/widget/notification_tile.dart';
import 'package:gia_pdg_partenaire/components/show_info.dart';
import 'package:gia_pdg_partenaire/models/notifications.dart';
import 'package:gia_pdg_partenaire/models/orders.dart';
import 'package:gia_pdg_partenaire/models/user.dart';
import 'package:gia_pdg_partenaire/provider/dma_provider.dart';
import 'package:gia_pdg_partenaire/provider/notifications_provider.dart';
import 'package:gia_pdg_partenaire/provider/user_provider.dart';
import 'package:gia_pdg_partenaire/services/const.dart';
import 'package:gia_pdg_partenaire/services/dma_service.dart';
import 'package:gia_pdg_partenaire/services/notifications_service.dart';
import 'package:gia_pdg_partenaire/services/users_service.dart';

class NotificationPage extends ConsumerStatefulWidget {
  const NotificationPage({
    super.key,
    this.unreadNotifications,
    this.readNotifications,
  });

  final List<UserNotification>? unreadNotifications;
  final List<UserNotification>? readNotifications;

  @override
  ConsumerState<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends ConsumerState<NotificationPage> {
  User? _user;
  List<User> _allUsers = [];

  final _userService = UserService();

  List<UserNotification> _unreadUserNotifications = [];
  List<UserNotification> _readUserNotifications = [];

  bool _isLoading = true;

  final _notificationsService = NotificationService();

  final _dmaService = DmaService();

  List<OrderData> listOrder = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    loadAllUsers();
    loadReadNotifications();
    loadUnReadNotifications();
    dmaOrders();
  }

  @override
  Widget build(BuildContext context) {
    _readUserNotifications = ref.watch(readNotifProvider);
    _unreadUserNotifications = ref.watch(unreadNotifProvider);
    _allUsers = ref.watch(allUsersProvider);

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(5),
          padding: const EdgeInsets.all(15),
          decoration: const BoxDecoration(
            color: myGris,
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              if (_isLoading)
                const Center(
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                    ),
                  ),
                )
              else if (_unreadUserNotifications.isEmpty &&
                  _readUserNotifications.isEmpty)
                const Center(
                  child: Text(
                    "Aucune notification",
                    style: TextStyle(
                      fontFamily: "Manrope",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              if (_unreadUserNotifications.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Non lues",
                      style: TextStyle(
                        fontFamily: "Manrope",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    notifListWidget(_unreadUserNotifications),
                  ],
                ),
              if (_readUserNotifications.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Déjà lues",
                      style: TextStyle(
                        fontFamily: "Manrope",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    notifListWidget(_readUserNotifications),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  Column notifListWidget(List<UserNotification> userNotifications) {
    return Column(
      children: List.generate(userNotifications.length, (index) {
        final notification = userNotifications[index];
        if (notification.type!.contains("CmdNotification")) {
          return NotificationTile(
            notification: notification,
          );
        } else if (notification.type!.contains("ValidInscription")) {
          for (User myUser in _allUsers) {
            if (myUser.id == notification.data?.userId) {
              _user = myUser;
            }
          }
          return NotificationTile(
            notification: notification,
            user: _user,
          );
        } else {
          return NotificationTile(
            notification: notification,
          );
        }
      }),
    );
  }

  loadReadNotifications() async {
    final internetConnexion = await checkUserConnexion();
    if (internetConnexion) {
      setState(() {
        _isLoading = true;
      });
      try {
        final response = await _notificationsService.getReadNotifications();
        final readNotifNotifier = ref.read(readNotifProvider.notifier);
        readNotifNotifier.updateUserNotif(response.notifications!);
        setState(() {
          _readUserNotifications = response.notifications!;
        });
      } on DioException catch (e) {
        // ignore: use_build_context_synchronously
        messenger(context, e.response!.data["message"]);
        return List.empty();
      } finally {
        setState(() {
          _isLoading = false;
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
        _isLoading = true;
      });
      try {
        final response = await _notificationsService.getUnreadNotifications();
        final unreadNotifNotifier = ref.read(unreadNotifProvider.notifier);
        unreadNotifNotifier.updateUserNotif(response.notifications!);
        setState(() {
          _unreadUserNotifications = response.notifications!;
        });
      } on DioException catch (e) {
        // ignore: use_build_context_synchronously
        messenger(context, e.response!.data["message"]);
        return List.empty();
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      // ignore: use_build_context_synchronously
      messenger(context, "Connectez-vous à internet");
      return List.empty();
    }
  }

  dmaOrders() async {
    final internetConnexion = await checkUserConnexion();
    if (internetConnexion) {
      setState(() {
        _isLoading = true;
      });
      try {
        final orderData = await _dmaService.getDMAOrders();

        final orderDataNotifier = ref.read(orderDataProvider.notifier);
        orderDataNotifier.updateOrderData(orderData);
      } on DioException catch (e) {
        // ignore: use_build_context_synchronously
        messenger(context, e.response!.data["message"]);
        return List.empty();
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      // ignore: use_build_context_synchronously
      messenger(context, "Connectez-vous à internet");
      return List.empty();
    }
  }

  loadAllUsers() async {
    final internetConnexion = await checkUserConnexion();
    if (internetConnexion) {
      setState(() {
        _isLoading = true;
      });
      try {
        final response = await _userService.getAllUsers();
        final users = response["users"]["data"];

        final allusersNotifier = ref.read(allUsersProvider.notifier);

        final allUsers = (users as List).map((user) {
          return User.fromJson(user);
        }).toList();

        allusersNotifier.updateAllUsers(allUsers);
      } on DioException catch (e) {
        // ignore: use_build_context_synchronously
        messenger(context, e.response!.data["message"]);
        return List.empty();
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      // ignore: use_build_context_synchronously
      messenger(context, "Connectez-vous à internet");
      return List.empty();
    }
  }
}
