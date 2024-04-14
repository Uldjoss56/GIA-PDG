import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gia_pdg_partenaire/components/sort_alert.dart';
import 'package:gia_pdg_partenaire/const/colors.dart';
import 'package:gia_pdg_partenaire/datas/datas.dart';
import 'package:gia_pdg_partenaire/models/other_models.dart';
import 'package:gia_pdg_partenaire/models/user.dart';
import 'package:gia_pdg_partenaire/provider/other_provider.dart';
import 'package:gia_pdg_partenaire/provider/user_provider.dart';
import 'package:gia_pdg_partenaire/services/const.dart';
import 'package:gia_pdg_partenaire/services/users_service.dart';
import 'package:gia_pdg_partenaire/ui/pdg_ui/login/pdg_login.dart';
import 'package:gia_pdg_partenaire/ui/pdg_ui/widget/show_info.dart';
import 'package:gia_pdg_partenaire/ui/verify_mail.dart';

class PdgRegistration extends ConsumerStatefulWidget {
  const PdgRegistration({super.key});

  @override
  ConsumerState<PdgRegistration> createState() => _PdgRegistrationState();
}

class _PdgRegistrationState extends ConsumerState<PdgRegistration> {
  List<TextEditingController> textEditingControllers =
      List.generate(4, (index) => TextEditingController());
  final _emailRegex = RegExp(r'^[a-z0-9._%+_]+@[a-z0-9.-]+\.[a-z]{2,6}$');

  bool isVisiblePassword = false;
  bool isVisibleConfirmPassword = false;

  bool isLoading = false;

  final _userService = UserService();

  String _radioSexGroup = "F";

  bool isTapDistID = false;

  bool isFound = false;

  Country? _country;
  List<Country> _lineCountries = [];
  String? _countryImg;

  final _pvController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _lineCountries = ref.watch(countriesProvider);
    _country = _lineCountries[2];
    final countryID = _country!.countryId;
    _countryImg = countriesList[countryID! - 1]["img"];
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "GIA-PDG",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(
          10,
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
                          child: RadioListTile(
                            value: "M",
                            groupValue: _radioSexGroup,
                            title: const Text(
                              "Masculin",
                              style: TextStyle(
                                fontFamily: "Manrope",
                                fontWeight: FontWeight.w500,
                                color: myGrisFonce,
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                _radioSexGroup = value!;
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: RadioListTile(
                            value: "F",
                            groupValue: _radioSexGroup,
                            title: const Text(
                              "Féminin",
                              style: TextStyle(
                                fontFamily: "Manrope",
                                fontWeight: FontWeight.w500,
                                color: myGrisFonce,
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                _radioSexGroup = value!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Pays ",
                            style: TextStyle(
                              fontFamily: "Manrope",
                              fontWeight: FontWeight.w400,
                              color: myGrisFonce,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            CircleAvatar(
                              child: ClipOval(
                                child: AspectRatio(
                                  aspectRatio: 1,
                                  child: Image.asset(
                                    _countryImg!,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: DropdownButtonFormField(
                                value: _country,
                                decoration: const InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: myPink),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(
                                      color: myGrisFonce55,
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 15,
                                    vertical: 10,
                                  ),
                                ),
                                padding: const EdgeInsets.all(10),
                                items: List.generate(_lineCountries.length,
                                    (index) {
                                  return DropdownMenuItem(
                                    value: _lineCountries[index],
                                    child: Container(
                                      constraints: BoxConstraints(
                                        maxWidth: 0.4 * width,
                                      ),
                                      child: Text(
                                        _lineCountries[index].name.toString(),
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          color: myGrisFonce,
                                          fontFamily: "Manrope",
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                                onChanged: (value) {
                                  _country = value;
                                  setState(() {
                                    final id = _country!.countryId;
                                    _countryImg = countriesList[id! - 1]["img"];
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Définissez votre prix de vente",
                        style: TextStyle(
                          fontFamily: "Manrope",
                          fontWeight: FontWeight.w400,
                          color: myGrisFonce,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: 0.4 * width,
                          height: 50,
                          child: TextField(
                            controller: _pvController,
                            style: const TextStyle(
                              fontFamily: "Manrope",
                              fontWeight: FontWeight.w600,
                            ),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              prefix: const Icon(
                                Icons.numbers,
                                color: myGrisFonceAA,
                              ),
                            ),
                          ),
                        ),
                      ),
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
                                } else if (!isInteger(_pvController.text)) {
                                  messenger(
                                    context,
                                    "vous devez entrer un nombre",
                                  );
                                } else {
                                  signUp({
                                    "email": textEditingControllers[1].text,
                                    "name": textEditingControllers[0].text,
                                    "sex": _radioSexGroup,
                                    "country_id": "${_country!.countryId}",
                                    "date_of_birth": "--/--/----",
                                    "profil": "",
                                    "password": textEditingControllers[2].text,
                                    "confirm_code": "",
                                    "role_id": "7",
                                    "isValided": "",
                                    "codeDistr": "",
                                    "pv": _pvController.text,
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
                                    "Inscription",
                                    style: TextStyle(
                                      fontFamily: "Manrope",
                                      fontWeight: FontWeight.w900,
                                      fontSize: 18,
                                      color: myWhite,
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
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  signUp(data) async {
    final internetConnexion = await checkUserConnexion();
    if (internetConnexion) {
      setState(() {
        isLoading = true;
      });
      try {
        final response = await _userService.createUser(data);

        if (response["status_code"] == 200) {
          final user = User.fromJson(response["user"]);
          print(user.confirmCode);
          final userNotifier = ref.read(userProvider.notifier);
          userNotifier.updateUser(user);
          // ignore: use_build_context_synchronously
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) {
              return const VerifyMail();
            }),
          );
        } else {
          Map<String, dynamic> errorsList = response['errorsList'];
          String firstErrorField = errorsList.keys.first;

          String firstErrorMessage = errorsList[firstErrorField][0];

          // ignore: use_build_context_synchronously
          messenger(
            context,
            firstErrorMessage,
          );
        }

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
