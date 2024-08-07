import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gia_pdg_partenaire/components/const/colors.dart';
import 'package:gia_pdg_partenaire/components/const/number.dart';
import 'package:gia_pdg_partenaire/components/show_info.dart';
import 'package:gia_pdg_partenaire/datas/datas.dart';
import 'package:gia_pdg_partenaire/models/user.dart';
import 'package:gia_pdg_partenaire/provider/user_provider.dart';
import 'package:gia_pdg_partenaire/services/const.dart';
import 'package:gia_pdg_partenaire/services/users_service.dart';
import 'package:gia_pdg_partenaire/ui/pdg_ui/liste_vendeur/seller/seller_detail.dart';

class DistributeurDetail extends ConsumerStatefulWidget {
  const DistributeurDetail({
    super.key,
    required this.user,
  });

  final User user;

  @override
  ConsumerState<DistributeurDetail> createState() => _DistributeurDetailState();
}

class _DistributeurDetailState extends ConsumerState<DistributeurDetail> {
  bool statuthistory = false;

  bool isLoading = false;

  User? dist;

  final _userService = UserService();

  List<User> distSellers = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    dist = widget.user;
    await loadUserSeller(dist!.id!);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
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
          "Distributeur ${numberFormat.format((widget.user.id ?? 0) + 1)}",
          style: const TextStyle(
            fontFamily: 'Manrope-SemiBold',
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
                          "assets/img/icons/profile.png",
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
                          dist?.name ?? "-----",
                          style: const TextStyle(
                            fontFamily: "Manrope",
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: myPink,
                          ),
                        ),
                        Text(
                          dist?.email ?? "-----",
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
                          "Distributeur",
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
                          countriesList[(dist?.countryId ?? 1) - 1]["img"],
                          fit: BoxFit.cover,
                          width: 20,
                          height: 20,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        countriesList[(dist?.countryId ?? 1) - 1]["noum"],
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
              height: 10,
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
                Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const Text(
                          "aujourd'hui",
                          style: TextStyle(
                            fontFamily: "Manrope",
                            fontWeight: FontWeight.w400,
                            color: myGrisFonceAA,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Row(
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
                                  "-- DMA",
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
                                  "-- DMA",
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
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                const Text(
                                  "Total restant",
                                  style: TextStyle(
                                    fontFamily: "Manrope",
                                    fontWeight: FontWeight.w600,
                                    color: myGrisFonce,
                                  ),
                                ),
                                Text(
                                  "${moneyFormat.format(double.parse(dist?.stock ?? "0"))} DMAs",
                                  style: const TextStyle(
                                    fontFamily: "Manrope",
                                    fontWeight: FontWeight.w800,
                                    fontSize: 18,
                                    color: myPink,
                                  ),
                                ),
                              ],
                            ),
                            const Column(
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
                                  "-- DMA",
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
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
            const SizedBox(height: 20),
            ExpansionPanelList(
                elevation: 0,
                dividerColor: myPink0122,
                expandIconColor: myPink,
                expansionCallback: (panelIndex, isExpanded) {
                  setState(() {
                    statuthistory = isExpanded;
                  });
                },
                children: [
                  ExpansionPanel(
                    headerBuilder: (context, isExpanded) {
                      return ListTile(
                        leading: ColorFiltered(
                          colorFilter: const ColorFilter.mode(
                            myPink,
                            BlendMode.srcIn,
                          ),
                          child: Image.asset(
                            "assets/img/icons/list.png",
                            width: 0.08 * width,
                          ),
                        ),
                        title: const Text(
                          "Liste de vendeurs",
                          style: TextStyle(
                            color: myPink,
                            fontSize: 20,
                            fontFamily: "Manrope",
                          ),
                        ),
                      );
                    },
                    body: Column(
                      children: List.generate(distSellers.length, (subIndex) {
                        final seller = distSellers[subIndex];
                        return ListTile(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) {
                                return SellerDetail(
                                  sellerIndex: subIndex,
                                );
                              }),
                            );
                          },
                          leading: CircleAvatar(
                            backgroundColor: myPink,
                            child: ClipOval(
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: Image.asset(
                                  "assets/img/icons/profile.png",
                                  fit: BoxFit.fitWidth,
                                  height: 0.079 * width,
                                  width: 0.079 * width,
                                ),
                              ),
                            ),
                          ),
                          title: Text(
                            seller.name ?? "",
                          ),
                          subtitle: const Text("vendeur"),
                        );
                      }),
                    ),
                    isExpanded: statuthistory,
                  ),
                ]),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  loadUserSeller(int distID) async {
    final internetConnexion = await checkUserConnexion();
    if (internetConnexion) {
      setState(() {
        isLoading = true;
      });
      try {
        final response = await _userService.getUsersByRole(
          {
            "role_id": 9,
          },
        );
        final users = response["users"];
        distSellers = [];
        for (var user in users) {
          if (user["valider_id"] == distID) {
            distSellers.add(
              User.fromJson(user),
            );
          }
        }
        final sellerNotifier = ref.read(sellersProvider.notifier);
        sellerNotifier.updateListUser(distSellers);
      } on DioException catch (e) {
        // ignore: use_build_context_synchronously
        messenger(context, e.response!.data["message"]);
        return List.empty();
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    } else {
      // ignore: use_build_context_synchronously
      messenger(context, "Connectez-vous à internet");
      return List.empty();
    }
  }
}
