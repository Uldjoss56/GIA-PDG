import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gia_pdg_partenaire/components/show_info.dart';
import 'package:gia_pdg_partenaire/const/colors.dart';
import 'package:gia_pdg_partenaire/provider/other_provider.dart';
import 'package:gia_pdg_partenaire/provider/user_provider.dart';
import 'package:gia_pdg_partenaire/services/const.dart';
import 'package:gia_pdg_partenaire/services/other_services.dart';
import 'package:gia_pdg_partenaire/services/users_service.dart';
import 'package:gia_pdg_partenaire/ui/choose_account.dart';
import 'package:gia_pdg_partenaire/ui/partner_ui/home/partner_main_home.dart';
import 'package:gia_pdg_partenaire/ui/pdg_ui/home/pdg_main_home.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Begin extends ConsumerStatefulWidget {
  const Begin({
    super.key,
  });

  @override
  ConsumerState<Begin> createState() => _BeginState();
}

class _BeginState extends ConsumerState<Begin> {
  bool? internetAccess;
  bool isLoading = false;

  final _userService = UserService();

  final _otherServices = OtherService();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadCountries();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: myPink55,
        ),
        child: Center(
          child: Image.asset(
            "assets/img/logo/logo.png",
            width: 0.6 * width,
            height: 0.6 * width,
          ),
        ),
      ),
    );
  }

  loginByToken() async {
    internetAccess = await checkUserConnexion();
    if (internetAccess == true) {
      setState(() {
        isLoading = true;
      });
      try {
        var user = await _userService.getUserProfile();
        final prefs = await SharedPreferences.getInstance();
          final downloadsDirectory = await getDownloadsDirectory();
          final directoryPath = downloadsDirectory!.path;
if (user.profil != "" && user.profil != null) {
          final downloadResponse = await _userService.downloadUserImage(
            directoryPath,
            user.profil ?? "",
          );

          if (downloadResponse.statusCode == 200) {
            final userImageFile = File("$directoryPath/${user.profil}");
            final userImageNotifier = ref.read(userImageProvider.notifier);
            userImageNotifier.updateUserImage(userImageFile);
          }
        }
        final userNotifier = ref.read(userProvider.notifier);
        userNotifier.updateUser(user);

        if (user.email == null) {
          // ignore: use_build_context_synchronously
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) {
              return const ChooseAccount();
            }),
          );
        } else {
          prefs.setString("userMail", user.email!);
          switch (user.roleId) {
            case 1:
              // ignore: use_build_context_synchronously
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) {
                  return const PdgMainHome();
                }),
                (value) => false,
              );
              break;
            case 7:
              // ignore: use_build_context_synchronously
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) {
                  return const PartnerMainHome();
                }),
                (value) => false,
              );
              break;
            default:
          }
        }
      } on DioException {
        // ignore: use_build_context_synchronously
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) {
            return const ChooseAccount();
          }),
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

  _loadDevices() async {
    final internetConnexion = await checkUserConnexion();
    if (internetConnexion) {
      setState(() {
        isLoading = true;
      });
      try {
        final response = await _otherServices.getAllDevices();
        final devices = response.devices;

        final deviceNotifier = ref.read(devicesProvider.notifier);
        deviceNotifier.updateListDevice(devices!);

        Future.delayed(const Duration(seconds: 3), () async {
          loginByToken();
        });
      } on DioException catch (e) {
        // ignore: use_build_context_synchronously
        messenger(context, e.response!.data["message"]);
        return List.empty();
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    } else {
      // ignore: use_build_context_synchronously
      messenger(context, "Connectez-vous à internet");
      return List.empty();
    }
  }

  _loadRoles() async {
    final internetConnexion = await checkUserConnexion();
    if (internetConnexion) {
      setState(() {
        isLoading = true;
      });
      try {
        final response = await _otherServices.getAllRoles();
        final roles = response.roles;
        final roleNotifier = ref.read(roleProvider.notifier);
        roleNotifier.updateRole(roles!);
        _loadDevices();
      } on DioException catch (e) {
        // ignore: use_build_context_synchronously
        messenger(context, e.response!.data["message"]);
        return List.empty();
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    } else {
      // ignore: use_build_context_synchronously
      messenger(context, "Connectez-vous à internet");
      return List.empty();
    }
  }

  _loadCountries() async {
    final internetConnexion = await checkUserConnexion();
    if (internetConnexion) {
      setState(() {
        isLoading = true;
      });
      try {
        final response = await _otherServices.getAllCountries();
        final countries = response.countries;
        final countryNotifier = ref.read(countriesProvider.notifier);
        countryNotifier.updateCountry(countries!);
        _loadRoles();
      } on DioException catch (e) {
        // ignore: use_build_context_synchronously
        messenger(context, e.response!.data["message"]);
        return List.empty();
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    } else {
      // ignore: use_build_context_synchronously
      messenger(context, "Connectez-vous à internet");
      return List.empty();
    }
  }
}
