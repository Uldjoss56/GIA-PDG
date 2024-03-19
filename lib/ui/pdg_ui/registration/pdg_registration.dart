import 'package:flutter/material.dart';
import 'package:gia_pdg_partenaire/const/colors.dart';
import 'package:gia_pdg_partenaire/datas/datas.dart';
import 'package:gia_pdg_partenaire/ui/pdg_ui/login/pdg_login.dart';
import 'package:gia_pdg_partenaire/ui/pdg_ui/widget/show_info.dart';

class PdgRegistration extends StatefulWidget {
  const PdgRegistration({super.key});

  @override
  State<PdgRegistration> createState() => _PdgRegistrationState();
}

class _PdgRegistrationState extends State<PdgRegistration> {
  List<TextEditingController> textEditingControllers =
      List.generate(4, (index) => TextEditingController());
  final _emailRegex = RegExp(r'^[a-z0-9._%+_]+@[a-z0-9.-]+\.[a-z]{2,6}$');

  bool isVisiblePassword = false;
  bool isVisibleConfirmPassword = false;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "GIA-Client",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 10,
          right: 10,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Créez un nouveau\ncompte",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.only(
                  right: 0.8 * width,
                ),
                child: const Divider(
                  height: 1,
                  thickness: 4,
                  color: myPink,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Form(
                child: Column(
                  children: [
                    Column(
                      children: List.generate(4, (index) {
                        final field = registrationData[index];
                        return Padding(
                          padding: const EdgeInsets.all(5),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: myGris,
                            ),
                            child: TextFormField(
                              controller: textEditingControllers[index],
                              obscureText: index == 2
                                  ? !isVisiblePassword
                                  : index == 3
                                      ? !isVisibleConfirmPassword
                                      : false,
                              decoration: InputDecoration(
                                hintText: field["hintText"],
                                hintStyle: const TextStyle(
                                  fontFamily: "Manrope",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: myGrisFonceAA,
                                ),
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: ColorFiltered(
                                    colorFilter: const ColorFilter.mode(
                                      myGrisFonceAA,
                                      BlendMode.srcIn,
                                    ),
                                    child: Image.asset(
                                      field["prefixPath"],
                                      width: 0.06 * width,
                                      height: 0.06 * width,
                                    ),
                                  ),
                                ),
                                suffixIcon: field["isPassword"]
                                    ? IconButton(
                                        onPressed: () {
                                          setState(() {
                                            if (index == 2) {
                                              isVisiblePassword =
                                                  !isVisiblePassword;
                                            } else if (index == 3) {
                                              isVisibleConfirmPassword =
                                                  !isVisibleConfirmPassword;
                                            }
                                          });
                                        },
                                        icon: Icon(
                                          ((index == 2 && isVisiblePassword))
                                              ? Icons.visibility
                                              : (index == 3 &&
                                                      isVisibleConfirmPassword)
                                                  ? Icons.visibility
                                                  : Icons.visibility_off,
                                          color: myGrisFonceAA,
                                        ),
                                      )
                                    : null,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide.none,
                                ),
                                errorBorder: InputBorder.none,
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(
                      height: 20,
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
                                foregroundColor: Colors.transparent,
                                elevation: 0,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 15,
                                ),
                                shape: ContinuousRectangleBorder(
                                  borderRadius: BorderRadius.circular(40),
                                ),
                              ),
                              onPressed: () {
                                
                                if (textEditingControllers[0].text.isEmpty) {
                                  messenger(
                                    context,
                                    "veuillez à entrer votre nom.",
                                  );
                                } else if (!_emailRegex
                                    .hasMatch(textEditingControllers[1].text)) {
                                  messenger(
                                    context,
                                    "veuillez à entrer un email correct.",
                                  );
                                } else if (textEditingControllers[2]
                                        .text
                                        .length <
                                    6) {
                                  messenger(
                                    context,
                                    "mot de passe, au moins 06 caractères.",
                                  );
                                } else if (textEditingControllers[2].text !=
                                    textEditingControllers[3].text) {
                                  messenger(
                                    context,
                                    "mots de passe non correspondants",
                                  );
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return const ShowInformation(
                                        imgPath: "assets/img/icons/user.png",
                                        information: "Inscription réussie",
                                      );
                                    },
                                  );
                                }
                              },
                              child: const Text(
                                "Inscription",
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
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.center,
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: 'Avez-vous déjà un compte ?  ',
                        style: TextStyle(
                          fontFamily: "Manrope",
                          fontSize: 14,
                          color: myGrisFonce,
                        ),
                      ),
                      WidgetSpan(
                        child: InkWell(
                          splashColor: myPink55,
                          onTap: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) {
                                return const PdgLogin();
                              }),
                            );
                          },
                          child: const Text(
                            "Se connecter",
                            style: TextStyle(
                              fontFamily: "Manrope",
                              fontSize: 14,
                              color: myPink,
                            ),
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
      ),
    );
  }
}
