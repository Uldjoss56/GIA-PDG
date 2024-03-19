import 'package:flutter/material.dart';
import 'package:gia_pdg_partenaire/const/colors.dart';

class DMADetail extends StatefulWidget {
  const DMADetail({
    super.key,
  });

  @override
  State<DMADetail> createState() => _DMADetailState();
}

class _DMADetailState extends State<DMADetail> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: myPink,
      appBar: AppBar(
        backgroundColor: myPink,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Center(
            child: Icon(
              Icons.keyboard_arrow_left_rounded,
              color: myWhite,
              size: 30,
              weight: 30,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: CircleAvatar(
                backgroundColor: myPink01,
                radius: 0.3 * width,
                child: ColorFiltered(
                  colorFilter: const ColorFilter.mode(
                    myWhite,
                    BlendMode.srcIn,
                  ),
                  child: Image.asset(
                    "assets/img/icons/qr-code_white.png",
                    width: 0.3 * width,
                    height: 0.3 * width,
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Image.asset(
                  "assets/img/icons/custom_back.png",
                ),
                Container(
                  margin: const EdgeInsets.only(
                    left: 15,
                    right: 15,
                    top: 50,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "DMA PC",
                        style: TextStyle(
                          fontFamily: "Manrope",
                          fontWeight: FontWeight.w800,
                          fontSize: 18,
                          color: myPink,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Votre DMA est associé à votre ordinateur portatif",
                        style: TextStyle(
                          fontFamily: "Manrope",
                          color: myGrisFonce,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Expiration eminent de votre DMA ? "
                        "\nPassez à la boutique la plus proche",
                        style: TextStyle(
                          fontFamily: "Manrope",
                          fontWeight: FontWeight.w500,
                          color: myPink,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const Text(
                            "ou",
                            style: TextStyle(
                              fontFamily: "Manrope",
                              color: myPink,
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            child: const Text(
                              "commandez-ici",
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Expire le : ",
                        style: TextStyle(
                          fontFamily: "Manrope",
                          color: myGrisFonce,
                        ),
                      ),
                      const Text(
                        "20-02-2026",
                        style: TextStyle(
                          fontFamily: "Manrope",
                          color: myGrisFonce,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
