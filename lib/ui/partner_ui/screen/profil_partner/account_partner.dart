import 'package:flutter/material.dart';
import 'package:gia_pdg_partenaire/const/colors.dart';
import 'package:gia_pdg_partenaire/ui/pdg_ui/profil/widgets/modif_info.dart';

import '../datas_partner/datas_partner.dart';

class Account extends StatefulWidget {
  const Account({
    super.key,
  });

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    // final user = ref.watch(userProvider);
    List<String> valueList = [
      "",
      "",
      "",
    ];
    return Scaffold(
      backgroundColor: myWhite,
      appBar: AppBar(
        backgroundColor: myWhite,
        title: Text(
          "Compte",
          style: Theme.of(context).textTheme.labelSmall!.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
        scrolledUnderElevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(
                    profilCardData.length,
                    (index) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          profilCardData[index]['text'],
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(color: myPink),
                        ),
                        const SizedBox(height: 6),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            decoration: BoxDecoration(
                              color: myGris,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: ListTile(
                              title: Text(
                                valueList[index],
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                              trailing: SizedBox(
                                width: 30,
                                child: IconButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return ModifInfo(
                                          takeText: (text) {
                                            setState(() {
                                              valueList[index] = text;
                                            });
                                          },
                                          theKey: profilCardData[index]
                                              ['theKey'],
                                          label: profilCardData[index]['label'],
                                        );
                                      },
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.create,
                                    color: myGrisFonceAA,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
