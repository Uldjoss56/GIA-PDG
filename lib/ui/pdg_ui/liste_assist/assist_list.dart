import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gia_pdg_partenaire/components/const/colors.dart';
import 'package:gia_pdg_partenaire/components/const/number.dart';
import 'package:gia_pdg_partenaire/components/show_info.dart';
import 'package:gia_pdg_partenaire/components/sort_alert.dart';
import 'package:gia_pdg_partenaire/models/user.dart';
import 'package:gia_pdg_partenaire/provider/user_provider.dart';
import 'package:gia_pdg_partenaire/services/const.dart';
import 'package:gia_pdg_partenaire/services/users_service.dart';
import 'package:gia_pdg_partenaire/ui/pdg_ui/liste_assist/assist/assist_detail.dart';

class AssistList extends ConsumerStatefulWidget {
  const AssistList({super.key});

  @override
  ConsumerState<AssistList> createState() => _AssistListState();
}

class _AssistListState extends ConsumerState<AssistList> {
  bool selectAll = false;
  List<User> assist = [];
  List<bool> itemSelections = [];

  bool isLoading = false;

  final _userService = UserService();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadUserSeller();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    assist = ref.watch(assistProvider);
    itemSelections = List.generate(
      assist.length,
      (index) {
        if (itemSelections.isNotEmpty && itemSelections.length >= index) {
          if (itemSelections[index] == true) {
            return true;
          }
        }
        return false;
      },
    );

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
            Navigator.of(context).pop();
          },
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        title: const Text(
          "Liste des assistants clientèles",
          style: TextStyle(
            fontFamily: 'Manrope-SemiBold',
          ),
        ),
        actions: itemSelections.contains(true)
            ? [
                InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/img/icons/trash.png",
                          width: 0.05 * width,
                          height: 0.05 * width,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          "Supprimer",
                          style: TextStyle(
                            color: myWhite,
                            fontFamily: "Manrope",
                            fontWeight: FontWeight.w500,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ]
            : null,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        splashColor: myWhite,
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return const SortAlert();
                            },
                          );
                        },
                        icon: ColorFiltered(
                          colorFilter: const ColorFilter.mode(
                            myPink,
                            BlendMode.srcIn,
                          ),
                          child: Image.asset(
                            "assets/img/icons/sort_pink.png",
                            fit: BoxFit.cover,
                            width: 35,
                            height: 35,
                          ),
                        ),
                      ),
                      Checkbox(
                        value: selectAll,
                        checkColor: myWhite,
                        activeColor: myPink,
                        side: const BorderSide(
                          color: myPink,
                          width: 1,
                        ),
                        onChanged: (value) {
                          if (value!) {
                            setState(() {});
                          } else {
                            setState(() {});
                          }
                          setState(() {
                            selectAll = value;
                            itemSelections = List.generate(
                              itemSelections.length,
                              (index) => value,
                            );
                          });
                        },
                      ),
                      Container(
                        constraints: BoxConstraints(
                          maxWidth: 0.2 * width,
                        ),
                        child: Text(
                          selectAll ? "Tout désélectionné" : "Tout sélectionné",
                          style: const TextStyle(
                            color: myGrisFonce,
                            fontFamily: "Manrope",
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                  TextField(
                    style: const TextStyle(
                      color: myGrisFonce,
                    ),
                    decoration: InputDecoration(
                      suffixIcon: const Icon(
                        Icons.search,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Rechercher',
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 20,
                      ),
                      hintStyle:
                          Theme.of(context).textTheme.labelMedium!.copyWith(
                                color: Colors.black.withOpacity(0.5),
                              ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                          color: myGrisFonce22,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                          color: myGrisFonce22,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  if (isLoading)
                    const CircularProgressIndicator()
                  else if (assist.isEmpty)
                    const Center(
                      child: Text(
                        "Aucun assist",
                        style: TextStyle(
                          fontFamily: "Manrope",
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  else
                    Column(
                      children: List.generate(assist.length, (index) {
                        final seller = assist[index];
                        return Card(
                          elevation: 2,
                          surfaceTintColor: myWhite,
                          child: ListTile(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) {
                                  return AssistDetail(
                                    assistIndex: index,
                                  );
                                }),
                              );
                            },
                            shape: const ContinuousRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            leading: CircleAvatar(
                              backgroundColor: myPink,
                              child: ClipOval(
                                child: AspectRatio(
                                  aspectRatio: 1,
                                  child: Image.asset(
                                    "assets/img/user_image.jpg",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            title: Text(
                              "Assistanr ${numberFormat.format(index + 1)}",
                              style: const TextStyle(
                                fontFamily: 'Manrope',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            subtitle: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${seller.name}",
                                  style: const TextStyle(
                                    fontFamily: 'Manrope',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  "${seller.email}",
                                  style: const TextStyle(
                                    fontFamily: 'Manrope',
                                    color: myPink,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                            trailing: Checkbox(
                              value: itemSelections[index],
                              onChanged: (value) {
                                setState(() {
                                  itemSelections.removeAt(index);
                                  itemSelections.insert(index, value!);
                                  checkSelectAll();
                                });
                              },
                            ),
                          ),
                        );
                      }),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void checkSelectAll() {
    setState(() {
      selectAll = itemSelections.every(
        (element) => element,
      );
    });
  }

  loadUserSeller() async {
    final internetConnexion = await checkUserConnexion();
    if (internetConnexion) {
      setState(() {
        isLoading = true;
      });
      try {
        final response = await _userService.getUsersByRole(
          {
            "role_id": 3,
          },
        );
        final users = response["users"];
        assist = [];
        for (var user in users) {
          if (user["is_valided"] == 1) {
            assist.add(User.fromJson(user));
          }
        }

        final sellerNotifier = ref.read(assistProvider.notifier);
        sellerNotifier.updateListUser(assist);
      } on DioException catch (e) {
        // ignore: use_build_context_synchronously
        messenger(
          context,
          e.response!.data["message"],
        );
        return List.empty();
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
      return List.empty();
    }
  }
}
