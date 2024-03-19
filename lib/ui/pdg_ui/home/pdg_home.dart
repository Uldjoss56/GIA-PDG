import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gia_pdg_partenaire/const/colors.dart';
import 'package:gia_pdg_partenaire/datas/datas.dart';
import 'package:gia_pdg_partenaire/ui/pdg_ui/dma/dma_authentification/dma_authentification.dart';
import 'package:gia_pdg_partenaire/ui/pdg_ui/home/home.dart';
import 'package:gia_pdg_partenaire/ui/pdg_ui/widget/custom_bottom_navbar.dart';

class PdgHome extends ConsumerStatefulWidget {
  const PdgHome({super.key});

  @override
  ConsumerState<PdgHome> createState() => _PdgHomeState();
}

class _PdgHomeState extends ConsumerState<PdgHome> {
  Widget content = const Home();
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
          bottomData: bottomList,
          takeCurrentIndex: (currentIndex) {
            setState(() {
              content = bottomList[currentIndex]['screen'];
            });
          },
        ),
      ),
    );
  }
}
