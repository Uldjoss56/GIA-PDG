import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gia_pdg_partenaire/components/const/colors.dart';
import 'package:gia_pdg_partenaire/ui/pdg_ui/messaging_ui/messaging.dart';

class ChatList extends ConsumerWidget {
  const ChatList({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 20),
        color: myWhite,
        child: Column(
          children: [
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
                            builder: (context) => const MessagingUI(
                              roleID: 5,
                            ),
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
                                "assets/img/dist.png",
                                fit: BoxFit.fitWidth,
                                height: 0.3 * width,
                                width: 0.6 * width,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                "Admin",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: "Manrope-Medium",
                                  fontWeight: FontWeight.w700,
                                  color: myPink01,
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
                            builder: (context) => const MessagingUI(
                              roleID: 2,
                            ),
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
                                "assets/img/heart_phone.png",
                                fit: BoxFit.fitWidth,
                                height: 0.3 * width,
                                width: 0.6 * width,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                "Distributeur Officiel",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: "Manrope-Medium",
                                  fontWeight: FontWeight.w700,
                                  color: myPink01,
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
