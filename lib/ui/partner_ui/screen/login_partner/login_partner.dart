import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gia_pdg_partenaire/const/colors.dart';
import 'package:gia_pdg_partenaire/provider/user_provider.dart';
import 'package:gia_pdg_partenaire/services/const.dart';
import 'package:gia_pdg_partenaire/services/users_service.dart';
import 'package:gia_pdg_partenaire/ui/pdg_ui/widget/show_info.dart';
import 'package:gia_pdg_partenaire/ui/partner_ui/screen/registration/registration_partner.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../datas_partner/datas_partner.dart';
import '../partner_home.dart';
import '../recovery_password/recovery_password.dart';

class LoginPartner extends ConsumerStatefulWidget {
  const LoginPartner({super.key});

  @override
  ConsumerState<LoginPartner> createState() => _LoginPartnerState();
}

class _LoginPartnerState extends ConsumerState<LoginPartner> {
  final _emailRegex = RegExp(r'^[a-z0-9._%+_]+@[a-z0-9.-]+\.[a-z]{2,6}$');
  bool isVisiblePassword = false;
  var textEditingControllers =
      List.generate(2, (index) => TextEditingController());

  bool isLoading = false;

  final _userService = UserService();
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Center(
          child: Text(
            "GIA",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: "Manrope",
              fontWeight: FontWeight.w800,
              fontSize: 24,
              color: myPink,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Se connecter à un \ncompte",
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
                      children: List.generate(2, (index) {
                        final field = loginData[index];
                        return Padding(
                          padding: const EdgeInsets.all(5),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: myGris,
                            ),
                            child: TextFormField(
                              controller: textEditingControllers[index],
                              obscureText:
                                  index == 1 ? !isVisiblePassword : false,
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
                                            if (index == 1) {
                                              isVisiblePassword =
                                                  !isVisiblePassword;
                                            }
                                          });
                                        },
                                        icon: Icon(
                                          (index == 1 && isVisiblePassword)
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
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) {
                              return const RecoveryPassword();
                            }),
                          );
                        },
                        child: const Text(
                          "Mot de passe oublié",
                        ),
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
                                if (!_emailRegex
                                    .hasMatch(textEditingControllers[0].text)) {
                                  messenger(
                                    context,
                                    "veuillez à entrer un email correct",
                                  );
                                } else {
                                  login({
                                    "email": textEditingControllers[0].text,
                                    "password": textEditingControllers[1].text,
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
                                    "Connexion",
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
              Align(
                alignment: Alignment.center,
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: "Vous n'avez pas un compte ?  ",
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
                                return const RegistrationPartner();
                              }),
                            );
                          },
                          child: const Text(
                            "S'inscrire",
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

  login(data) async {
    final internetConnexion = await checkUserConnexion();
    if (internetConnexion) {
      setState(() {
        isLoading = true;
      });
      try {
        final response = await _userService.connectUser(data);
        final prefs = await SharedPreferences.getInstance();
        prefs.setString(
          "userToken",
          response.authorization!.token!,
        );
        if (response.user!.roleId != 7) {
          await _userService.disconnectUser();

          // ignore: use_build_context_synchronously
          messenger(
            context,
            "Ce compte n'est pas un compte partenaire",
          );
        } else {
          final user = response.user;
          final userNotifier = ref.read(userProvider.notifier);
          userNotifier.updateUser(user!);
          prefs.setString("userMail", user.email!);

          // ignore: use_build_context_synchronously
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const PartnerHome(),
            ),
            (value) => false,
          );
        }
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
      messenger(
        context,
        "Connectez-vous à internet",
      );
    }
  }
}
