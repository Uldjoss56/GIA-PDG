import 'package:flutter/material.dart';
import 'package:gia_pdg_partenaire/components/const/colors.dart';

class ShowInformation extends StatelessWidget {
  const ShowInformation({
    super.key,
    required this.imgPath,
    required this.information,
    this.detail,
  });
  final String imgPath;
  final String information;
  final String? detail;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
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
        height: 0.6 * height,
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
                          CircleAvatar(
                            backgroundColor: myPink01,
                            radius: 0.2 * width,
                            child: ColorFiltered(
                              colorFilter: const ColorFilter.mode(
                                myWhite,
                                BlendMode.srcIn,
                              ),
                              child: Image.asset(
                                imgPath,
                                width: 0.2 * width,
                                height: 0.2 * width,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            information,
                            style: const TextStyle(
                              color: myPink02,
                              fontFamily: "Manrope",
                              fontWeight: FontWeight.w800,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            detail ?? "",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: myWhite,
                              fontFamily: "Manrope",
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
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

messenger(BuildContext context, String text) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: myPink01,
      content: Row(
        children: [
          const Icon(
            Icons.error_outline_rounded,
            color: myGris,
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              "Erreur survenue : $text",
              style: const TextStyle(
                color: myGris,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
