import 'package:flutter/material.dart';
import 'package:gia_pdg_partenaire/const/colors.dart';

class DistributeurOffiDetail extends StatefulWidget {
  const DistributeurOffiDetail({
    super.key,
  });

  @override
  State<DistributeurOffiDetail> createState() => _DistributeurOffiDetailState();
}

class _DistributeurOffiDetailState extends State<DistributeurOffiDetail> {
  bool statuthistory = false;

  @override
  void initState() {
    super.initState();
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
        elevation: 4,
        title: Column(
          children: [
            Text(
              "Distributeur Officiel",
              style: Theme.of(context).textTheme.titleMedium,
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
                              "assets/img/user_image.jpg",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                              "Distributeur Officiel de DMA",
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
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
