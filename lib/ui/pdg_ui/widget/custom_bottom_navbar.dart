import 'package:flutter/material.dart';
import 'package:gia_pdg_partenaire/const/colors.dart';

class CustomBottomNavigator extends StatefulWidget {
  const CustomBottomNavigator({
    super.key,
    required this.bottomData,
    required this.takeCurrentIndex,
  });
  final List<Map<String, dynamic>> bottomData;
  final void Function(int currentIndex) takeCurrentIndex;
  @override
  State<CustomBottomNavigator> createState() => _CustomBottomNavigatorState();
}

class _CustomBottomNavigatorState extends State<CustomBottomNavigator> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
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
      items: List.generate(widget.bottomData.length, (index) {
        var item = BottomNavigationBarItem(
          backgroundColor: myPink,
          activeIcon: CircleAvatar(
            backgroundColor: myPink,
            child: ColorFiltered(
              colorFilter: const ColorFilter.mode(
                myWhite,
                BlendMode.srcIn,
              ),
              child: widget.bottomData[index]['active_icon'],
            ),
          ),
          label: widget.bottomData[index]['label'],
          icon: ColorFiltered(
            colorFilter: const ColorFilter.mode(
              myWhite,
              BlendMode.srcIn,
            ),
            child: widget.bottomData[index]['icon'],
          ),
        );

        return item;
      }),
    );
  }
}
