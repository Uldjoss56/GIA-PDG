import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gia_pdg_partenaire/components/const/number.dart';
import 'package:gia_pdg_partenaire/components/show_info.dart';
import 'package:gia_pdg_partenaire/const/colors.dart';
import 'package:gia_pdg_partenaire/models/user.dart';
import 'package:gia_pdg_partenaire/provider/user_provider.dart';
import 'package:gia_pdg_partenaire/services/const.dart';
import 'package:gia_pdg_partenaire/services/users_service.dart';

class CA extends ConsumerStatefulWidget {
  const CA({super.key});

  @override
  ConsumerState<CA> createState() => _CAState();
}

class _CAState extends ConsumerState<CA> {
   bool isLoading = false;

  User? currentUser;
  final _userService = UserService();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadCurrentUserData();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    currentUser = ref.watch(userProvider);
    return Scaffold(
      backgroundColor: myPink01,
      body: Column(
        children: [
          SizedBox(
            height: 0.4 * height,
            child: Column(
              children: [
                SizedBox(
                  height: 0.06 * height,
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.keyboard_arrow_left_rounded,
                        color: myWhite,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    const Text(
                      "Chiffre d'affaire",
                      style: TextStyle(
                        fontFamily: 'Manrope-SemiBold',
                        fontSize: 22,
                        color: myWhite,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 0.14 * height,
                ),
                Column(
                  children: [
                    const Text(
                      "TOTAL ACTU",
                      style: TextStyle(
                        color: Colors.white60,
                        fontSize: 20,
                      ),
                    ),
                    isLoading
                        ? const CircularProgressIndicator(
                            color: myWhite,
                          )
                        : Text(
                            moneyFormat.format(currentUser?.ca ?? 0),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 35,
                            ),
                          ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 0.2 * height,
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Card(
                    elevation: 2,
                    color: myPink02,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 100,
                          decoration: BoxDecoration(
                            color: myWhite,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: myPink02,
                            ),
                          ),
                          child: Center(
                            child: isLoading
                                ? const CircularProgressIndicator()
                                : Text(
                                    moneyFormat.format(currentUser?.pv ?? 0),
                                    style: const TextStyle(
                                      fontFamily: "Manrope",
                                      color: myPink01,
                                      fontSize: 35,
                                    ),
                                  ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "Prix de vente unitaire",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: "Manrope-Medium",
                              fontWeight: FontWeight.w700,
                              color: myPink01,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Card(
                    elevation: 2,
                    color: myPink02,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 100,
                          decoration: BoxDecoration(
                            color: myWhite,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: myPink02,
                            ),
                          ),
                          child: Center(
                            child: isLoading
                                ? const CircularProgressIndicator()
                                : Text(
                                    moneyFormat.format(currentUser?.b ?? 0),
                                    style: const TextStyle(
                                      fontFamily: "Manrope",
                                      color: myPink01,
                                      fontSize: 35,
                                    ),
                                  ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "Bénéfice",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: "Manrope-Medium",
                              fontWeight: FontWeight.w700,
                              color: myPink01,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
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
        messenger(
          context,
          e.response!.data["message"],
        );
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
    }
  }
}

/* 
  bool isSelectedIn = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chiffre d'Affaire"),
        backgroundColor: myPink,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: myPink,
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(60),
              ),
            ),
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 80,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Welcome, Jack",
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      Text(
                        "\$18 784.95",
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      Text(
                        "Your CA value here",
                        style: TextStyle(color: Colors.white60, fontSize: 18),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.only(
                    right: 12,
                    left: 40,
                  ),
                  child: Column(
                    children: [
                      const Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: myPink,
                            //minRadius: 26,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "mes commissions",
                                textScaler: TextScaler.linear(1.6),
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "14h ago",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 44.0, left: 20.0),
                            child: Container(
                              height: 100,
                              width: 2,
                              color: Colors.grey,
                            ),
                          ),
                          Expanded(
                            child: Container(
                              width: 300,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                shape: BoxShape.rectangle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(1),
                                    spreadRadius: 3,
                                    blurRadius: 9,
                                    offset: const Offset(5, 5),
                                  )
                                ],
                              ),
                              child: ListTile(
                                title: const Text(
                                  "\$492.30",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                subtitle: Row(
                                  children: [
                                    const Text(
                                      "via PayPal",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 80.0),
                                      child: Row(
                                        children: [
                                          const Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                Icon(
                                                  Icons.lens_outlined,
                                                  color: myPink,
                                                  size: 35,
                                                ),
                                                Icon(
                                                  Icons.close,
                                                  color: myPink,
                                                ),
                                              ]),
                                          const SizedBox(
                                            width: 18,
                                          ),
                                          GestureDetector(
                                            child: const Icon(
                                              Icons.offline_pin_rounded,
                                              color: myPink,
                                              size: 35,
                                            ),
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const ValiderPayement()),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Divider(
                        thickness: 2,
                        color: Colors.grey,
                        indent: 68,
                        endIndent: 68,
                        height: 40,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
*/
