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
  bool selectAll = false;
  List<User> sellers = [];
  List<User> dists = [];
  List<User> distPays = [];
  User? distOff;
  User? pdg;
  User? currentUser;

  final _userService = UserService();

  List<UserNotification> unreadUserNotifications = [];
  List<UserNotification> readUserNotifications = [];

  bool isLoading = true;

  final _notificationsService = NotificationService();

  final _dmaService = DmaService();

  List<OrderData> listOrder = [];

  User? _user;

  List<User> myUsers = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    currentUser = ref.watch(userProvider);
    switch (currentUser?.roleId) {
      case 1:
        loadUserSeller();
        loadUserdist();
        loadUserdistPays();
        loadUserdistOff();
        break;
      case 2:
        loadUserSeller();
        loadUserdist();
        loadUserdistPays();
        break;
      case 4:
        loadUserSeller();
        loadUserdist();
        break;
      case 6:
        loadUserSeller();
        break;
      default:
    }

    loadReadNotifications();
    loadUnReadNotifications();
    dmaOrders();
  }

  @override
  Widget build(BuildContext context) {
    readUserNotifications = ref.watch(readNotifProvider);
    unreadUserNotifications = ref.watch(unreadNotifProvider);
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
              if (isLoading)
                const Center(
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                    ),
                  ),
                )
              else if (unreadUserNotifications.isEmpty &&
                  readUserNotifications.isEmpty)
                const Center(
                  child: Text(
                    "Aucune notification",
                    style: TextStyle(
                      fontFamily: "Manrope",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              if (unreadUserNotifications.isNotEmpty)
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
                    notifListWidget(unreadUserNotifications),
                  ],
                ),
              if (readUserNotifications.isNotEmpty)
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
                    notifListWidget(readUserNotifications),
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
          switch (currentUser?.roleId) {
            case 1:
              myUsers = [distOff!];
              break;
            case 2:
              myUsers = distPays;
              break;
            case 4:
              myUsers = dists;
              break;
            case 6:
              myUsers = sellers;
              break;
            default:
          }
          for (User myUser in myUsers) {
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
        isLoading = true;
      });
      try {
        final response = await _notificationsService.getReadNotifications();
        final readNotifNotifier = ref.read(readNotifProvider.notifier);
        readNotifNotifier.updateUserNotif(response.notifications!);
        setState(() {
          readUserNotifications = response.notifications!;
        });
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
        setState(() {
          unreadUserNotifications = response.notifications!;
        });
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

  dmaOrders() async {
    final internetConnexion = await checkUserConnexion();
    if (internetConnexion) {
      setState(() {
        isLoading = true;
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
          isLoading = false;
        });
      }
    } else {
      // ignore: use_build_context_synchronously
      messenger(context, "Connectez-vous à internet");
      return List.empty();
    }
  }

  loadUserSeller() async {
    final internetConnexion = await checkUserConnexion();
    if (internetConnexion) {
      setState(() {
        isLoading = true;
      });
      try {
        final response = await _userService.getUsersByRole(
          {
            "role_id": 9,
          },
        );
        sellers = [];
        setState(() {
          sellers = (response["users"] as List)
              .map(
                (e) => User.fromJson(e),
              )
              .toList();
        });
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

  loadUserPDG() async {
    final internetConnexion = await checkUserConnexion();
    if (internetConnexion) {
      setState(() {
        isLoading = true;
      });
      try {
        final response = await _userService.getUsersByRole(
          {
            "role_id": 1,
          },
        );
        setState(() {
          pdg = User.fromJson((response["users"] as List)[0]);
        });
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

  loadUserdist() async {
    final internetConnexion = await checkUserConnexion();
    if (internetConnexion) {
      setState(() {
        isLoading = true;
      });
      try {
        final response = await _userService.getUsersByRole(
          {
            "role_id": 6,
          },
        );
        dists = [];
        setState(() {
          dists = (response["users"] as List)
              .map(
                (e) => User.fromJson(e),
              )
              .toList();
        });
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

  loadUserdistOff() async {
    final internetConnexion = await checkUserConnexion();
    if (internetConnexion) {
      setState(() {
        isLoading = true;
      });
      try {
        final response = await _userService.getUsersByRole(
          {
            "role_id": 2,
          },
        );
        setState(() {
          distOff = User.fromJson((response["users"] as List)[0]);
        });
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

  loadUserdistPays() async {
    final internetConnexion = await checkUserConnexion();
    if (internetConnexion) {
      setState(() {
        isLoading = true;
      });
      try {
        final response = await _userService.getUsersByRole(
          {
            "role_id": 4,
          },
        );
        distPays = [];
        setState(() {
          distPays = (response["users"] as List)
              .map(
                (e) => User.fromJson(e),
              )
              .toList();
        });
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
