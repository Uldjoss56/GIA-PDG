import 'package:flutter/material.dart';
import 'package:gia_pdg_partenaire/const/colors.dart';
import 'package:gia_pdg_partenaire/datas/datas.dart';
import 'package:gia_pdg_partenaire/ui/pdg_ui/widget/custom_clipper.dart';

class MessagingUI extends StatefulWidget {
  const MessagingUI({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<MessagingUI> createState() => _MessagingUIState();
}

class _MessagingUIState extends State<MessagingUI> {
  bool isChatbot = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          widget.title,
          style: const TextStyle(
            color: myPink,
            fontFamily: "Manrope",
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Center(
            child: Icon(
              Icons.keyboard_arrow_left_rounded,
              color: myPink,
              size: 30,
              weight: 30,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Column(
                    children: List.generate(4, (index) {
                      return Column(
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: 10,
                                bottom: 10,
                                left: 100,
                              ),
                              child: ClipPath(
                                clipper: ContainerClipper(),
                                child: Container(
                                  padding: const EdgeInsets.only(
                                    left: 20,
                                    top: 20,
                                    bottom: 20,
                                    right: 30,
                                  ),
                                  decoration: const BoxDecoration(
                                    color: myPink,
                                  ),
                                  child: const Text(
                                    "Bonsoir, comment vérifier l'authen ticité"
                                    " de mon DMA ?"
                                    "Bonsoir, comment vérifier l'authenticité"
                                    " de mon DMA ?"
                                    "Bonsoir, comment vérifier\nl'authenticité"
                                    " de mon DMA ?"
                                    "Bonsoir, comment vérifier\nl'authenticité"
                                    " de mon DMA ?"
                                    "Bonsoir, comment vérifier\nl'authenticité"
                                    " de mon DMA ?"
                                    "Bonsoir, comment vérifier\nl'authenticité"
                                    " de mon DMA ?"
                                    "Bonsoir, comment vérifier\nl'authenticité"
                                    " de mon DMA ?"
                                    "Bonsoir, comment vérifier\nl'authenticité"
                                    " de mon DMA ?",
                                    maxLines: 4,
                                    style: TextStyle(
                                      fontFamily: "Manrope",
                                      color: myWhite,
                                      //fontSize:  16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: 10,
                                bottom: 10,
                                right: 100,
                              ),
                              child: ClipPath(
                                clipper: ContainerClipper01(),
                                child: Container(
                                  padding: const EdgeInsets.only(
                                    left: 30,
                                    top: 20,
                                    bottom: 20,
                                    right: 20,
                                  ),
                                  decoration: const BoxDecoration(
                                    color: Colors.blue,
                                  ),
                                  child: const Text(
                                    "Bonsoir, comment vérifier\nl'authenticité"
                                    " de mon DMA ?"
                                    "Bonsoir, comment vérifier\nl'authenticité"
                                    " de mon DMA ?"
                                    "Bonsoir, comment vérifier\nl'authenticité"
                                    " de mon DMA ?"
                                    "Bonsoir, comment vérifier\nl'authenticité"
                                    " de mon DMA ?"
                                    "Bonsoir, comment vérifier\nl'authenticité"
                                    " de mon DMA ?"
                                    "Bonsoir, comment vérifier\nl'authenticité"
                                    " de mon DMA ?"
                                    "Bonsoir, comment vérifier\nl'authenticité"
                                    " de mon DMA ?"
                                    "Bonsoir, comment vérifier\nl'authenticité"
                                    " de mon DMA ?",
                                    softWrap: true,
                                    maxLines: 4,
                                    style: TextStyle(
                                      fontFamily: "Manrope",
                                      color: myWhite,
                                      //fontSize:  16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      );
                    }),
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                top: 10,
              ),
              decoration: BoxDecoration(
                color: myWhite,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(0, 0),
                    blurRadius: 1,
                    spreadRadius: 1,
                    color: myGrisFonce22,
                  ),
                ],
              ),
              child: TextField(
                maxLines: 4,
                minLines: 1,
                decoration: InputDecoration(
                  hintText: "votre message",
                  hintStyle: const TextStyle(
                    fontFamily: "Manrope",
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      // vertical: 2,
                    ),
                    child: CircleAvatar(
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: ClipOval(
                          child: Image.asset(
                            userData["profilImage"],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  suffixIcon: InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        // vertical: 2,
                      ),
                      child: CircleAvatar(
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: Image.asset(
                            "assets/img/icons/send.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
