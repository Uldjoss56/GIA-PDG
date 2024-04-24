import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gia_pdg_partenaire/components/notification/notification_page.dart';
import 'package:gia_pdg_partenaire/components/profil/user_profil.dart';
import 'package:gia_pdg_partenaire/components/show_info.dart';
import 'package:gia_pdg_partenaire/const/colors.dart';
import 'package:gia_pdg_partenaire/datas/datas.dart';
import 'package:gia_pdg_partenaire/models/notifications.dart';
import 'package:gia_pdg_partenaire/provider/notifications_provider.dart';
import 'package:gia_pdg_partenaire/services/const.dart';
import 'package:gia_pdg_partenaire/services/notifications_service.dart';
import 'package:gia_pdg_partenaire/ui/partner_ui/distributeur_officiel/distributeur_off_detail.dart';
import 'package:gia_pdg_partenaire/ui/partner_ui/home/partner_home.dart';

class PartnerMainHome extends ConsumerStatefulWidget {
  const PartnerMainHome({
    super.key,
  });

  @override
  ConsumerState<PartnerMainHome> createState() => _PartnerMainHomeState();
}

class _PartnerMainHomeState extends ConsumerState<PartnerMainHome> {
  int _selectedIndex = 0;

  bool isLoading = false;

  final _notificationsService = NotificationService();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final unreadNotifs = ref.watch(unreadNotifProvider);
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
                  "GIA-Partenaire",
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
      body: _pages.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: myPink,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: myWhite,
        unselectedItemColor: myWhite,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: _selectedIndex == 0
                ? ColorFiltered(
                    colorFilter: const ColorFilter.mode(
                      myWhite,
                      BlendMode.srcIn,
                    ),
                    child: partnerBottomList[0]['active_icon'],
                  )
                : ColorFiltered(
                    colorFilter: const ColorFilter.mode(
                      myWhite,
                      BlendMode.srcIn,
                    ),
                    child: partnerBottomList[0]['icon'],
                  ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 1
                ? ColorFiltered(
                    colorFilter: const ColorFilter.mode(
                      myWhite,
                      BlendMode.srcIn,
                    ),
                    child: partnerBottomList[1]['active_icon'])
                : ColorFiltered(
                    colorFilter: const ColorFilter.mode(
                      myWhite,
                      BlendMode.srcIn,
                    ),
                    child: partnerBottomList[1]['icon'],
                  ),
            label: 'Distributeur Officiel',
          ),
          BottomNavigationBarItem(
            icon: unreadNotifs.isNotEmpty
                ? Badge(
                    label: Text(
                      unreadNotifs.length > 9 ? "+9" : "${unreadNotifs.length}",
                    ),
                    textStyle: const TextStyle(
                      fontFamily: "Manrope",
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: myPink01,
                    ),
                    child: ColorFiltered(
                      colorFilter: const ColorFilter.mode(
                        myWhite,
                        BlendMode.srcIn,
                      ),
                      child: partnerBottomList[2]
                          [_selectedIndex == 2 ? 'active_icon' : 'icon'],
                    ),
                  )
                : ColorFiltered(
                    colorFilter: const ColorFilter.mode(
                      myWhite,
                      BlendMode.srcIn,
                    ),
                    child: partnerBottomList[2]
                        [_selectedIndex == 2 ? 'active_icon' : 'icon'],
                  ),
            label: 'Notification',
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 3
                ? partnerBottomList[3]['active_icon']
                : ColorFiltered(
                    colorFilter: const ColorFilter.mode(
                      myWhite,
                      BlendMode.srcIn,
                    ),
                    child: partnerBottomList[3]['icon'],
                  ),
            label: 'Profil',
          ),
        ],
      ),
    );
  }

  List<Widget> get _pages => [
        const PartnerHome(),
        const DistributeurOffiDetailPartner(),
        const NotificationPage(),
        const UserProfil(),
      ];

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
        messenger(
          context,
          e.response!.data["message"],
        );
        return List.empty();
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    } else {
      // ignore: use_build_context_synchronously
      messenger(
        context,
        "Connectez-vous à internet",
      );
      return List.empty();
    }
  }
}
