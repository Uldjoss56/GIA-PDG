import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gia_pdg_partenaire/const/colors.dart';
import 'package:gia_pdg_partenaire/datas/datas.dart';
import 'package:gia_pdg_partenaire/models/other_models.dart';
import 'package:gia_pdg_partenaire/models/user.dart';
import 'package:gia_pdg_partenaire/provider/other_provider.dart';
import 'package:gia_pdg_partenaire/ui/pdg_ui/liste_assist/assist_list.dart';
import 'package:gia_pdg_partenaire/ui/pdg_ui/liste_distributeur/distributeur_list.dart';
import 'package:gia_pdg_partenaire/ui/pdg_ui/liste_distributeur_pays/distributeur_pays_list.dart';
import 'package:gia_pdg_partenaire/ui/pdg_ui/liste_vendeur/seller_list.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  List<bool> status = homeHeaderDatas.map((e) => false).toList();
  User? currentUser;
  List<Country> listOfCountries = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
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
                return GridTile(
                  child: GestureDetector(
                    onTap: () {
                      index == 0
                          ? Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) {
                                return const SellerList();
                              }),
                            )
                          : index == 1
                              ? Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context) {
                                    return const DistributeurList();
                                  }),
                                )
                              : index == 2
                                  ? Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                        return const DistributeurPaysList();
                                      }),
                                    )
                                  : Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                        return const AssistList();
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
                            pdgOptionsImg[index],
                            fit: BoxFit.fitWidth,
                            height: 0.3 * width,
                            width: 0.6 * width,
                          ),
                          Text(
                            pdgOptions[index],
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
          /*
          Expanded(
            child: ListView(
              children: [
                ExpansionPanelList(
                  elevation: 0,
                  dividerColor: myPink0122,
                  expandIconColor: myPink,
                  expansionCallback: (panelIndex, isExpanded) {
                    setState(() {
                      status[panelIndex] = isExpanded;
                    });
                  },
                  children: List.generate(homeHeaderDatas.length, (index) {
                    final homeHeader = homeHeaderDatas[index];
                    return ExpansionPanel(
                      canTapOnHeader: true,
                      headerBuilder: (context, isExpanded) {
                        return ListTile(
                          title: Text(
                            homeHeader,
                            style: const TextStyle(
                              fontFamily: "Manrope",
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: myGrisFonce,
                            ),
                          ),
                        );
                      },
                      body: Column(
                        children: index == 0
                            ? List.generate(countriesList.length, (subIndex) {
                                return Container(
                                  margin: const EdgeInsets.only(
                                    left: 10,
                                    right: 10,
                                    bottom: 10,
                                  ),
                                  padding: const EdgeInsets.all(20.0),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: myGrisFonceAA,
                                      width: 0.5,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: myPink,
                                        radius: 0.1 * width,
                                        child: ClipOval(
                                          child: AspectRatio(
                                            aspectRatio: 1,
                                            child: Image.asset(
                                              "assets/img/user_image.jpg",
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 20),
                                      const Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "DJOSSOU Comlan",
                                              style: TextStyle(
                                                fontFamily: "Manrope",
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                                color: myPink,
                                              ),
                                            ),
                                            Text(
                                              "uldjoss56@gmail.com",
                                              style: TextStyle(
                                                fontFamily: "Manrope",
                                                fontSize: 12,
                                                color: myGrisFonce,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              "Distributeur Pays",
                                              style: TextStyle(
                                                fontFamily: "Manrope",
                                                fontSize: 14,
                                                fontWeight: FontWeight.w800,
                                                color: myPink,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 20),
                                      SizedBox(
                                        width: 0.15 * width,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            ClipOval(
                                              child: Image.asset(
                                                countriesList[subIndex]["img"],
                                                fit: BoxFit.cover,
                                                width: 30,
                                                height: 30,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              countriesList[subIndex]["noum"],
                                              textAlign: TextAlign.end,
                                              style: const TextStyle(
                                                fontFamily: "Manrope",
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: myGrisFonce,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              })
                            : List.generate(2, (index) {
                                return Container(
                                  margin: const EdgeInsets.only(
                                    left: 10,
                                    right: 10,
                                    bottom: 20,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: myPink,
                                  ),
                                  child: Column(
                                    children: [
                                      ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20),
                                        ),
                                        child: Image.asset(
                                          otherServiceData[index]["imgPath"],
                                          width: width,
                                          height: 0.3 * width,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            left: 10,
                                            right: 10,
                                          ),
                                          child: Text(
                                            otherServiceData[index]["title"],
                                            style: const TextStyle(
                                              color: myWhite,
                                              fontFamily: "Manrope",
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            right: 10,
                                          ),
                                          child: ElevatedButton(
                                            onPressed: () {},
                                            child: const Icon(
                                              Icons.arrow_forward,
                                              size: 20,
                                              weight: 100,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                );
                              }),
                      ),
                      isExpanded: status[index],
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          */
        ],
      ),
    );
  }
}
