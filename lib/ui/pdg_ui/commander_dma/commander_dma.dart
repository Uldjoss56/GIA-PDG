import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gia_pdg_partenaire/components/const/number.dart';
import 'package:gia_pdg_partenaire/components/show_info.dart';
import 'package:gia_pdg_partenaire/components/sort_alert.dart';
import 'package:gia_pdg_partenaire/const/colors.dart';
import 'package:gia_pdg_partenaire/models/orders.dart';
import 'package:gia_pdg_partenaire/models/user.dart';
import 'package:gia_pdg_partenaire/provider/dma_provider.dart';
import 'package:gia_pdg_partenaire/provider/user_provider.dart';
import 'package:gia_pdg_partenaire/services/const.dart';
import 'package:gia_pdg_partenaire/services/dma_service.dart';
import 'package:gia_pdg_partenaire/services/users_service.dart';
import 'package:gia_pdg_partenaire/ui/pdg_ui/commander_dma/cmd_detail/cmd_detail.dart';

class CommanderDMA extends ConsumerStatefulWidget {
  const CommanderDMA({super.key});

  @override
  ConsumerState<CommanderDMA> createState() => _CommanderDMAState();
}

class _CommanderDMAState extends ConsumerState<CommanderDMA> {
  int numbreCmde = 1;

  double montantTotal = 2000;
  static double pUNIT = 2000;

  User? user;
  User? admin;

  final _numberController = TextEditingController();

  bool isLoading = false;

  final _dmaService = DmaService();

  List<Order> userOrder = [];

  bool isLoadingOrders = false;

  final _userService = UserService();

  bool isLoadingAdmin = false;

  bool isLoadingOrder = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    user = ref.watch(userProvider);
    _numberController.text = numbreCmde.toString();
    loadUserOrders();
    loadAdmin();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Commande",
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.only(
                left: 10,
                right: 10,
              ),
              decoration: BoxDecoration(
                color: myWhite,
                borderRadius: BorderRadius.circular(30),
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(0, 0),
                    blurRadius: 1,
                    spreadRadius: 0.1,
                    color: myGrisFonce22,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Nouvelle commande",
                    style: TextStyle(
                      fontFamily: "Manrope",
                      color: myPink,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: "Prix unitaire : ",
                          style: TextStyle(
                            fontFamily: "Manrope",
                            color: myGrisFonce,
                          ),
                        ),
                        TextSpan(
                          text: "XOF ${moneyFormat.format(pUNIT)}",
                          style: const TextStyle(
                            fontFamily: "Manrope",
                            color: myGrisFonce,
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Row(
                      children: [
                        const Text(
                          "Nombre de DMA :",
                          style: TextStyle(
                            fontFamily: "Manrope",
                            fontWeight: FontWeight.w900,
                            fontSize: 18,
                            color: myGrisFonce,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                width: 25,
                                height: 25,
                                decoration: const BoxDecoration(
                                  color: myPink,
                                  boxShadow: [
                                    BoxShadow(
                                      offset: Offset(0, 0),
                                      blurRadius: 1,
                                      spreadRadius: 0.1,
                                      color: myGrisFonceAA,
                                    ),
                                  ],
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  splashRadius: 5,
                                  iconSize: 20,
                                  padding: const EdgeInsets.all(0),
                                  onPressed: () {
                                    if (numbreCmde > 1) {
                                      setState(() {
                                        --numbreCmde;
                                        _numberController.text =
                                            numbreCmde.toString();
                                        montantTotal = numbreCmde * pUNIT;
                                      });
                                    }
                                  },
                                  icon: const Icon(
                                    Icons.remove,
                                    color: myWhite,
                                  ),
                                  style: IconButton.styleFrom(),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: TextField(
                                  controller: _numberController,
                                  keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.unspecified,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                    color: myGrisFonce,
                                  ),
                                  onChanged: (value) {
                                    final check = isIntegrate(value);
                                    setState(() {
                                      if (check != false) {
                                        numbreCmde = check;
                                      } else {
                                        _numberController.text =
                                            numbreCmde.toString();
                                      }
                                      montantTotal = numbreCmde * pUNIT;
                                    });
                                  },
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Container(
                                width: 25,
                                height: 25,
                                decoration: const BoxDecoration(
                                  color: myPink,
                                  boxShadow: [
                                    BoxShadow(
                                      offset: Offset(0, 0),
                                      blurRadius: 1,
                                      spreadRadius: 0.1,
                                      color: myGrisFonceAA,
                                    ),
                                  ],
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  splashRadius: 5,
                                  iconSize: 20,
                                  padding: const EdgeInsets.all(0),
                                  onPressed: () {
                                    setState(() {
                                      ++numbreCmde;
                                      _numberController.text =
                                          numbreCmde.toString();
                                      montantTotal = numbreCmde * pUNIT;
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.add,
                                    color: myWhite,
                                  ),
                                  style: IconButton.styleFrom(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Column(
                              children: [
                                Icon(
                                  Icons.tab_sharp,
                                  color: myGrisFonceAA,
                                ),
                                Text(
                                  "Total",
                                  style: TextStyle(
                                    color: myGrisFonceAA,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              "XOF ${moneyFormat.format(montantTotal)}",
                              style: const TextStyle(
                                color: myGrisFonce,
                                fontWeight: FontWeight.w800,
                                fontSize: 16,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: myPink,
                                      foregroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(),
                                      shape: ContinuousRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    onPressed: montantTotal == 0
                                        ? null
                                        : () {
                                            if (admin != null) {
                                              orderDMA({
                                                "receiver_id": admin!.id,
                                                "number": numbreCmde.toString(),
                                              });
                                            } else {
                                              messenger(context, "Réessayez");
                                            }
                                          },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        if (isLoadingOrder)
                                          Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: SizedBox(
                                                  width: 0.05 * width,
                                                  height: 0.05 * width,
                                                  child:
                                                      const CircularProgressIndicator(
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
                                        SizedBox(
                                          width: 0.2 * width,
                                          child: const Text(
                                            "Commander",
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontFamily: "Manrope",
                                              overflow: TextOverflow.ellipsis,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Liste des commandes",
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
                    if (userOrder.isEmpty)
                      const Center(
                        child: Text(
                          "Aucune commande",
                          style: TextStyle(
                            fontFamily: "Manrope",
                            color: myGrisFonce,
                          ),
                        ),
                      )
                    else if (isLoading)
                      const Center(
                        child: CircularProgressIndicator(),
                      )
                    else
                      Column(
                        children: List.generate(userOrder.length, (index) {
                          final cmd = userOrder[index];
                          return Container(
                            margin: const EdgeInsets.only(
                              left: 10,
                              right: 10,
                              bottom: 10,
                            ),
                            decoration: BoxDecoration(
                              color: myWhite,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                  offset: Offset(0, 0),
                                  blurRadius: 1,
                                  spreadRadius: 0.1,
                                  color: myGrisFonce22,
                                ),
                              ],
                            ),
                            child: ListTile(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => CommandeDetail(
                                      commande: cmd,
                                    ),
                                  ),
                                );
                              },
                              leading: Hero(
                                tag: cmd.hashCode,
                                child: CircleAvatar(
                                  backgroundColor: myPink,
                                  child: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Image.asset(
                                      "assets/img/icons/credit-card_white.png",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              title: Text(
                                "Commande n° ${cmd.id}",
                                style: const TextStyle(
                                  fontFamily: "Manrope",
                                  color: myGrisFonce,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          );
                        }),
                      )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  loadUserOrders() async {
    final internetConnexion = await checkUserConnexion();
    if (internetConnexion) {
      setState(() {
        isLoading = true;
      });
      try {
        final response = await _dmaService.getDMAOrders();

        final myOrders = response.orders!;

        userOrder = [];
        for (Order order in myOrders) {
          if (order.author!.id == user!.id) {
            userOrder.add(order);
          }
        }

        final orderNotifier = ref.read(orderDataProvider.notifier);
        orderNotifier.updateOrderData(response);
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

  orderDMA(data) async {
    final internetConnexion = await checkUserConnexion();
    if (internetConnexion) {
      setState(() {
        isLoadingOrder = true;
      });
      try {
        final response = await _dmaService.orderDma(data);
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
        showDialog(
          // ignore: use_build_context_synchronously
          context: context,
          builder: (context) {
            return const ShowInformation(
              imgPath: "assets/img/icons/credit-card_white.png",
              information: "Commande de DMA",
              detail: "votre commande vous sera livré dans le plus bref délai",
            );
          },
        );

        return response;
      } on DioException catch (e) {
        // ignore: use_build_context_synchronously
        messenger(context, e.response!.data["message"]);
      } finally {
        setState(() {
          isLoadingOrder = false;
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

  loadAdmin() async {
    final internetConnexion = await checkUserConnexion();
    if (internetConnexion) {
      setState(() {
        isLoadingAdmin = true;
      });
      try {
        final response = await _userService.getUsersByRole(
          {
            "role_id": 5,
          },
        );

        setState(() {
          admin = User.fromJson((response["users"] as List)[0]);
        });
      } on DioException catch (e) {
        // ignore: use_build_context_synchronously
        messenger(context, e.response!.data["message"]);
        return List.empty();
      } finally {
        setState(() {
          isLoadingAdmin = false;
        });
      }
    } else {
      // ignore: use_build_context_synchronously
      messenger(context, "Connectez-vous à internet");
      return List.empty();
    }
  }
}
