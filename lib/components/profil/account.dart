import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gia_pdg_partenaire/components/const/number.dart';
import 'package:gia_pdg_partenaire/components/profil/widgets/modif_info.dart';
import 'package:gia_pdg_partenaire/components/show_info.dart';
import 'package:gia_pdg_partenaire/const/colors.dart';
import 'package:gia_pdg_partenaire/datas/datas.dart';
import 'package:gia_pdg_partenaire/models/user.dart';
import 'package:gia_pdg_partenaire/provider/user_provider.dart';
import 'package:gia_pdg_partenaire/services/const.dart';
import 'package:gia_pdg_partenaire/services/users_service.dart';

class Account extends ConsumerStatefulWidget {
  const Account({
    super.key,
  });

  @override
  ConsumerState<Account> createState() => _AccountState();
}

class _AccountState extends ConsumerState<Account> {
  User? _currentUser;

  List<String> valueList = [];

  bool isLoading = false;

  DateTime? _birthDay;

  final _userService = UserService();
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _currentUser = ref.watch(userProvider);
    /*
    final countryID = (_currentUser?.countryId ?? 1) - 1;
    _lineCountries = ref.watch(countriesProvider);
    if (_country == null) {
      _country = _lineCountries[countryID];
      _countryImg = countriesList[countryID]["img"];
    }
    if (_radioSexGroup.isEmpty) {
      _radioSexGroup = _currentUser!.sex!;
    }
    */
    if (valueList.isEmpty) {
      valueList = [
        _currentUser?.name ?? "",
        _currentUser?.dateOfBirth ?? "",
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myWhite,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Mon Compte",
          style: TextStyle(
            color: myPink,
            fontFamily: "Manrope",
            fontWeight: FontWeight.w800,
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
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 18),
          padding: const EdgeInsets.only(top: 25),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(profilCardData.length, (index) {
                  final pfldata = profilCardData[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        pfldata['text'],
                        style: const TextStyle(
                          fontFamily: "Manrope",
                        ),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        decoration: BoxDecoration(
                          color: myGris,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ListTile(
                          title: Text(
                            valueList[index],
                            style: const TextStyle(
                              fontFamily: "Manrope",
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          trailing: SizedBox(
                            width: 30,
                            child: IconButton(
                              onPressed: () async {
                                if (pfldata["theKey"] == "birthday") {
                                  DateTime? date = await showDatePicker(
                                    context: context,
                                    initialDate: _birthDay,
                                    firstDate: DateTime(1940),
                                    lastDate: DateTime.now(),
                                  );
                                  if (date != null) {
                                    setState(
                                      () {
                                        _birthDay = DateTime(
                                          date.year,
                                          date.month,
                                          date.day,
                                        );
                                        valueList[index] =
                                            dateFormatD.format(_birthDay!);
                                      },
                                    );
                                  }
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return ModifInfo(
                                        takeText: (text) {
                                          setState(() {
                                            valueList[index] = text;
                                          });
                                        },
                                        theKey: pfldata['theKey'],
                                        label: pfldata['label'],
                                      );
                                    },
                                  );
                                }
                              },
                              icon: const Icon(
                                Icons.create,
                                color: myGrisFonceAA,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  );
                }),
              ),
              /*
              Column(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Sexe ",
                      style: TextStyle(
                        fontFamily: "Manrope",
                        fontWeight: FontWeight.w400,
                        color: myGrisFonce,
                      ),
                    ),
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
                    height: 30,
                  ),
                ],
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
                          items: List.generate(_lineCountries.length, (index) {
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
                            setState(() {
                              _country = value;
                              final id = _country!.countryId;
                              _countryImg = countriesList[id! - 1]["img"];
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
              */
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
                          updateUser({
                            "name": valueList[0],
                            "date_of_birth": valueList[1],
                          });
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
                              "Modifier",
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
              const SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }

  updateUser(data) async {
    final internetConnexion = await checkUserConnexion();
    if (internetConnexion) {
      setState(() {
        isLoading = true;
      });
      try {
        final response = await _userService.updateUser(
          _currentUser!.id!,
          data,
        );
        final user = response.user;
        final userNotifier = ref.read(userProvider.notifier);
        userNotifier.updateUser(user!);
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
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
