import 'package:flutter/material.dart';
import 'package:gia_pdg_partenaire/const/colors.dart';
import 'package:intl/intl.dart';

class CommandeDetail extends StatefulWidget {
  const CommandeDetail({
    super.key,
    required this.commande,
  });
  final Map<String, dynamic> commande;

  @override
  State<CommandeDetail> createState() => _CommandeDetailState();
}

class _CommandeDetailState extends State<CommandeDetail> {
  final format = NumberFormat("#,###", "fr");
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final cmd = widget.commande;
    return Scaffold(
      backgroundColor: myPink,
      appBar: AppBar(
        backgroundColor: myPink,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Center(
            child: Icon(
              Icons.keyboard_arrow_left_rounded,
              color: myWhite,
              size: 30,
              weight: 20,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Hero(
                tag: cmd.hashCode,
                child: CircleAvatar(
                  backgroundColor: myPink01,
                  radius: 0.3 * width,
                  child: ColorFiltered(
                    colorFilter: const ColorFilter.mode(
                      myWhite,
                      BlendMode.srcIn,
                    ),
                    child: Image.asset(
                      cmd["imgPath"],
                      width: 0.2 * width,
                      height: 0.2 * width,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: myPink02,
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Commande n° ${cmd["numCmd"]}",
                  style: const TextStyle(
                    fontFamily: "Manrope",
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                    color: myPink,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          const Text(
                            "Date de la commande",
                            style: TextStyle(
                              fontFamily: "Manrope",
                              color: myGrisFonce,
                            ),
                          ),
                          Text(
                            cmd["dateCmd"],
                            style: const TextStyle(
                              fontFamily: "Manrope",
                              color: myGrisFonce,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          const Text(
                            "Date de réception",
                            style: TextStyle(
                              fontFamily: "Manrope",
                              color: myGrisFonce,
                            ),
                          ),
                          Text(
                            cmd["dateReception"],
                            style: const TextStyle(
                              fontFamily: "Manrope",
                              color: myGrisFonce,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          const Text(
                            "Nombre de DMA commandé",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: "Manrope",
                              color: myGrisFonce,
                            ),
                          ),
                          Text(
                            cmd["nbreDMA"],
                            style: const TextStyle(
                              fontFamily: "Manrope",
                              color: myGrisFonce,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          const Text(
                            "Prix unitaire",
                            style: TextStyle(
                              fontFamily: "Manrope",
                              color: myGrisFonce,
                            ),
                          ),
                          Text(
                            "${cmd["devise"]} ${format.format(
                              double.parse(cmd["prixUnitaire"]).toInt(),
                            )}",
                            style: const TextStyle(
                              fontFamily: "Manrope",
                              color: myGrisFonce,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          const Text(
                            "Adresse de réception",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: "Manrope",
                              color: myGrisFonce,
                            ),
                          ),
                          Text(
                            cmd["adressReception"],
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontFamily: "Manrope",
                              color: myGrisFonce,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          const Text(
                            "Prix d'achat",
                            style: TextStyle(
                              fontFamily: "Manrope",
                              color: myGrisFonce,
                            ),
                          ),
                          Text(
                            "${cmd["devise"]} ${format.format(
                              double.parse(cmd["prixVente"]).toInt(),
                            )}",
                            style: const TextStyle(
                              fontFamily: "Manrope",
                              color: myGrisFonce,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.center,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Télécharger la facture",
                      style: TextStyle(
                        fontFamily: "Manrope",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
