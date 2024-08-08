import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gia_pdg_partenaire/components/const/colors.dart';
import 'package:gia_pdg_partenaire/components/const/number.dart';
import 'package:gia_pdg_partenaire/components/show_info.dart';
import 'package:gia_pdg_partenaire/models/user.dart';
import 'package:gia_pdg_partenaire/provider/user_provider.dart';
import 'package:gia_pdg_partenaire/services/const.dart';
import 'package:gia_pdg_partenaire/services/users_service.dart';

class Stock extends ConsumerStatefulWidget {
  const Stock({super.key});

  @override
  ConsumerState<Stock> createState() => _StockState();
}

class _StockState extends ConsumerState<Stock> {
  bool isSelectedIn = true;

  User? currentUser;

  int numberIn = 0;
  int numberOut = 0;

  bool isLoading = false;

  final _userService = UserService();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadCurrentUserData();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    currentUser = ref.watch(userProvider);

    return Scaffold(
        backgroundColor: myPink,
        appBar: AppBar(
          title: const Text(
            "Stock",
            style: TextStyle(
              fontFamily: "Manrope",
              fontWeight: FontWeight.w600,
            ),
          ),
          backgroundColor: myPink,
          foregroundColor: myWhite,
        ),
        body: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: width * 0.1,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "TOTAL",
                      style: TextStyle(
                        fontFamily: "Manrope",
                        color: myWhite,
                        fontSize: 25,
                      ),
                    ),
                    Text(
                      moneyFormat.format(double.parse(currentUser?.stock ?? "0")),
                      style: const TextStyle(
                        fontFamily: "Manrope",
                        color: myWhite,
                        fontSize: 35,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: width * 0.1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (isSelectedIn) {
                            isSelectedIn = isSelectedIn;
                          } else {
                            isSelectedIn = !isSelectedIn;
                          }
                        });
                      },
                      child: Container(
                        height: 60,
                        width: width / 2.5,
                        decoration: BoxDecoration(
                          color: isSelectedIn ? myWhite : myPink01,
                          shape: BoxShape.rectangle,
                          borderRadius: const BorderRadius.horizontal(
                              left: Radius.circular(100),
                              right: Radius.circular(100)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(4),
                              child: Icon(
                                Icons.call_received_rounded,
                                color: isSelectedIn ? myGrisFonce : myWhite,
                              ),
                            ),
                            Text(
                              "Entrées",
                              style: TextStyle(
                                color: isSelectedIn ? myGrisFonce : myWhite,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (isSelectedIn) {
                            isSelectedIn = !isSelectedIn;
                          } else {
                            isSelectedIn = isSelectedIn;
                          }
                        });
                      },
                      child: Container(
                        height: 60,
                        width: width / 2.5,
                        decoration: BoxDecoration(
                          color: isSelectedIn ? myPink01 : myWhite,
                          shape: BoxShape.rectangle,
                          borderRadius: const BorderRadius.horizontal(
                              left: Radius.circular(100),
                              right: Radius.circular(100)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Icon(
                                Icons.call_made_rounded,
                                color: isSelectedIn ? myWhite : myGrisFonce,
                              ),
                            ),
                            Text(
                              "Sorties",
                              style: TextStyle(
                                color: isSelectedIn ? myWhite : myGrisFonce,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Expanded(
              child: Container(
                height: 600,
                decoration: const BoxDecoration(
                  color: myGris,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.only(right: 8.0, left: 8.0, top: 18),
                  child: isSelectedIn
                      ? numberIn == 0
                          ? SizedBox(
                              width: width,
                              child: const Center(
                                child: Text(
                                  "Aucun bénéfice",
                                  style: TextStyle(
                                    fontFamily: "Manrope",
                                  ),
                                ),
                              ),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              itemCount: 0,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      right: 12, left: 12, bottom: 18),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      shape: BoxShape.rectangle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: myWhite.withOpacity(0.5),
                                          spreadRadius: 5,
                                          blurRadius: 0,
                                          offset: const Offset(0, 3),
                                        )
                                      ],
                                    ),
                                    child: ListTile(
                                      leading: Container(
                                        width: 45,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: myPink,
                                        ),
                                      ),
                                      title: Text(
                                        'DMA ${index + 1}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: const Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 2),
                                          Text(
                                            "Jan 30, 23:18",
                                            style: TextStyle(
                                              color: myGrisFonceAA,
                                            ),
                                          ),
                                        ],
                                      ),
                                      trailing: const Text(
                                        "\$84.95",
                                        textScaler: TextScaler.linear(2),
                                      ),
                                      onTap: () {},
                                    ),
                                  ),
                                );
                              },
                            )
                      : numberOut == 0
                          ? SizedBox(
                              width: width,
                              child: const Center(
                                child: Text(
                                  "Aucun bénéfice",
                                  style: TextStyle(
                                    fontFamily: "Manrope",
                                  ),
                                ),
                              ),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: 0,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      right: 12, left: 12, bottom: 18),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      shape: BoxShape.rectangle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: myWhite.withOpacity(0.5),
                                          spreadRadius: 5,
                                          blurRadius: 0,
                                          offset: const Offset(0, 3),
                                        )
                                      ],
                                    ),
                                    child: ListTile(
                                      leading: Container(
                                        width: 45,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: myPink,
                                        ),
                                      ),
                                      title: Text(
                                        'DMA ${index + 1}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: const Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 2),
                                          Text(
                                            "Fev 30, 23:18",
                                            style: TextStyle(
                                              color: myGrisFonceAA,
                                            ),
                                          ),
                                        ],
                                      ),
                                      trailing: const Text(
                                        "\$54.95",
                                        textScaler: TextScaler.linear(2),
                                      ),
                                      onTap: () {},
                                    ),
                                  ),
                                );
                              },
                            ),
                ),
              ),
            )
          ],
        ));
  }

  loadCurrentUserData() async {
    final internetConnexion = await checkUserConnexion();
    if (internetConnexion) {
      setState(() {
        isLoading = true;
      });
      try {
        final response = await _userService.getUserProfile();

        final userNotifier = ref.read(userProvider.notifier);
        userNotifier.updateUser(response);
      } on DioException catch (e) {
        // ignore: use_build_context_synchronously
        messenger(context, e.response!.data["message"]);
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    } else {
      // ignore: use_build_context_synchronously
      messenger(context, "Connectez-vous à internet");
    }
  }
}
