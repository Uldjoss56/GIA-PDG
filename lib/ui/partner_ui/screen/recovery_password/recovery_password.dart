import 'package:flutter/material.dart';
import 'package:gia_pdg_partenaire/const/colors.dart';

import '../datas_partner/datas_partner.dart';
import '../show_info.dart';

class RecoveryPassword extends StatefulWidget {
  const RecoveryPassword({super.key});

  @override
  State<RecoveryPassword> createState() => _RecoveryPasswordState();
}

class _RecoveryPasswordState extends State<RecoveryPassword> {
  final emailController = TextEditingController();
  int step = 0;
  final digitsController = List.generate(4, (index) {
    return TextEditingController();
  });
  final oneController = TextEditingController();
  final twoController = TextEditingController();
  final thirdController = TextEditingController();
  final fourthcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "GIA-Vendeur",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Récupérer votre \ncompte",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.only(
                  right: 0.8 * width,
                ),
                child: const Divider(
                  height: 1,
                  thickness: 4,
                  color: myPink,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Form(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        step == 0
                            ? "Entrez votre adresse mail"
                            : step == 1
                                ? "Vérifiez votre boite mail \nEntrez le code envoyé "
                                : "Entrez un nouveau mot de passe",
                      ),
                    ),
                    step == 1
                        ? Row(
                            children: List.generate(4, (index) {
                              return Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: TextField(
                                    controller: digitsController[index],
                                    maxLength: 1,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontFamily: "Manrope",
                                    ),
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                        vertical: 0,
                                        horizontal: 10,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: const BorderSide(
                                          color: myGrisFonce22,
                                          width: 0.5,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                          )
                        : Column(
                            children: List.generate(1, (index) {
                              var field = loginData[index];
                              if (step == 0) {
                                field = loginData[0];
                              } else if (step == 2) {
                                field = loginData[1];
                              }
                              return Padding(
                                padding: const EdgeInsets.all(5),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: myGris,
                                  ),
                                  child: TextFormField(
                                    controller: emailController,
                                    decoration: InputDecoration(
                                      hintText: field["hintText"],
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
                                            field["prefixPath"],
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
                              );
                            }),
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
                                  vertical: 15,
                                ),
                                shape: ContinuousRectangleBorder(
                                  borderRadius: BorderRadius.circular(40),
                                ),
                              ),
                              onPressed: () {
                                if (step < 2) {
                                  setState(() {
                                    step++;
                                  });
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return const ShowInformation(
                                        imgPath: "assets/img/icons/user.png",
                                        information: "Compte recupéré",
                                      );
                                    },
                                  );
                                }
                              },
                              child: Text(
                                step == 0
                                    ? "Suivant"
                                    : step == 1
                                        ? "Confirmer"
                                        : "Valider",
                                style: const TextStyle(
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
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
