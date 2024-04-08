import 'package:flutter/material.dart';
import 'package:gia_pdg_partenaire/components/const/number.dart';
import 'package:gia_pdg_partenaire/const/colors.dart';
import 'package:gia_pdg_partenaire/datas/datas.dart';
import 'package:gia_pdg_partenaire/ui/pdg_ui/home/pdg_home.dart';
import 'package:gia_pdg_partenaire/ui/pdg_ui/widget/payment_show_dialog.dart';

class Paiement extends StatefulWidget {
  const Paiement({super.key});

  @override
  State<Paiement> createState() => _PaiementState();
}

class _PaiementState extends State<Paiement> {
  final cardNumEditingController = TextEditingController();
  int selectedMethodIndex = 1;

  double montantTotal = 20000;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Paiement",
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Méthode de paiement",
                style: TextStyle(
                  color: myGrisFonce,
                  fontFamily: "Manrope",
                  fontWeight: FontWeight.w800,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(paymentMethodData.length, (index) {
                  final paymentMethod = paymentMethodData[index];
                  return InkWell(
                    splashColor: myPink22,
                    onTap: () {
                      setState(() {
                        selectedMethodIndex = index;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: myWhite,
                        boxShadow: selectedMethodIndex == index
                            ? const [
                                BoxShadow(
                                  offset: Offset(0, 0),
                                  blurRadius: 1,
                                  spreadRadius: 0.1,
                                  color: myPink55,
                                )
                              ]
                            : null,
                      ),
                      child: Image.asset(
                        paymentMethod["imgPath"],
                        width: 0.15 * width,
                        height: 0.15 * width,
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Détails",
                style: TextStyle(
                  color: myGrisFonce,
                  fontFamily: "Manrope",
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Card(
                surfaceTintColor: myWhite,
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: myGris,
                        ),
                        child: TextFormField(
                          controller: cardNumEditingController,
                          decoration: InputDecoration(
                            hintText: "numéro de la carte",
                            hintStyle: const TextStyle(
                              fontFamily: "Manrope",
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: myGrisFonceAA,
                            ),
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(15),
                              child: ColorFiltered(
                                colorFilter: const ColorFilter.mode(
                                  myGrisFonceAA,
                                  BlendMode.srcIn,
                                ),
                                child: Image.asset(
                                  "assets/img/icons/cvv.png",
                                  width: 0.06 * width,
                                  height: 0.06 * width,
                                ),
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none,
                            ),
                            errorBorder: InputBorder.none,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: myGris,
                              ),
                              child: TextFormField(
                                controller: cardNumEditingController,
                                decoration: InputDecoration(
                                  hintText: "mm/yy",
                                  hintStyle: const TextStyle(
                                    fontFamily: "Manrope",
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: myGrisFonceAA,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide.none,
                                  ),
                                  errorBorder: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: myGris,
                              ),
                              child: TextFormField(
                                controller: cardNumEditingController,
                                decoration: InputDecoration(
                                  hintText: "cvv",
                                  hintStyle: const TextStyle(
                                    fontFamily: "Manrope",
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: myGrisFonceAA,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide.none,
                                  ),
                                  errorBorder: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: const RadialGradient(
                                  radius: 1.5,
                                  colors: [
                                    myPink,
                                    myPink01,
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  foregroundColor: Colors.transparent,
                                  elevation: 0,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                  ),
                                  shape: ContinuousRectangleBorder(
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                      builder: (_) => const PdgHome(),
                                    ),
                                    (value) => false,
                                  );
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return PaymentShowDialog(
                                        height: height,
                                        width: width,
                                      );
                                    },
                                  );
                                },
                                child: const Text(
                                  "Payer",
                                  style: TextStyle(
                                    fontFamily: "Manrope",
                                    fontWeight: FontWeight.w900,
                                    fontSize: 18,
                                    color: myWhite,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ColorFiltered(
                        colorFilter: const ColorFilter.mode(
                          myPink,
                          BlendMode.srcIn,
                        ),
                        child: Image.asset(
                          "assets/img/icons/credit-card_white.png",
                          width: 0.08 * width,
                        ),
                      ),
                      const Text(
                        "Total",
                        style: TextStyle(
                          color: myGrisFonce,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Manrope",
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "XOF ${moneyFormat.format(montantTotal)}",
                    style: const TextStyle(
                      fontFamily: "Manrope",
                      color: myGrisFonce,
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
