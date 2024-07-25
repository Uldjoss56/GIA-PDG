import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gia_pdg_partenaire/components/const/colors.dart';
import 'package:gia_pdg_partenaire/components/show_info.dart';
import 'package:gia_pdg_partenaire/components/sort_alert.dart';
import 'package:gia_pdg_partenaire/datas/datas.dart';
import 'package:gia_pdg_partenaire/models/other_models.dart';
import 'package:gia_pdg_partenaire/models/user.dart';
import 'package:gia_pdg_partenaire/provider/other_provider.dart';
import 'package:gia_pdg_partenaire/provider/user_provider.dart';
import 'package:gia_pdg_partenaire/services/const.dart';
import 'package:gia_pdg_partenaire/services/users_service.dart';
import 'package:gia_pdg_partenaire/ui/pdg_ui/liste_distributeur_pays/ditributeur_pays/distributeur_pays.dart';

class DistributeurPaysList extends ConsumerStatefulWidget {
  const DistributeurPaysList({super.key});

  @override
  ConsumerState<DistributeurPaysList> createState() =>
      _DistributeurPaysListState();
}

class _DistributeurPaysListState extends ConsumerState<DistributeurPaysList> {
  List<Country> countryList = [];
  List<User> distPays = [];
  User? currentUser;

  bool selectAll = false;
  List<bool> itemSelections = [];

  bool isLoading = false;

  final _userService = UserService();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    currentUser = ref.watch(userProvider);
    countryList = ref.watch(countriesProvider);
    loadDistPays();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
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
          "Liste de distributeurs pays",
          style: TextStyle(
            fontFamily: 'Manrope-SemiBold',
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
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
                  hintStyle: Theme.of(context).textTheme.labelMedium!.copyWith(
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
              isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Column(
                      children: List.generate(distPays.length, (index) {
                        final aDistPays = distPays[index];
                        return Container(
                          margin: const EdgeInsets.only(
                            left: 10,
                            right: 10,
                            bottom: 10,
                          ),
                          padding: const EdgeInsets.all(20.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: myGrisFonceAA,
                              width: 0.5,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) {
                                  return DistributeurPays(
                                    distPays: aDistPays,
                                  );
                                }),
                              );
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  backgroundColor: myPink,
                                  radius: 0.1 * width,
                                  child: ClipOval(
                                    child: AspectRatio(
                                      aspectRatio: 1,
                                      child: Image.asset(
                                        "assets/img/user_image.png",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        aDistPays.name ?? "----",
                                        style: const TextStyle(
                                          fontFamily: "Manrope",
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: myPink,
                                        ),
                                      ),
                                      Text(
                                        aDistPays.email ?? "---",
                                        style: const TextStyle(
                                          fontFamily: "Manrope",
                                          fontSize: 12,
                                          color: myGrisFonce,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const Text(
                                        "Distributeur Pays",
                                        style: TextStyle(
                                          fontFamily: "Manrope",
                                          fontSize: 14,
                                          fontWeight: FontWeight.w800,
                                          color: myPink,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 20),
                                SizedBox(
                                  width: 0.15 * width,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      ClipOval(
                                        child: Image.asset(
                                          countriesList[
                                              (aDistPays.countryId ?? 1) -
                                                  1]["img"],
                                          fit: BoxFit.cover,
                                          width: 30,
                                          height: 30,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        countriesList[
                                                (aDistPays.countryId ?? 1) - 1]
                                            ["noum"],
                                        textAlign: TextAlign.end,
                                        maxLines: 3,
                                        style: const TextStyle(
                                          overflow: TextOverflow.ellipsis,
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
                        );
                      }),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  loadDistPays() async {
    final internetConnexion = await checkUserConnexion();
    if (internetConnexion) {
      setState(() {
        isLoading = true;
      });
      try {
        final response = await _userService.getUsersByRole(
          {
            "role_id": 4,
          },
        );
        final users = response["users"];
        distPays = [];
        for (var user in users) {
          if (user["is_valided"] == 1) {
            distPays.add(
              User.fromJson(user),
            );
          }
        }
        setState(() {});
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
