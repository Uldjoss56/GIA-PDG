import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gia_pdg_partenaire/components/const/colors.dart';
import 'package:gia_pdg_partenaire/datas/datas.dart';
import 'package:gia_pdg_partenaire/models/orders.dart';
import 'package:gia_pdg_partenaire/provider/dma_provider.dart';

class ValidateOrder extends ConsumerStatefulWidget {
  const ValidateOrder({
    super.key,
    required this.orderID,
  });
  final int orderID;
  @override
  ConsumerState<ValidateOrder> createState() => _ValidateOrderState();
}

class _ValidateOrderState extends ConsumerState<ValidateOrder> {
  Order? order;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final orderData = ref.watch(orderDataProvider);
    final orders = orderData.orders;
    for (Order myOrder in orders ?? []) {
      if (myOrder.id == widget.orderID) {
        order = myOrder;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

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
          "Details de la commande",
          style: TextStyle(
            fontFamily: 'Manrope-SemiBold',
          ),
        ),
      ),
      body: Stack(
        children: [
          Image.asset(
            "assets/img/order.png",
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
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
                          "Informations sur la commande",
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
                        ListTile(
                          leading: const Icon(
                            Icons.numbers,
                            color: myPink,
                          ),
                          title: const Text(
                            "nombre de DMAs",
                          ),
                          subtitle: Text(
                            order?.number.toString() ?? "------",
                            style: const TextStyle(
                              fontFamily: "Manrope",
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: myPink,
                            ),
                          ),
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
                                  overflow: TextOverflow.ellipsis,
                                ),
                                subtitle: Text(
                                  order?.author?.name ?? "------",
                                ),
                              ),
                            ),
                            Expanded(
                              child: ListTile(
                                leading: Icon(
                                  Icons.mail_outline,
                                  color: myPink,
                                  size: 0.08 * width,
                                ),
                                title: const Text(
                                  "email",
                                  overflow: TextOverflow.ellipsis,
                                ),
                                subtitle: Text(
                                  order?.author?.email ?? "------",
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
                                  overflow: TextOverflow.ellipsis,
                                ),
                                subtitle: Text(
                                  order?.author?.dateOfBirth ?? "------",
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
                                  overflow: TextOverflow.ellipsis,
                                ),
                                subtitle: Text(
                                  order?.author?.sex ?? "------",
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
                                  overflow: TextOverflow.ellipsis,
                                ),
                                subtitle: Row(
                                  children: [
                                    ClipOval(
                                      child: Image.asset(
                                        countriesList[
                                            (order?.author?.countryId ?? 1) -
                                                1]["img"],
                                        fit: BoxFit.cover,
                                        width: 20,
                                        height: 20,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      countriesList[
                                          (order?.author?.countryId ?? 1) -
                                              1]["noum"],
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
                                leading: Icon(
                                  Icons.perm_identity_rounded,
                                  color: myPink,
                                  size: 0.08 * width,
                                ),
                                title: const Text(
                                  "rôle",
                                  overflow: TextOverflow.ellipsis,
                                ),
                                subtitle: Text(
                                  theRoles[order?.author?.roleId ?? 0] ??
                                      "------",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
