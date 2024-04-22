import 'package:flutter/material.dart';
import 'package:gia_pdg_partenaire/components/custom_button.dart';
import 'package:gia_pdg_partenaire/const/colors.dart';
import 'package:gia_pdg_partenaire/ui/partner_ui/turnover/ca.dart';
import 'package:gia_pdg_partenaire/ui/pdg_ui/distributeur_officiel/distributeur_off_detail.dart';

class PartnerHome extends StatelessWidget {
  const PartnerHome({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: myPink,
            ),
            child: Image.asset(
              "assets/img/background02.jpg",
              fit: BoxFit.cover,
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white60,
            ),
          ),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  buttonText: const Text(
                    "Distributeur Officiel",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  onpressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DistributeurOffiDetail(),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomButton(
                  buttonText: const Text(
                    "Mes commissions",
                    style: TextStyle(fontSize: 20),
                  ),
                  onpressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CA(),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
