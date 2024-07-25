
import 'package:flutter/material.dart';
import 'package:gia_pdg_partenaire/const/colors.dart';

class PaymentShowDialog extends StatefulWidget {
  const PaymentShowDialog({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  State<PaymentShowDialog> createState() => _PaymentShowDialogState();
}

class _PaymentShowDialogState extends State<PaymentShowDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: myWhite,
      surfaceTintColor: myWhite,
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      insetAnimationDuration: const Duration(
        seconds: 2,
      ),
      child: SizedBox(
        height: 0.6 * widget.height,
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      "assets/img/background02.png",
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                  Positioned.fill(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  backgroundColor: myPink,
                                  radius: 0.2 * widget.width,
                                  child: ColorFiltered(
                                    colorFilter: const ColorFilter.mode(
                                      myWhite,
                                      BlendMode.srcIn,
                                    ),
                                    child: Image.asset(
                                      "assets/img/icons/shield_white.png",
                                      width: 0.2 * widget.width,
                                      height: 0.2 * widget.width,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  "Paiement réussi",
                                  style: TextStyle(
                                    color: myWhite,
                                    fontFamily: "Manrope",
                                    fontWeight: FontWeight.w800,
                                    fontSize: 18,
                                  ),
                                ),
                                const Text(
                                  "votre commande vous sera livré dans le plus bref délai",
                                  style: TextStyle(
                                    color: myWhite,
                                    fontFamily: "Manrope",
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              "Télécharger la facture",
                              style: TextStyle(
                                color: myWhite,
                                fontFamily: "Manrope",
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
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
