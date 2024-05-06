import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gia_pdg_partenaire/components/show_info.dart';
import 'package:gia_pdg_partenaire/const/colors.dart';
import 'package:gia_pdg_partenaire/datas/datas.dart';
import 'package:gia_pdg_partenaire/models/notifications.dart';
import 'package:gia_pdg_partenaire/provider/notifications_provider.dart';
import 'package:gia_pdg_partenaire/services/const.dart';
import 'package:gia_pdg_partenaire/services/notifications_service.dart';
import 'package:gia_pdg_partenaire/ui/pdg_ui/dma/dma_authentification/dma_authentification.dart';
import 'package:gia_pdg_partenaire/ui/pdg_ui/home/pdg_home.dart';
import 'package:gia_pdg_partenaire/ui/pdg_ui/home/custom_bottom_navbar.dart';

class PdgMainHome extends ConsumerStatefulWidget {
  const PdgMainHome({super.key});

  @override
  ConsumerState<PdgMainHome> createState() => _PdgMainHomeState();
}

class _PdgMainHomeState extends ConsumerState<PdgMainHome> {
  Widget content = const PDGHome();

  bool isLoading = false;

  final _notificationsService = NotificationService();

  @override
  void initState() {
    super.initState();
    loadUnReadNotifications();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: myWhite,
      appBar: AppBar(
        elevation: 4,
        title: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  "GIA-PDG",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 0.4 * width,
                ),
                child: Container(
                  height: 4,
                  decoration: BoxDecoration(
                    color: myPink,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: content,
      floatingActionButton: AnimatedOpacity(
        opacity: 1,
        duration: const Duration(
          milliseconds: 200,
        ),
        child: Container(
          decoration: const BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 2),
                  blurRadius: 1,
                  spreadRadius: 2,
                  color: myGrisFonce22,
                )
              ],
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  myWhite,
                  myPink,
                ],
              )),
          child: IconButton(
            style: IconButton.styleFrom(
              foregroundColor: myWhite,
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) {
                  return const DMAAuthentification();
                }),
              );
            },
            icon: Image.asset(
              "assets/img/icons/scan_white.png",
              width: 0.1 * width,
              height: 0.1 * width,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        clipBehavior: Clip.antiAlias,
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        padding: const EdgeInsets.all(0),
        color: Colors.transparent,
        child: CustomBottomNavigator(
          takeCurrentIndex: (currentIndex) {
            setState(() {
              content = pdgBottomList[currentIndex]['screen'];
            });
          },
        ),
      ),
    );
  }

  loadUnReadNotifications() async {
    final internetConnexion = await checkUserConnexion();
    if (internetConnexion) {
      setState(() {
        isLoading = true;
      });
      try {
        final response = await _notificationsService.getUnreadNotifications();
        final notifs = response.notifications;
        for (UserNotification userNotif in notifs ?? []) {
          final notifKey = userNotif.type!.split("\\")[2];
          for (var notif in notifData) {
            if (notif["key"] == notifKey) {
              NotificationService().showNotification(
                title: notif["title"],
                body: notif["content"],
              );
            }
          }
        }
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
