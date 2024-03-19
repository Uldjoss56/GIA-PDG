import 'package:flutter/material.dart';
import 'package:gia_pdg_partenaire/components/notification/notification_page.dart';
import 'package:gia_pdg_partenaire/const/colors.dart';
import 'package:gia_pdg_partenaire/ui/partner_ui/components/custom_button.dart';
import 'package:gia_pdg_partenaire/ui/partner_ui/screen/profil_partner/user_profil_partner.dart';
import 'package:gia_pdg_partenaire/ui/partner_ui/screen/turnover/ca.dart';
import 'package:gia_pdg_partenaire/ui/pdg_ui/distributeur_officiel/distributeur_off_detail.dart';

import 'datas_partner/datas_partner.dart';

class PartnerHome extends StatefulWidget {
  const PartnerHome({
    super.key,
  });

  @override
  State<PartnerHome> createState() => _PartnerHomeState();
}

class _PartnerHomeState extends State<PartnerHome> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height -
            MediaQuery.of(context).padding.top,
        child: _pages.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: myPink,
        iconSize: 40,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 20,
        selectedItemColor: Colors.white70,
        unselectedItemColor: Colors.white,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: _selectedIndex == 0
                ? ColorFiltered(
                    colorFilter: const ColorFilter.mode(
                      myWhite,
                      BlendMode.srcIn,
                    ),
                    child: bottomList[0]['active_icon'],
                  )
                : ColorFiltered(
                    colorFilter: const ColorFilter.mode(
                      myWhite,
                      BlendMode.srcIn,
                    ),
                    child: bottomList[0]['icon'],
                  ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 1
                ? bottomList[1]['active_icon']
                : ColorFiltered(
                    colorFilter: const ColorFilter.mode(
                      myWhite,
                      BlendMode.srcIn,
                    ),
                    child: bottomList[1]['icon'],
                  ),
            label: 'Chats',
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 2
                ? ColorFiltered(
                    colorFilter: const ColorFilter.mode(
                      myWhite,
                      BlendMode.srcIn,
                    ),
                    child: bottomList[2]['active_icon'],
                  )
                : ColorFiltered(
                    colorFilter: const ColorFilter.mode(
                      myWhite,
                      BlendMode.srcIn,
                    ),
                    child: bottomList[2]['icon'],
                  ),
            label: 'Notification',
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 3
                ? bottomList[3]['active_icon']
                : ColorFiltered(
                    colorFilter: const ColorFilter.mode(
                      myWhite,
                      BlendMode.srcIn,
                    ),
                    child: bottomList[3]['icon'],
                  ),
            label: 'Person',
          ),
        ],
      ),
    );
  }

  List<Widget> get _pages => <Widget>[
        const Home(),
        const DistributeurOffiDetail(),
        const NotificationPage(),
        const PartnerProfil(),
      ];
}

class Home extends StatelessWidget {
  const Home({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        title: Column(
          children: [
            const Text(
              "GIA-Partenaires",
              style: TextStyle(
                fontFamily: "Manrope",
                fontWeight: FontWeight.w800,
                color: myPink,
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
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: myPink,
            ),
            child: Image.asset(
              "assets/img/background02.jpg",
              fit: BoxFit.cover,
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white60,
            ),
          ),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  buttonText: const Text(
                    "Distributeur Officiel",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  onpressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DistributeurOffiDetail(),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomButton(
                  buttonText: const Text(
                    "Mes commissions",
                    style: TextStyle(fontSize: 20),
                  ),
                  onpressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CA(),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
