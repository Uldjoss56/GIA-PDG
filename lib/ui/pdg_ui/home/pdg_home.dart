import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gia_pdg_partenaire/const/colors.dart';
import 'package:gia_pdg_partenaire/datas/datas.dart';
import 'package:gia_pdg_partenaire/models/other_models.dart';
import 'package:gia_pdg_partenaire/models/user.dart';
import 'package:gia_pdg_partenaire/provider/other_provider.dart';
import 'package:gia_pdg_partenaire/provider/user_provider.dart';

class PDGHome extends ConsumerStatefulWidget {
  const PDGHome({super.key});

  @override
  ConsumerState<PDGHome> createState() => _PDGHomeState();
}

class _PDGHomeState extends ConsumerState<PDGHome> {
  List<bool> status = homeHeaderDatas.map((e) => false).toList();
  User? currentUser;
  List<Country> listOfCountries = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    currentUser = ref.watch(userProvider);
    listOfCountries = ref.watch(countriesProvider);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Card(
              elevation: 5,
              child: ListTile(
                leading: Image.asset("assets/img/logo/logo.png"),
                title: RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: "Bienvenue,",
                        style: TextStyle(
                          fontFamily: "Manrope",
                          fontWeight: FontWeight.w600,
                          //fontSize: 20,
                          color: myPink,
                        ),
                      ),
                      TextSpan(
                        text: "\n M. ${currentUser?.name ?? ""}",
                        style: const TextStyle(
                          fontFamily: "Manrope",
                          fontWeight: FontWeight.w900,
                          fontSize: 16,
                          color: myPink,
                        ),
                      ),
                      const TextSpan(
                        text: "\nPDG de GIA",
                        style: TextStyle(
                          fontFamily: "Manrope",
                          fontWeight: FontWeight.w600,
                          //fontSize: 20,
                          color: myPink,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Expanded(
            child: GridView.count(
              primary: false,
              padding: const EdgeInsets.all(20),
              crossAxisSpacing: 20,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
              children: List.generate(pdgOptions.length, (int index) {
                final option = pdgOptions[index];
                return GridTile(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) {
                          return option["route"];
                        }),
                      );
                    },
                    child: Card(
                      color: myWhite,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            option["img"],
                            fit: BoxFit.fitWidth,
                            height: 0.3 * width,
                            width: 0.6 * width,
                          ),
                          Text(
                            option["title"],
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontFamily: "Manrope-Regular",
                              fontWeight: FontWeight.w700,
                              color: myGrisFonce,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
