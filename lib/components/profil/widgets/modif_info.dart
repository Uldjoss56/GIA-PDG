import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gia_pdg_partenaire/const/colors.dart';
import 'package:gia_pdg_partenaire/models/user.dart';
import 'package:gia_pdg_partenaire/provider/user_provider.dart';

class ModifInfo extends ConsumerStatefulWidget {
  const ModifInfo({
    super.key,
    required this.takeText,
    required this.theKey,
    required this.label,
  });
  final void Function(String text) takeText;
  final String theKey;
  final String label;
  @override
  ConsumerState<ModifInfo> createState() => _ModifInfoState();
}

class _ModifInfoState extends ConsumerState<ModifInfo> {
  late String theKey;

  final fullnameController = TextEditingController();
  final birthdayController = TextEditingController();
  final mailController = TextEditingController();
  final countryController = TextEditingController();
  final sexeController = TextEditingController();

  TextEditingController currentController = TextEditingController();

  User? user;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    theKey = widget.theKey;
    user = ref.watch(userProvider);

    fullnameController.text = user?.name ?? "";
    mailController.text = user?.email ?? "";
    birthdayController.text = user?.dateOfBirth ?? "";
    countryController.text = "${user?.countryId ?? ""}";
    sexeController.text = user?.sex ?? "F";
  }

  @override
  void dispose() {
    super.dispose();
    currentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (theKey == "fullname") {
      currentController = fullnameController;
    } else if (theKey == "mail") {
      currentController = mailController;
    } else if (theKey == "country") {
      currentController = countryController;
    } else if (theKey == "sexe") {
      currentController = sexeController;
    }
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          theKey == "birthday"
              ? TextField(
                  controller: birthdayController,
                  onTap: () async {},
                )
              : TextField(
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: myGrisFonce,
                      ),
                  controller: currentController,
                ),
        ],
      ),
      title: Text(
        widget.label,
        style: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: myGrisFonce,
            ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            "Quitter",
            style: Theme.of(context).textTheme.labelSmall!.copyWith(
                  color: myGrisFonce,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
        TextButton(
          onPressed: () {
            setState(() {
              widget.takeText(currentController.text);
              Navigator.of(context).pop();
            });
          },
          child: Text(
            "Valider",
            style: Theme.of(context).textTheme.labelSmall!.copyWith(
                  color: myPink,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
      ],
    );
  }
}
