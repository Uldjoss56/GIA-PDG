import 'package:flutter/material.dart';
import 'package:gia_pdg_partenaire/const/colors.dart';
import 'package:gia_pdg_partenaire/datas/datas.dart';
import 'package:gia_pdg_partenaire/ui/pdg_ui/commander_dma/cmd_detail/cmd_detail.dart';
import 'package:gia_pdg_partenaire/ui/pdg_ui/commander_dma/reception_address.dart';
import 'package:intl/intl.dart';

class CommanderDMA extends StatefulWidget {
  const CommanderDMA({super.key});

  @override
  State<CommanderDMA> createState() => _CommanderDMAState();
}

class _CommanderDMAState extends State<CommanderDMA> {
  int numbreCmde = 1;

  double montantTotal = 20000;

  final format = NumberFormat("#,###", "fr");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Commande",
          style: TextStyle(
            color: myPink,
            fontFamily: "Manrope",
            fontWeight: FontWeight.w800,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Center(
            child: Icon(
              Icons.keyboard_arrow_left_rounded,
              color: myPink,
              size: 30,
              weight: 30,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.only(
                left: 10,
                right: 10,
              ),
              decoration: BoxDecoration(
                color: myWhite,
                borderRadius: BorderRadius.circular(30),
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(0, 0),
                    blurRadius: 1,
                    spreadRadius: 0.1,
                    color: myGrisFonce22,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Nouvelle commande",
                    style: TextStyle(
                      fontFamily: "Manrope",
                      color: myPink,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: "Prix unitaire : ",
                          style: TextStyle(
                            fontFamily: "Manrope",
                            color: myGrisFonce,
                          ),
                        ),
                        TextSpan(
                          text: "XOF 20,000.00",
                          style: TextStyle(
                            fontFamily: "Manrope",
                            color: myGrisFonce,
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Text(
                        "Nbre à commander : ",
                        style: TextStyle(
                          fontFamily: "Manrope",
                          color: myGrisFonce,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Row(
                        children: [
                          Container(
                            width: 25,
                            height: 25,
                            decoration: const BoxDecoration(
                              color: myPink,
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(0, 0),
                                  blurRadius: 1,
                                  spreadRadius: 0.1,
                                  color: myGrisFonceAA,
                                ),
                              ],
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              splashRadius: 5,
                              iconSize: 20,
                              padding: const EdgeInsets.all(0),
                              onPressed: () {
                                if (numbreCmde > 1) {
                                  setState(() {
                                    --numbreCmde;
                                    montantTotal = 20000.0 * numbreCmde;
                                  });
                                }
                              },
                              icon: const Icon(
                                Icons.remove,
                                color: myWhite,
                              ),
                              style: IconButton.styleFrom(),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "$numbreCmde",
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: myGrisFonce,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: 25,
                            height: 25,
                            decoration: const BoxDecoration(
                              color: myPink,
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(0, 0),
                                  blurRadius: 1,
                                  spreadRadius: 0.1,
                                  color: myGrisFonceAA,
                                ),
                              ],
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              splashRadius: 5,
                              iconSize: 20,
                              padding: const EdgeInsets.all(0),
                              onPressed: () {
                                setState(() {
                                  ++numbreCmde;
                                  montantTotal = 20000.0 * numbreCmde;
                                });
                              },
                              icon: const Icon(
                                Icons.add,
                                color: myWhite,
                              ),
                              style: IconButton.styleFrom(),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Column(
                              children: [
                                Icon(
                                  Icons.tab_sharp,
                                  color: myGrisFonceAA,
                                ),
                                Text(
                                  "Total",
                                  style: TextStyle(
                                    color: myGrisFonceAA,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              "XOF ${format.format(montantTotal)}",
                              style: const TextStyle(
                                color: myGrisFonce,
                                fontWeight: FontWeight.w800,
                                fontSize: 16,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: myPink,
                                      foregroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(),
                                      shape: ContinuousRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    onPressed: montantTotal == 0
                                        ? null
                                        : () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (_) =>
                                                    const ReceptionAddress(),
                                              ),
                                            );
                                          },
                                    child: Text(
                                      "Commander",
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Liste des commandes",
                      style: TextStyle(
                        fontFamily: "Manrope",
                        color: myPink,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: List.generate(commandeData.length, (index) {
                        final cmd = commandeData[index];
                        return Container(
                          margin: const EdgeInsets.only(
                            left: 10,
                            right: 10,
                            bottom: 10,
                          ),
                          decoration: BoxDecoration(
                            color: myWhite,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                offset: Offset(0, 0),
                                blurRadius: 1,
                                spreadRadius: 0.1,
                                color: myGrisFonce22,
                              ),
                            ],
                          ),
                          child: ListTile(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => CommandeDetail(
                                    commande: cmd,
                                  ),
                                ),
                              );
                            },
                            leading: Hero(
                              tag: cmd.hashCode,
                              child: CircleAvatar(
                                backgroundColor: myPink,
                                child: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Image.asset(
                                    cmd["imgPath"],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            title: Text(
                              "Commande n° ${cmd["numCmd"]}",
                              style: const TextStyle(
                                fontFamily: "Manrope",
                                color: myGrisFonce,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        );
                      }),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
