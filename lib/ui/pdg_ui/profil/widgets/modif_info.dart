import 'package:flutter/material.dart';
import 'package:gia_pdg_partenaire/const/colors.dart';

class ModifInfo extends StatefulWidget {
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
  State<ModifInfo> createState() => _ModifInfoState();
}

class _ModifInfoState extends State<ModifInfo> {
  late String theKey;
  @override
  void initState() {
    super.initState();
    theKey = widget.theKey;
  }

  TextEditingController fullnameTextEditingController = TextEditingController();
  TextEditingController usernameTextEditingController = TextEditingController();
  final TextEditingController bithdayTextEditingController =
      TextEditingController(text: "04/04/2003");
  TextEditingController mailTextEditingController = TextEditingController();
  final TextEditingController countryTextEditingController =
      TextEditingController(text: "Bénin");
  final TextEditingController sexeTextEditingController =
      TextEditingController(text: "Masculin");
  TextEditingController currentTextEditingController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    currentTextEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //final user = ref.watch(userProvider);
    fullnameTextEditingController = TextEditingController(text: "");
    usernameTextEditingController = TextEditingController(text: "");
    mailTextEditingController = TextEditingController(text: "");
    if (theKey == "fullname") {
      currentTextEditingController = fullnameTextEditingController;
    } else if (theKey == "username") {
      currentTextEditingController = usernameTextEditingController;
    } else if (theKey == "birthday") {
      currentTextEditingController = bithdayTextEditingController;
    } else if (theKey == "mail") {
      currentTextEditingController = mailTextEditingController;
    } else if (theKey == "country") {
      currentTextEditingController = countryTextEditingController;
    } else if (theKey == "sexe") {
      currentTextEditingController = sexeTextEditingController;
    }
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Colors.black,
                ),
            controller: currentTextEditingController,
          ),
        ],
      ),
      title: Text(
        widget.label,
        style: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: Colors.black,
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
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
        TextButton(
          onPressed: () {
            setState(() {
              widget.takeText(currentTextEditingController.text);
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
