import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gia_pdg_partenaire/components/const/colors.dart';
import 'package:gia_pdg_partenaire/components/show_info.dart';
import 'package:gia_pdg_partenaire/models/user.dart';
import 'package:gia_pdg_partenaire/provider/user_provider.dart';
import 'package:gia_pdg_partenaire/services/const.dart';
import 'package:gia_pdg_partenaire/services/users_service.dart';
import 'package:gia_pdg_partenaire/ui/partner_ui/screen/login_partner/login_partner.dart';
import 'package:gia_pdg_partenaire/ui/pdg_ui/login/pdg_login.dart';
import 'package:pinput/pinput.dart';

class VerifyMail extends ConsumerStatefulWidget {
  const VerifyMail({
    super.key,
  });

  @override
  ConsumerState<VerifyMail> createState() => _VerifyMailState();
}

class _VerifyMailState extends ConsumerState<VerifyMail> {
  final pinController = TextEditingController();
  final focusNode = FocusNode();

  String recCode = "";

  final _pinputFormKey = GlobalKey<FormState>();

  User? user;

  bool isLoading = false;

  final _userService = UserService();

  bool isLoadingResent = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    user = ref.watch(userProvider);
  }

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    recCode = "${user?.confirmCode}";

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
        automaticallyImplyLeading: false,
        title: Text(
          "GIA",
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
                "Valider votre \nemail",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.only(
                  right: 0.9 * width,
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
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Vérifiez votre boite mail \nEntrez le code envoyé ",
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
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
                                  separatorBuilder: (index) => const SizedBox(
                                    width: 20,
                                  ),
                                  validator: (value) {
                                    if (value == recCode.toString()) {
                                      emailVerify({
                                        "code": value,
                                      });
                                    }
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
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 9),
                                        width: 22,
                                        height: 1,
                                        color: myPink,
                                      ),
                                    ],
                                  ),
                                  focusedPinTheme: defaultPinTheme.copyWith(
                                    decoration:
                                        defaultPinTheme.decoration!.copyWith(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: myPink,
                                      ),
                                    ),
                                  ),
                                  submittedPinTheme: defaultPinTheme.copyWith(
                                    decoration:
                                        defaultPinTheme.decoration!.copyWith(
                                      color: myPink0122,
                                      borderRadius: BorderRadius.circular(19),
                                      border: Border.all(
                                        color: myPink0122,
                                      ),
                                    ),
                                  ),
                                  errorPinTheme: defaultPinTheme.copyBorderWith(
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
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          resendEmailVerify({
                            "email": user?.email ?? "",
                          });
                        },
                        child: isLoadingResent
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : const Text(
                                "Renvoyez le code",
                              ),
                      ),
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
                                if (_pinputFormKey.currentState!.validate()) {
                                  emailVerify({
                                    "code": pinController.text,
                                  });
                                }
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if (isLoading)
                                    const Padding(
                                      padding: EdgeInsets.only(
                                        right: 20,
                                      ),
                                      child: CircularProgressIndicator(
                                        color: myPink02,
                                      ),
                                    ),
                                  const Text(
                                    "Confirmer",
                                    style: TextStyle(
                                      fontFamily: "Manrope",
                                      fontWeight: FontWeight.w900,
                                      fontSize: 18,
                                      color: myPink02,
                                    ),
                                  ),
                                ],
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

  resendEmailVerify(Map<String, dynamic> data) async {
    final internetConnexion = await checkUserConnexion();
    if (internetConnexion) {
      setState(() {
        isLoadingResent = true;
      });
      try {
        final response = await _userService.resentMail(data);
        // ignore: use_build_context_synchronously
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) {
            return const VerifyMail();
          }),
        );

        return response;
      } on DioException catch (e) {
        // ignore: use_build_context_synchronously
        messenger(
          context,
          e.response!.data["message"],
        );
      } finally {
        setState(() {
          isLoadingResent = false;
        });
      }
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: myGrisFonce,
          content: Row(
            children: [
              Icon(
                Icons.info_outline_rounded,
                color: myGris,
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Text(
                  "Connectez-vous à internet",
                  style: TextStyle(
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
  }

  emailVerify(Map<String, dynamic> data) async {
    final internetConnexion = await checkUserConnexion();
    if (internetConnexion) {
      setState(() {
        isLoading = true;
      });
      try {
        final response = await _userService.mailVerify(data);

        final user = User.fromJson(response["user"]);
        final userNotifier = ref.read(userProvider.notifier);
        userNotifier.updateUser(user);

        switch (user.roleId) {
          case 1:
            // ignore: use_build_context_synchronously
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) {
                return const PdgLogin();
              }),
              (value) => false,
            );
            break;
          case 7:
            // ignore: use_build_context_synchronously
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) {
                return const LoginPartner();
              }),
              (value) => false,
            );
            break;
          default:
        }
        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (context) {
            return const ShowInformation(
              imgPath: "assets/img/icons/user.png",
              information: "Inscription réussie ",
              detail: "veuillez attendre la validation"
                  " de votre supérieur pour vous connecter",
            );
          },
        );

        return response;
      } on DioException catch (e) {
        // ignore: use_build_context_synchronously
        messenger(
          context,
          e.response!.data["message"],
        );
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: myGrisFonce,
          content: Row(
            children: [
              Icon(
                Icons.info_outline_rounded,
                color: myGris,
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Text(
                  "Connectez-vous à internet",
                  style: TextStyle(
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
  }
}
