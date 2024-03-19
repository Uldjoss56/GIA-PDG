import 'package:flutter/material.dart';
import 'package:gia_pdg_partenaire/const/colors.dart';
import '../payement_partner/validate_payement_partner.dart';

class CA extends StatefulWidget {
  const CA({super.key});

  @override
  State<CA> createState() => _CAState();
}

class _CAState extends State<CA> {
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
