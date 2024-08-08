import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gia_pdg_partenaire/components/const/colors.dart';
import 'package:gia_pdg_partenaire/components/const/number.dart';
import 'package:gia_pdg_partenaire/datas/datas.dart';
import 'package:gia_pdg_partenaire/models/user.dart';
import 'package:gia_pdg_partenaire/provider/user_provider.dart';

class SellerDetail extends ConsumerStatefulWidget {
  const SellerDetail({
    super.key,
    required this.sellerIndex,
  });

  final int sellerIndex;

  @override
  ConsumerState<SellerDetail> createState() => _SellerDetailState();
}

class _SellerDetailState extends ConsumerState<SellerDetail> {
  bool statuthistory = false;

  List<User> sellers = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    sellers = ref.watch(sellersProvider);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final sellerIndex = widget.sellerIndex;
    final seller = sellers[sellerIndex];
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
          "Vendeur ${numberFormat.format(sellerIndex + 1)}",
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
            Column(
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
                              "${seller.name}",
                              style: const TextStyle(
                                fontFamily: "Manrope",
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: myPink,
                              ),
                            ),
                            Text(
                              "${seller.email}",
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
                              "Vendeur",
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
                              countriesList[(seller.countryId ?? 1) - 1]["img"],
                              fit: BoxFit.cover,
                              width: 20,
                              height: 20,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            countriesList[(seller.countryId ?? 1) - 1]["noum"],
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
                                      "${moneyFormat.format(double.parse(seller.stock ?? "0"))} DMA",
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
                                      "-- DMAs",
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
                    /*
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
                    const SizedBox(
                      height: 40,
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      height: 400,
                      width: 400,
                      child: const MyLineChart(),
                    ),
                    */
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
