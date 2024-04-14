import 'package:flutter/material.dart';
import 'package:gia_pdg_partenaire/components/const/colors.dart';

class SortAlert extends StatefulWidget {
  const SortAlert({
    super.key,
  });

  @override
  State<SortAlert> createState() => _SortAlertState();
}

class _SortAlertState extends State<SortAlert> {
  String? _sortType = "name";

  String? _sortOrder = "asc";
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      surfaceTintColor: myWhite,
      title: const Center(
        child: Text(
          "Trier",
          style: TextStyle(
            fontFamily: "Manrope",
            fontWeight: FontWeight.w800,
            fontSize: 20,
          ),
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "nom",
                style: TextStyle(
                  fontFamily: "Manrope",
                  color: myGrisFonceAA,
                  fontSize: 18,
                ),
              ),
              Radio(
                value: "name",
                groupValue: _sortType,
                onChanged: (value) {
                  setState(() {
                    _sortType = value;
                  });
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "date",
                style: TextStyle(
                  fontFamily: "Manrope",
                  color: myGrisFonceAA,
                  fontSize: 18,
                ),
              ),
              Radio(
                value: "date",
                groupValue: _sortType,
                onChanged: (value) {
                  setState(() {
                    _sortType = value;
                  });
                },
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(right: 10),
            child: Divider(
              thickness: 1,
              color: myGrisFonceAA,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "croissant",
                style: TextStyle(
                  fontFamily: "Manrope",
                  color: myGrisFonceAA,
                  fontSize: 18,
                ),
              ),
              Radio(
                value: "asc",
                groupValue: _sortOrder,
                onChanged: (value) {
                  setState(() {
                    _sortOrder = value;
                  });
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "décroissant",
                style: TextStyle(
                  fontFamily: "Manrope",
                  color: myGrisFonceAA,
                  fontSize: 18,
                ),
              ),
              Radio(
                value: "desc",
                groupValue: _sortOrder,
                onChanged: (value) {
                  setState(() {
                    _sortOrder = value;
                  });
                },
              ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            "Quitter",
            style: TextStyle(
              fontFamily: "Manrope",
              color: myGrisFonce,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            setState(() {
              Navigator.of(context).pop();
            });
          },
          child: const Text(
            "Valider",
            style: TextStyle(
              fontFamily: "Manrope",
              color: myPink,
            ),
          ),
        ),
      ],
    );
  }
}

isIntegrate(String value) {
  try {
    double dvalue = double.parse(value);
    int ivalue = dvalue.toInt();
    return ivalue;
  } catch (e) {
    return false;
  }
}

isInteger(String text) {
  return int.tryParse(text) != null;
}

