import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gia_pdg_partenaire/const/colors.dart';
import 'package:gia_pdg_partenaire/datas/datas.dart';
import 'package:gia_pdg_partenaire/provider/notifications_provider.dart';

class CustomBottomNavigator extends ConsumerStatefulWidget {
  const CustomBottomNavigator({
    super.key,
    required this.takeCurrentIndex,
  });
  final void Function(int currentIndex) takeCurrentIndex;
  @override
  ConsumerState<CustomBottomNavigator> createState() =>
      _CustomBottomNavigatorState();
}

class _CustomBottomNavigatorState extends ConsumerState<CustomBottomNavigator> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final unreadNotifs = ref.watch(unreadNotifProvider);
    return BottomNavigationBar(
      unselectedItemColor: myWhite,
      selectedItemColor: myWhite,
      showUnselectedLabels: true,
      elevation: 10,
      onTap: (value) {
        setState(() {
          if (value != 2) {
            _currentIndex = value;
            widget.takeCurrentIndex(value);
          }
        });
      },
      currentIndex: _currentIndex,
      items: List.generate(pdgBottomList.length, (index) {
        final bottom = pdgBottomList[index];
        final item = BottomNavigationBarItem(
          backgroundColor: myPink,
          activeIcon: CircleAvatar(
            backgroundColor: myPink01,
            child: (bottom["label"].toString().contains("Notif") &&
                    unreadNotifs.isNotEmpty)
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
                      child: bottom['active_icon'],
                    ),
                  )
                : ColorFiltered(
                    colorFilter: const ColorFilter.mode(
                      myWhite,
                      BlendMode.srcIn,
                    ),
                    child: bottom['active_icon'],
                  ),
          ),
          label: bottom['label'],
          icon: (bottom["label"].toString().contains("Notif") &&
                  unreadNotifs.isNotEmpty)
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
                    child: bottom['icon'],
                  ),
                )
              : ColorFiltered(
                  colorFilter: const ColorFilter.mode(
                    myWhite,
                    BlendMode.srcIn,
                  ),
                  child: bottom['icon'],
                ),
        );

        return item;
      }),
    );
  }
}
