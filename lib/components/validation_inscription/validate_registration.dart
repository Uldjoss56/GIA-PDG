import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gia_pdg_partenaire/components/button.dart';
import 'package:gia_pdg_partenaire/components/const/colors.dart';
import 'package:gia_pdg_partenaire/datas/datas.dart';
import 'package:gia_pdg_partenaire/models/user.dart';

class ValidateRegistration extends ConsumerStatefulWidget {
  const ValidateRegistration({
    super.key,
    required this.user,
  });
  final User user;
  @override
  ConsumerState<ValidateRegistration> createState() =>
      _ValidateRegistrationState();
}

class _ValidateRegistrationState extends ConsumerState<ValidateRegistration> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final user = widget.user;
    return Scaffold(
      backgroundColor: myBackground,
      appBar: AppBar(
        backgroundColor: myPink01,
        foregroundColor: myGris,
        toolbarHeight: 0.2 * width,
        leading: IconButton(
          icon: const Icon(
            Icons.keyboard_arrow_left_rounded,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        title: const Text(
          "Validation d'inscription",
          style: TextStyle(
            fontFamily: 'Manrope-SemiBold',
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              margin: const EdgeInsets.symmetric(
                vertical: 30,
                horizontal: 18,
              ),
              elevation: 5,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    const Text(
                      "Identité du vendeur",
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: "Manrope",
                        color: myPink,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ListTile(
                            leading: ColorFiltered(
                              colorFilter: const ColorFilter.mode(
                                myPink,
                                BlendMode.srcIn,
                              ),
                              child: Image.asset(
                                "assets/img/icons/user.png",
                                width: 0.08 * width,
                              ),
                            ),
                            title: const Text(
                              "nom & prénoms",
                            ),
                            subtitle: Text(
                              user.name ?? "----",
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            leading: Icon(
                              Icons.mail_outline_rounded,
                              color: myPink,
                              size: 0.08 * width,
                            ),
                            title: const Text(
                              "email",
                            ),
                            subtitle: Text(
                              user.email ?? "------",
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ListTile(
                            leading: Image.asset(
                              "assets/img/icons/birthday-cake_pink.png",
                              width: 0.08 * width,
                            ),
                            title: const Text(
                              "date de naissance",
                            ),
                            subtitle: Text(
                              user.dateOfBirth ?? "------",
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            leading: Image.asset(
                              "assets/img/icons/gender-fluid_pink.png",
                              width: 0.08 * width,
                            ),
                            title: const Text(
                              "sexe",
                            ),
                            subtitle: Text(
                              user.sex ?? "-----",
                            ),
                          ),
                        ),
                      ],
                    ),
                    ListTile(
                      leading: ColorFiltered(
                        colorFilter: const ColorFilter.mode(
                          myPink,
                          BlendMode.srcIn,
                        ),
                        child: RotatedBox(
                          quarterTurns: 1,
                          child: Image.asset(
                            "assets/img/icons/country.png",
                            width: 0.08 * width,
                          ),
                        ),
                      ),
                      title: const Text(
                        "pays",
                      ),
                      subtitle: Row(
                        children: [
                          ClipOval(
                            child: Image.asset(
                              countriesList[(user.countryId ?? 1) - 1]["img"],
                              fit: BoxFit.cover,
                              width: 20,
                              height: 20,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            countriesList[(user.countryId ?? 1) - 1]["noum"],
                            style: const TextStyle(
                              fontFamily: "Manrope",
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: myGrisFonce,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (user.isValided == null || user.isValided == 0)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Button(
                      buttonText: const Text(
                        "Annuler",
                        style: TextStyle(
                          fontFamily: "Manrope",
                          color: myGris,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onpressed: () {},
                      buttonWidth: width * 0.3,
                      buttonHeight: width * 0.15,
                    ),
                    Button(
                      buttonText: const Text(
                        "Valider",
                        style: TextStyle(
                          color: myGris,
                          fontFamily: "Manrope",
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onpressed: () {},
                      buttonWidth: width * 0.3,
                      buttonHeight: width * 0.15,
                    )
                  ],
                ),
              )
            else
              const Button(
                buttonText: Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    "Vendeur déjà validé",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: myGris,
                      fontFamily: "Manrope",
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                onpressed: null,
              )
          ],
        ),
      ),
    );
  }
}
