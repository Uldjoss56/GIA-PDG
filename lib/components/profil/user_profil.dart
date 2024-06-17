import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gia_pdg_partenaire/components/show_info.dart';
import 'package:gia_pdg_partenaire/const/colors.dart';
import 'package:gia_pdg_partenaire/datas/datas.dart';
import 'package:gia_pdg_partenaire/models/user.dart';
import 'package:gia_pdg_partenaire/provider/dma_provider.dart';
import 'package:gia_pdg_partenaire/provider/message.dart';
import 'package:gia_pdg_partenaire/provider/notifications_provider.dart';
import 'package:gia_pdg_partenaire/provider/product_provider.dart';
import 'package:gia_pdg_partenaire/provider/user_provider.dart';
import 'package:gia_pdg_partenaire/services/const.dart';
import 'package:gia_pdg_partenaire/services/users_service.dart';
import 'package:gia_pdg_partenaire/components/profil/account.dart';
import 'package:gia_pdg_partenaire/components/image_input.dart';
import 'package:gia_pdg_partenaire/ui/choose_account.dart';

class UserProfil extends ConsumerStatefulWidget {
  const UserProfil({super.key});

  @override
  ConsumerState<UserProfil> createState() => _UserProfilState();
}

class _UserProfilState extends ConsumerState<UserProfil> {
  bool statusLangue = false;
  String selectLangue = "Français";

  File? selectedImage;
  User? currentUser;

  final _userService = UserService();

  bool isLoading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    currentUser = ref.watch(userProvider);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    currentUser = ref.watch(userProvider);
    selectedImage = ref.watch(userImageProvider);
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: myPink,
            child: Image.asset(
              "assets/img/background02.jpg",
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: width,
              height: 0.5 * height,
              decoration: const BoxDecoration(
                color: myWhite,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 0.2 * width,
                      ),
                      Text(
                        currentUser?.name ?? "-----",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        currentUser?.email ?? "-----",
                        style: const TextStyle(
                          fontFamily: "Manrope",
                          color: myGrisFonce,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                          left: 15,
                          right: 15,
                          top: 10,
                          bottom: 10,
                        ),
                        margin: const EdgeInsets.only(
                          left: 10,
                          right: 10,
                          bottom: 10,
                        ),
                        decoration: BoxDecoration(
                          color: myWhite,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(
                              offset: Offset(0, 0),
                              blurRadius: 1,
                              spreadRadius: 0.1,
                              color: myGrisFonce55,
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Expanded(
                                  child: Text(
                                    "Informations personnelles",
                                    // textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontFamily: "Manrope",
                                      color: myPink,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                TextButton(
                                  style: TextButton.styleFrom(
                                    foregroundColor: myGrisFonceAA,
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(builder: (_) {
                                        return const Account();
                                      }),
                                    );
                                  },
                                  child: const Row(
                                    children: [
                                      Text(
                                        "modifier",
                                        style: TextStyle(
                                          fontFamily: "Manrope",
                                        ),
                                      ),
                                      Icon(
                                        Icons.mode,
                                        size: 14,
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
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
                                      currentUser?.dateOfBirth ?? "-----",
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
                                      currentUser?.sex ?? "-----",
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
                                      "assets/img/icons/phone_pink.png",
                                      width: 0.08 * width,
                                    ),
                                    title: const Text(
                                      "phone",
                                    ),
                                    subtitle: const Text(
                                      "------",
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
                                        width: 0.07 * width,
                                      ),
                                    ),
                                    title: const Text(
                                      "statut",
                                    ),
                                    subtitle: Text(
                                      currentUser!.roleId == 1
                                          ? "PDG"
                                          : "Partenaire",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      ExpansionPanelList(
                          elevation: 0,
                          dividerColor: myPink0122,
                          expandIconColor: myPink,
                          expansionCallback: (panelIndex, isExpanded) {
                            setState(() {
                              statusLangue = isExpanded;
                            });
                          },
                          children: [
                            ExpansionPanel(
                              headerBuilder: (context, isExpanded) {
                                return ListTile(
                                  leading: ColorFiltered(
                                    colorFilter: const ColorFilter.mode(
                                      myPink,
                                      BlendMode.srcIn,
                                    ),
                                    child: Image.asset(
                                      "assets/img/icons/language_pink.png",
                                      width: 0.08 * width,
                                    ),
                                  ),
                                  title: const Text(
                                    "Langue",
                                    style: TextStyle(
                                      fontFamily: "Manrope",
                                    ),
                                  ),
                                  subtitle: Text(
                                    selectLangue,
                                    style: const TextStyle(
                                      fontFamily: "Manrope",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                );
                              },
                              body: Column(
                                children:
                                    List.generate(languages.length, (subIndex) {
                                  return ListTile(
                                    onTap: () {
                                      setState(() {
                                        selectLangue = languages[subIndex];
                                        statusLangue = false;
                                      });
                                    },
                                    title: Text(
                                      languages[subIndex],
                                      style: const TextStyle(
                                        fontFamily: "Manrope",
                                        color: myGrisFonce,
                                      ),
                                    ),
                                  );
                                }),
                              ),
                              isExpanded: statusLangue,
                            ),
                          ]),
                      const SizedBox(
                        height: 20,
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Paramètres",
                          style: TextStyle(
                            fontFamily: "Manrope",
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: myPink,
                          ),
                        ),
                      ),
                      ListTile(
                        leading: ColorFiltered(
                          colorFilter: const ColorFilter.mode(
                            myPink,
                            BlendMode.srcIn,
                          ),
                          child: Image.asset(
                            "assets/img/icons/padlock_01.png",
                            width: 0.08 * width,
                          ),
                        ),
                        title: const Text(
                          "Mot de passe",
                          style: TextStyle(
                            fontFamily: "Manrope",
                          ),
                        ),
                      ),
                      ListTile(
                        leading: ColorFiltered(
                          colorFilter: const ColorFilter.mode(
                            myPink,
                            BlendMode.srcIn,
                          ),
                          child: Image.asset(
                            "assets/img/icons/insurance_pink.png",
                            width: 0.08 * width,
                          ),
                        ),
                        title: const Text(
                          "Confidentialité",
                          style: TextStyle(
                            fontFamily: "Manrope",
                          ),
                        ),
                      ),
                      ListTile(
                        leading: ColorFiltered(
                          colorFilter: const ColorFilter.mode(
                            myPink,
                            BlendMode.srcIn,
                          ),
                          child: Image.asset(
                            "assets/img/icons/information-button_pink.png",
                            width: 0.08 * width,
                          ),
                        ),
                        title: const Text(
                          "Informations",
                          style: TextStyle(
                            fontFamily: "Manrope",
                          ),
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text(
                                  "Déconnexion",
                                ),
                                content: const Text(
                                  "Voulez-vous vraiment déconnecter ?",
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () async {
                                      invalidateProvider();
                                      logOutUser();
                                    },
                                    child: const Text(
                                      "Se déconnecter",
                                      style: TextStyle(
                                        fontFamily: "Manrope",
                                        fontSize: 14,
                                        color: myGrisFonce,
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text(
                                      "Annuler",
                                      style: TextStyle(
                                        fontFamily: "Manrope",
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        leading: ColorFiltered(
                          colorFilter: const ColorFilter.mode(
                            myPink,
                            BlendMode.srcIn,
                          ),
                          child: Image.asset(
                            "assets/img/icons/logout_pink.png",
                            width: 0.08 * width,
                          ),
                        ),
                        title: const Text(
                          "Se déconnecter",
                          style: TextStyle(
                            fontFamily: "Manrope",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 0.15 * height,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 0.1 * width,
              ),
              child: Container(
                decoration: const BoxDecoration(
                  color: myWhite,
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 0),
                      blurRadius: 4,
                      spreadRadius: 4,
                      color: myGrisFonce55,
                    ),
                  ],
                  shape: BoxShape.circle,
                ),
                child: Stack(
                  children: [
                    Center(
                      child: CircleAvatar(
                        radius: 0.2 * width,
                        child: isLoading
                            ? const CircularProgressIndicator(
                                color: myPink01,
                                strokeWidth: 3,
                              )
                            : AspectRatio(
                                aspectRatio: 1,
                                child: ClipOval(
                                  child: selectedImage == null
                                      ? Image.asset(
                                          "assets/img/icons/profile.png",
                                          fit: BoxFit.cover,
                                        )
                                      : Image.file(
                                          selectedImage!,
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 0.3 * width,
                        ),
                        child: IconButton(
                          style: IconButton.styleFrom(
                            backgroundColor: myPinkAA,
                            shape: const CircleBorder(),
                          ),
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return ImageInput(
                                  onPickImage: (image) {
                                    uploadUserImg(image);
                                  },
                                );
                              },
                            );
                          },
                          icon: const Icon(
                            Icons.camera_alt_rounded,
                            color: myWhite,
                          ),
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
    );
  }

  invalidateProvider() {
    ref.invalidate(userProvider);
    ref.invalidate(userImageProvider);
    ref.invalidate(userMessagesProvider);
    ref.invalidate(unreadNotifProvider);
    ref.invalidate(readNotifProvider);
    ref.invalidate(orderMeDataProvider);
    ref.invalidate(orderDataProvider);
    ref.invalidate(productsProvider);
  }

  uploadUserImg(File imageFile) async {
    final internetConnexion = await checkUserConnexion();
    if (internetConnexion) {
      setState(() {
        isLoading = true;
      });
      try {
        final data = FormData.fromMap({
          'image': await MultipartFile.fromFile(
            imageFile.path,
            filename: 'profil.jpg',
          ),
        });
        await _userService.updateUserImage(data);
        final userImageNotifier = ref.read(userImageProvider.notifier);
        userImageNotifier.updateUserImage(imageFile);
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
      } on DioException catch (e) {
        // ignore: use_build_context_synchronously
        messenger(context, e.message ?? "");
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    } else {
      // ignore: use_build_context_synchronously
      messenger(context, "Connectez-vous à internet");
    }
  }

  logOutUser() async {
    await _userService.disconnectUser();

    // ignore: use_build_context_synchronously
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const ChooseAccount(),
      ),
      (value) => false,
    );
  }
}
