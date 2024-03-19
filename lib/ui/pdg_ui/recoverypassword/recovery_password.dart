import 'package:flutter/material.dart';
import 'package:gia_pdg_partenaire/const/colors.dart';
import 'package:gia_pdg_partenaire/datas/datas.dart';
import 'package:gia_pdg_partenaire/ui/pdg_ui/widget/show_info.dart';
import 'package:pinput/pinput.dart';

class RecoveryPassword extends StatefulWidget {
  const RecoveryPassword({super.key});

  @override
  State<RecoveryPassword> createState() => _RecoveryPasswordState();
}

class _RecoveryPasswordState extends State<RecoveryPassword> {
  final listController = List.generate(2, (index) => TextEditingController());
  final _emailRegex = RegExp(r'^[a-z0-9._%+_]+@[a-z0-9.-]+\.[a-z]{2,6}$');

  int step = 0;
  final digitsController = List.generate(4, (index) {
    return TextEditingController();
  });

  final pinController = TextEditingController();
  final focusNode = FocusNode();

  int recCode = 2222;

  final _pinputFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontFamily: "Manrope",
        fontSize: 22,
        color: myPink01,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        border: Border.all(
          color: myGrisFonce22,
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "GIA-Client",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Récupérer votre \ncompte",
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
                    const SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        step == 0
                            ? "Entrez votre adresse mail"
                            : step == 1
                                ? "Vérifiez votre boite mail \nEntrez le code envoyé "
                                : "Entrez un nouveau mot de passe",
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    step == 1
                        ? Padding(
                            padding: const EdgeInsets.all(10),
                            child: FractionallySizedBox(
                              widthFactor: 1,
                              child: Directionality(
                                // Specify direction if desired
                                textDirection: TextDirection.ltr,
                                child: Form(
                                  key: _pinputFormKey,
                                  child: Column(
                                    children: [
                                      Pinput(
                                        controller: pinController,
                                        focusNode: focusNode,
                                        androidSmsAutofillMethod:
                                            AndroidSmsAutofillMethod
                                                .smsUserConsentApi,
                                        listenForMultipleSmsOnAndroid: true,
                                        defaultPinTheme: defaultPinTheme,
                                        separatorBuilder: (index) =>
                                            const SizedBox(
                                          width: 20,
                                        ),
                                        validator: (value) {
                                          return value == recCode.toString()
                                              ? null
                                              : 'Code pin incorrect';
                                        },
                                        errorTextStyle: const TextStyle(
                                          fontFamily: "Manrope",
                                          color: myPink,
                                        ),
                                        onClipboardFound: (value) {
                                          pinController.setText(value);
                                        },
                                        hapticFeedbackType:
                                            HapticFeedbackType.lightImpact,
                                        cursor: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  bottom: 9),
                                              width: 22,
                                              height: 1,
                                              color: myPink,
                                            ),
                                          ],
                                        ),
                                        focusedPinTheme:
                                            defaultPinTheme.copyWith(
                                          decoration: defaultPinTheme
                                              .decoration!
                                              .copyWith(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(
                                              color: myPink,
                                            ),
                                          ),
                                        ),
                                        submittedPinTheme:
                                            defaultPinTheme.copyWith(
                                          decoration: defaultPinTheme
                                              .decoration!
                                              .copyWith(
                                            color: myPink0122,
                                            borderRadius:
                                                BorderRadius.circular(19),
                                            border: Border.all(
                                              color: myPink0122,
                                            ),
                                          ),
                                        ),
                                        errorPinTheme:
                                            defaultPinTheme.copyBorderWith(
                                          border: Border.all(
                                            color: myPink,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Column(
                            children: List.generate(1, (index) {
                              Map<String, dynamic>? field;
                              int? myIndex;
                              if (step == 0) {
                                field = loginData[0];
                                myIndex = 0;
                              } else if (step == 2) {
                                field = loginData[1];
                                myIndex = 1;
                              }
                              return Padding(
                                padding: const EdgeInsets.all(5),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: myGris,
                                  ),
                                  child: TextFormField(
                                    controller: listController[myIndex!],
                                    decoration: InputDecoration(
                                      hintText: field!["hintText"],
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
                                if (step == 0) {
                                  if (_emailRegex
                                      .hasMatch(listController[0].text)) {
                                    setState(() {
                                      step++;
                                    });
                                  } else {
                                    messenger(
                                      context,
                                      "veuillez à entrer un email correct.",
                                    );
                                  }
                                } else if (step == 1) {
                                  if (_pinputFormKey.currentState!.validate()) {
                                    setState(() {
                                      step++;
                                    });
                                  }
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return const ShowInformation(
                                        imgPath: "assets/img/icons/user.png",
                                        information: "Compte recupéré",
                                      );
                                    },
                                  );
                                }
                              },
                              child: Text(
                                step == 0
                                    ? "Suivant"
                                    : step == 1
                                        ? "Confirmer"
                                        : "Valider",
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
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
