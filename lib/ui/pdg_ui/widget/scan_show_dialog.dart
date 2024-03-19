import 'package:flutter/material.dart';
import 'package:gia_pdg_partenaire/const/colors.dart';
import 'package:gia_pdg_partenaire/ui/pdg_ui/dma/add_dma.dart';
import 'package:gia_pdg_partenaire/ui/pdg_ui/dma/dma_detail.dart';

class ScanShowDialog extends StatefulWidget {
  const ScanShowDialog({
    super.key,
    required this.height,
    required this.width,
    this.isAuthentificate,
  });

  final double height;
  final double width;
  final bool? isAuthentificate;

  @override
  State<ScanShowDialog> createState() => _ScanShowDialogState();
}

class _ScanShowDialogState extends State<ScanShowDialog> {
  @override
  Widget build(BuildContext context) {
    final isAuth = widget.isAuthentificate;
    return AlertDialog(
      backgroundColor: myGrisFonce55,
      content: Container(
        constraints: BoxConstraints(
          maxHeight: 0.5 * widget.height,
        ),
        child: Column(
          children: [
            SizedBox(
              height: 0.005 * widget.height,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (isAuth != false)
                  ColorFiltered(
                    colorFilter: const ColorFilter.mode(
                      myPink,
                      BlendMode.srcIn,
                    ),
                    child: Image.asset(
                      "assets/img/icons/authenticity.png",
                      width: 0.1 * widget.width,
                    ),
                  ),
                Text(
                  isAuth == false ? "DMA non authentifié" : "DMA authentifié",
                  style: const TextStyle(
                    color: myPink,
                    fontFamily: "Manrope",
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            Expanded(
              child: Image.asset(
                "assets/img/logo/logo.png",
                width: 0.2 * widget.height,
              ),
            ),
            Text(
              isAuth == false
                  ? "Désolé, le code QR ne correspond à aucun produit DMA"
                  : isAuth == null
                      ? "Votre DMA a été déjà associé à votre compte."
                      : "Enregistrez le nouveau DMA",
              style: const TextStyle(
                fontFamily: "Manrope",
                color: myWhite,
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
                        foregroundColor: myWhite,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                        shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            40,
                          ),
                        ),
                      ),
                      onPressed: () {
                        if (isAuth == false) {
                          Navigator.pop(context);
                        } else {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (_) {
                              if (isAuth == null) {
                                return const DMADetail();
                              } else {
                                return const AddDMA();
                              }
                            }),
                          );
                        }
                      },
                      child: Text(
                        isAuth == false
                            ? "Réessayez"
                            : isAuth == null
                                ? "Voir"
                                : "Suivant",
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
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
