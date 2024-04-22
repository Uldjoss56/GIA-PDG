import 'package:flutter/material.dart';
import 'package:gia_pdg_partenaire/components/custom_textfield.dart';
import 'package:gia_pdg_partenaire/const/colors.dart';


class ValiderPayement extends StatefulWidget {
  const ValiderPayement({super.key});

  @override
  State<ValiderPayement> createState() => _ValiderPayementState();
}

class _ValiderPayementState extends State<ValiderPayement> {
  final TextEditingController moyen = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController montant = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Valider payement"),
        backgroundColor: myPink,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Container(
              height: 580,
              decoration: BoxDecoration(
                color: myPink,
                shape: BoxShape.rectangle,
                borderRadius: const BorderRadius.horizontal(
                    left: Radius.circular(40), right: Radius.circular(40)),
                boxShadow: [
                  BoxShadow(
                    color: myPink01.withOpacity(1),
                    spreadRadius: 3,
                    blurRadius: 9,
                    offset: const Offset(5, 5),
                  )
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 80,
                      width: 400,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100)),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 18, top: 8.0, bottom: 8),
                        child: CustomTextField(
                            controller: moyen, title: "Moyen de Payement :"),
                      ),
                    ),
                    const SizedBox(
                      height: 28,
                    ),
                    Container(
                      height: 80,
                      width: 400,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 18, top: 8.0, bottom: 8),
                        child: CustomTextField(
                            controller: email, title: "Email :"),
                      ),
                    ),
                    const SizedBox(
                      height: 28,
                    ),
                    Container(
                      height: 80,
                      width: 400,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 18, top: 8.0, bottom: 8),
                        child: CustomTextField(
                            controller: montant, title: "Montant :"),
                      ),
                    ),
                    const SizedBox(
                      height: 28,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 80,
                        width: 400,
                        decoration: BoxDecoration(
                            //shape: BoxShape.rectangle,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(100)),
                            border: Border.all(
                              color: Colors.white,
                            )),
                        child: const Center(
                          child: Text(
                            "Valider",
                            textAlign: TextAlign.center,
                            textScaler: TextScaler.linear(2.5),
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
