import 'package:flutter/material.dart';
import 'package:gia_pdg_partenaire/const/colors.dart';
import 'package:gia_pdg_partenaire/ui/partner_ui/screen/partner_home.dart';

class ShowInformation extends StatelessWidget {
  const ShowInformation({
    super.key,
    required this.imgPath,
    required this.information,
  });
  final String imgPath;
  final String information;

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
                      "assets/img/background02.jpg",
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                  Positioned.fill(
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
                            color: myWhite,
                            fontFamily: "Manrope",
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(builder: (context) {
                                return const PartnerHome();
                              }), (route) => false);
                            },
                            child: Container(
                              height: 60,
                              width: 200,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(100)),
                              child: const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      "Continuer",
                                      style: TextStyle(
                                        color: myPink,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Icon(
                                      Icons.east_rounded,
                                      color: myPink,
                                      size: 35,
                                    ),
                                  ]),
                            ),
                          ),
                        ),
                      ],
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
