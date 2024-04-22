import 'package:flutter/material.dart';
import 'package:gia_pdg_partenaire/components/const/colors.dart';
import 'package:gia_pdg_partenaire/models/product.dart';

class ScanShowDialog extends StatefulWidget {
  const ScanShowDialog({
    super.key,
    required this.height,
    required this.width,
    this.product,
    this.isAuthentificate,
  });

  final double height;
  final double width;
  final bool? isAuthentificate;
  final Product? product;

  @override
  State<ScanShowDialog> createState() => _ScanShowDialogState();
}

class _ScanShowDialogState extends State<ScanShowDialog> {
  @override
  Widget build(BuildContext context) {
    final isAuth = widget.isAuthentificate;
    final product = widget.product;
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
                SizedBox(
                  width: 0.6 * widget.width,
                  child: Text(
                    isAuth == null
                        ? "DMA non authentifié"
                        : isAuth == false
                            ? "DMA Authentifié - Non Activé"
                            : "DMA authentifié",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: myPink,
                      fontFamily: "Manrope",
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                    ),
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
              isAuth == null
                  ? "Désolé, le code QR ne correspond à aucun produit DMA"
                  : isAuth == false
                      ? "Ce produit DMA n'est pas encore activé"
                      : product?.isAssociatedWith == null ||
                              product?.isAssociatedWith == ""
                          ? "Enregistrez votre nouveau DMA"
                          : "Ce produit DMA est déjà activé",
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
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "ok",
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
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
