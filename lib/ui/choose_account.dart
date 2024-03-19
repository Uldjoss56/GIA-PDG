import 'package:flutter/material.dart';
import 'package:gia_pdg_partenaire/const/colors.dart';
import 'package:gia_pdg_partenaire/ui/partner_ui/screen/login_partner/login_partner.dart';
import 'package:gia_pdg_partenaire/ui/pdg_ui/login/pdg_login.dart';

class ChooseAccount extends StatelessWidget {
  const ChooseAccount({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        color: myPink,
        child: Column(
          children: [
            SizedBox(
              width: width,
              height: 0.6 * height,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    ),
                    child: Image.asset(
                      "assets/img/background_pdg.jpg",
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Bienvenue sur votre application",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "Manrope",
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: myWhite,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "choisissez votre compte pour continuer",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "Manrope",
                            fontWeight: FontWeight.w500,
                            color: myPink02,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: InkWell(
                      splashColor: myWhite,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPartner(),
                          ),
                        );
                      },
                      child: Card(
                        elevation: 2,
                        color: myPink02,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                "assets/img/partners.jpg",
                                fit: BoxFit.fitWidth,
                                height: 0.3 * width,
                                width: 0.6 * width,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                "Partenaire",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: "Manrope-Medium",
                                  fontWeight: FontWeight.w700,
                                  color: myGrisFonce,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: InkWell(
                      splashColor: myWhite,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PdgLogin(),
                          ),
                        );
                      },
                      child: Card(
                        elevation: 2,
                        color: myPink02,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                "assets/img/pdg.jpg",
                                fit: BoxFit.fitWidth,
                                height: 0.3 * width,
                                width: 0.6 * width,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                "PDG",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: "Manrope-Medium",
                                  fontWeight: FontWeight.w700,
                                  color: myGrisFonce,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
