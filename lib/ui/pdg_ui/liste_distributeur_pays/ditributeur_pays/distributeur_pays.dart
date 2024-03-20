import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gia_pdg_partenaire/components/const/colors.dart';
import 'package:gia_pdg_partenaire/components/const/number.dart';
import 'package:gia_pdg_partenaire/components/show_info.dart';
import 'package:gia_pdg_partenaire/datas/datas.dart';
import 'package:gia_pdg_partenaire/models/user.dart';
import 'package:gia_pdg_partenaire/services/const.dart';
import 'package:gia_pdg_partenaire/services/users_service.dart';
import 'package:gia_pdg_partenaire/ui/pdg_ui/liste_distributeur_pays/ditributeur_pays/distributeur/distributeur_detail.dart';

class DistributeurPays extends ConsumerStatefulWidget {
  const DistributeurPays({
    super.key,
    required this.distPays,
  });

  final User distPays;

  @override
  ConsumerState<DistributeurPays> createState() => _DistributeurPaysState();
}

class _DistributeurPaysState extends ConsumerState<DistributeurPays> {
  bool isLoading = false;

  final _userService = UserService();

  List<User> dists = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadDistPaysdist();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final distPays = widget.distPays;
    return Scaffold(
      backgroundColor: myBackground,
      appBar: AppBar(
        backgroundColor: myPink01,
        foregroundColor: myGris,
        toolbarHeight: 0.2 * width,
        leading: IconButton(
          icon: const Icon(
            Icons.keyboard_arrow_left_rounded,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        title: Text(
          "Distributeur ${countriesList[(distPays.countryId ?? 1) - 1]["noum"]}",
          style: const TextStyle(
            fontFamily: 'Manrope-SemiBold',
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 20),
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: myGrisFonceAA,
                    width: 0.5,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            distPays.name ?? "---",
                            style: const TextStyle(
                              fontFamily: "Manrope",
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: myPink,
                            ),
                          ),
                          Text(
                            distPays.email ?? "---",
                            style: const TextStyle(
                              fontFamily: "Manrope",
                              fontSize: 12,
                              color: myGrisFonce,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
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
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipOval(
                          child: Image.asset(
                            countriesList[(distPays.countryId ?? 1) - 1]["img"],
                            fit: BoxFit.cover,
                            width: 20,
                            height: 20,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          countriesList[(distPays.countryId ?? 1) - 1]["noum"],
                          style: const TextStyle(
                            fontFamily: "Manrope",
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: myGrisFonce,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(
                  right: 0.6 * width,
                  left: 0.2 * width,
                ),
                child: const Divider(
                  height: 1,
                  thickness: 2,
                  color: myPink,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Gestion de stocks",
                    style: TextStyle(
                      fontFamily: "Manrope",
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: myPink,
                    ),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Card(
                    elevation: 2,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            "aujourd'hui",
                            style: TextStyle(
                              fontFamily: "Manrope",
                              fontWeight: FontWeight.w400,
                              color: myGrisFonceAA,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    "Total à l'ouverture",
                                    style: TextStyle(
                                      fontFamily: "Manrope",
                                      fontWeight: FontWeight.w600,
                                      color: myGrisFonce,
                                    ),
                                  ),
                                  Text(
                                    "50 DMAs",
                                    style: TextStyle(
                                      fontFamily: "Manrope",
                                      fontWeight: FontWeight.w800,
                                      fontSize: 18,
                                      color: myPink,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    "Total vendu",
                                    style: TextStyle(
                                      fontFamily: "Manrope",
                                      fontWeight: FontWeight.w600,
                                      color: myGrisFonce,
                                    ),
                                  ),
                                  Text(
                                    "10 DMAs",
                                    style: TextStyle(
                                      fontFamily: "Manrope",
                                      fontWeight: FontWeight.w800,
                                      fontSize: 18,
                                      color: myPink,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    "Total restant",
                                    style: TextStyle(
                                      fontFamily: "Manrope",
                                      fontWeight: FontWeight.w600,
                                      color: myGrisFonce,
                                    ),
                                  ),
                                  Text(
                                    "40 DMAs",
                                    style: TextStyle(
                                      fontFamily: "Manrope",
                                      fontWeight: FontWeight.w800,
                                      fontSize: 18,
                                      color: myPink,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    "Stock critique",
                                    style: TextStyle(
                                      fontFamily: "Manrope",
                                      fontWeight: FontWeight.w600,
                                      color: myGrisFonce,
                                    ),
                                  ),
                                  Text(
                                    "10 DMAs",
                                    style: TextStyle(
                                      fontFamily: "Manrope",
                                      fontWeight: FontWeight.w800,
                                      fontSize: 18,
                                      color: myPink,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      const Text(
                        "Entrée",
                        style: TextStyle(
                          fontFamily: "Manrope",
                          fontWeight: FontWeight.w800,
                          fontSize: 18,
                          color: myGrisFonce,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Container(
                        height: 15,
                        width: 15,
                        decoration: const BoxDecoration(
                          color: myPink,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Text(
                        "Sortie",
                        style: TextStyle(
                          fontFamily: "Manrope",
                          fontWeight: FontWeight.w800,
                          fontSize: 18,
                          color: myGrisFonce,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Container(
                        height: 15,
                        width: 15,
                        decoration: const BoxDecoration(
                          color: myBlue,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(
                  right: 0.5 * width,
                  left: 0.1 * width,
                ),
                child: const Divider(
                  height: 1,
                  thickness: 2,
                  color: myPink,
                ),
              ),
              const SizedBox(height: 20),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Liste de distributeurs",
                    style: TextStyle(
                      fontFamily: "Manrope",
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: myPink,
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: myGrisFonceAA,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Column(
                        children: List.generate(dists.length, (index) {
                          final dist = dists[index];
                          return ListTile(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) {
                                  return DistributeurDetail(
                                    dist: dist,
                                  );
                                }),
                              );
                            },
                            shape: const ContinuousRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            leading: CircleAvatar(
                              backgroundColor: myPink,
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
                            title: Text(
                              "Distributeur ${numberFormat.format(index + 1)}",
                              style: const TextStyle(
                                fontFamily: 'Manrope',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            subtitle: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  dist.name ?? "---",
                                  style: const TextStyle(
                                    fontFamily: 'Manrope',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  dist.email ?? "---",
                                  style: const TextStyle(
                                    fontFamily: 'Manrope',
                                    color: myPink,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  loadDistPaysdist() async {
    final internetConnexion = await checkUserConnexion();
    if (internetConnexion) {
      setState(() {
        isLoading = true;
      });
      try {
        final response = await _userService.getUsersByRole(
          {
            "role_id": 6,
          },
        );

        final users = response["users"];
        dists = [];
        for (var user in users) {
          if (user["valider_id"] == widget.distPays.id) {
            dists.add(
              User.fromJson(user),
            );
          }
        }
        setState(() {});
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
