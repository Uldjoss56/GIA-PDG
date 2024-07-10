import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gia_pdg_partenaire/components/button.dart';
import 'package:gia_pdg_partenaire/components/const/colors.dart';
import 'package:gia_pdg_partenaire/components/show_info.dart';
import 'package:gia_pdg_partenaire/datas/datas.dart';
import 'package:gia_pdg_partenaire/models/user.dart';
import 'package:gia_pdg_partenaire/provider/notifications_provider.dart';
import 'package:gia_pdg_partenaire/provider/user_provider.dart';
import 'package:gia_pdg_partenaire/services/const.dart';
import 'package:gia_pdg_partenaire/services/notifications_service.dart';
import 'package:gia_pdg_partenaire/services/users_service.dart';

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
  User? _currentUser;
  User? _user;

  bool _isLoadingValidate = false;

  final _userService = UserService();

  final _notificationsService = NotificationService();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _currentUser = ref.watch(userProvider);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    _user = widget.user;
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
                      "Identité du souscripteur",
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
                              _user?.name ?? "----",
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
                              _user?.email ?? "------",
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
                              _user?.dateOfBirth ?? "------",
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
                              _user?.sex ?? "-----",
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
                                    countriesList[(_user?.countryId ?? 1) - 1]
                                        ["img"],
                                    fit: BoxFit.cover,
                                    width: 20,
                                    height: 20,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  countriesList[(_user?.countryId ?? 1) - 1]
                                      ["noum"],
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
                        ),
                        Expanded(
                          child: ListTile(
                            leading: ColorFiltered(
                              colorFilter: const ColorFilter.mode(
                                myPink,
                                BlendMode.srcIn,
                              ),
                              child: Image.asset(
                                "assets/img/icons/link.png",
                                width: 0.08 * width,
                              ),
                            ),
                            title: const Text(
                              "status",
                            ),
                            subtitle: Text(
                              theRoles[_user?.roleId ?? 0] ?? "",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            if (_user?.isValided == null || _user?.isValided == 0)
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
                      onpressed: () {
                        // ignore: use_build_context_synchronously
                        Navigator.pop(context);
                      },
                      buttonWidth: width * 0.3,
                      buttonHeight: width * 0.15,
                    ),
                    Button(
                      buttonText: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (_isLoadingValidate)
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    width: 0.05 * width,
                                    height: 0.05 * width,
                                    child: const CircularProgressIndicator(
                                      color: myWhite,
                                      strokeWidth: 2,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                          const Text(
                            "Valider",
                            style: TextStyle(
                              color: myGris,
                              fontFamily: "Manrope",
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      onpressed: _user == null
                          ? null
                          : () {
                              validRegistration(
                                _user!.id!,
                                {
                                  "validerId": _currentUser?.id,
                                  "confirm": "1",
                                },
                              );
                            },
                      buttonWidth: width * 0.3,
                      buttonHeight: width * 0.15,
                    )
                  ],
                ),
              )
            else
              const Button(
                buttonText: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
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

  reloadReadNotifications() async {
    try {
      final response = await _notificationsService.getReadNotifications();
      final readNotifNotifier = ref.read(readNotifProvider.notifier);
      readNotifNotifier.updateUserNotif(response.notifications!);
    } on DioException catch (e) {
      // ignore: use_build_context_synchronously
      messenger(context, e.response!.data["message"]);
      return List.empty();
    }
  }

  reloadUnReadNotifications() async {
    try {
      final response = await _notificationsService.getUnreadNotifications();
      final unreadNotifNotifier = ref.read(unreadNotifProvider.notifier);
      unreadNotifNotifier.updateUserNotif(response.notifications!);
    } on DioException catch (e) {
      // ignore: use_build_context_synchronously
      messenger(context, e.response!.data["message"]);
      return List.empty();
    }
  }

  validRegistration(int id, Map<String, dynamic> data) async {
    final internetConnexion = await checkUserConnexion();
    if (internetConnexion) {
      setState(() {
        _isLoadingValidate = true;
      });
      try {
        final response = await _userService.validRegistration(id, data);
        await reloadUnReadNotifications();
        await reloadReadNotifications();
        // ignore: use_build_context_synchronously
        Navigator.pop(context);

        showDialog(
            // ignore: use_build_context_synchronously
            context: context,
            builder: (context) {
              return ShowInformation(
                imgPath: "assets/img/icons/user_white.png",
                information: "Utilisateur validé",
                detail: response["message"],
              );
            });
      } on DioException catch (e) {
        // ignore: use_build_context_synchronously
        messenger(context, e.response!.data["message"]);
        return List.empty();
      } finally {
        setState(() {
          _isLoadingValidate = false;
        });
      }
    } else {
      // ignore: use_build_context_synchronously
      messenger(context, "Connectez-vous à internet");
      return List.empty();
    }
  }
}
