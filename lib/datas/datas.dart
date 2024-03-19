import 'package:flutter/material.dart';
import 'package:gia_pdg_partenaire/components/notification/notification_page.dart';
import 'package:gia_pdg_partenaire/ui/pdg_ui/distributeur_officiel/distributeur_off_detail.dart';
import 'package:gia_pdg_partenaire/ui/pdg_ui/home/home.dart';
import 'package:gia_pdg_partenaire/ui/pdg_ui/profil/user_profil.dart';

List<Map<String, dynamic>> registrationData = [
  {
    "isPassword": false,
    "prefixPath": "assets/img/icons/user.png",
    "hintText": "nom complet",
  },
  {
    "isPassword": false,
    "prefixPath": "assets/img/icons/email.png",
    "hintText": "email",
  },
  {
    "isPassword": true,
    "prefixPath": "assets/img/icons/padlock.png",
    "hintText": "mot de passe",
  },
  {
    "isPassword": true,
    "prefixPath": "assets/img/icons/padlock.png",
    "hintText": "confirmer le mot de passe",
  }
];

List<Map<String, dynamic>> loginData = [
  {
    "isPassword": false,
    "prefixPath": "assets/img/icons/email.png",
    "hintText": "email",
  },
  {
    "isPassword": true,
    "prefixPath": "assets/img/icons/padlock.png",
    "hintText": "mot de passe",
  },
];

List<String> homeHeaderDatas = [
  "Distributeurs pays",
];

List<Map<String, dynamic>> otherServiceData = [
  {
    "imgPath": "assets/img/electronic_objects.jpeg",
    "title": " FABRICATION DES APPAREILS ELECTROMENAGERS",
  },
  {
    "imgPath": "assets/img/navigation_fluviale.png",
    "title": "TRANSPORT FLUVIAL DE LUXE",
  },
];

List<Map<String, dynamic>> giaData = [
  {
    "imgPath": "assets/img/electronic_objects.jpeg",
    "title": " FABRICATION DES APPAREILS ELECTROMENAGERS",
  },
  {
    "imgPath": "assets/img/navigation_fluviale.png",
    "title": "TRANSPORT FLUVIAL DE LUXE",
  },
];

List<Map<String, dynamic>> commandeData = [
  {
    "imgPath": "assets/img/icons/credit-card_white.png",
    "numCmd": "0816PM-18012024-00001",
    "cusummerID": "0001",
    "dateCmd": "20-02-2024",
    "dateReception": "20-02-2024",
    "nbreDMA": "2",
    "prixUnitaire": "20000",
    "prixVente": "40000",
    "devise": "XOF",
    "pourcentageReduction": "0",
    "adressReception":
        "Sikècodji, rue 456, allée 82, maison 201 Cotonou, Bénin",
  },
  {
    "imgPath": "assets/img/icons/credit-card_white.png",
    "numCmd": "0816PM-18012024-00001",
    "cusummerID": "0001",
    "dateCmd": "20-02-2024",
    "dateReception": "20-02-2024",
    "nbreDMA": "2",
    "prixUnitaire": "20000",
    "prixVente": "",
    "devise": "XOF",
    "pourcentageReduction": "0",
    "adressReception":
        "Sikècodji, rue 456, allée 82, maison 201 Cotonou, Bénin",
  },
  {
    "imgPath": "assets/img/icons/credit-card_white.png",
    "numCmd": "0816PM-18012024-00001",
    "cusummerID": "0001",
    "dateCmd": "20-02-2024",
    "dateReception": "20-02-2024",
    "nbreDMA": "2",
    "prixUnitaire": "20000",
    "prixVente": "",
    "devise": "XOF",
    "pourcentageReduction": "0",
    "adressReception":
        "Sikècodji, rue 456, allée 82, maison 201 Cotonou, Bénin",
  },
];

List<Map<String, dynamic>> notificationData = [
  {
    "imgPath": "assets/img/icons/renewable.png",
    "title": "Expiration de DMA",
    "content": "La date d'expiration de votre DMATelephone est le"
        " 02-12-2026. Veuillez renouveller le maintenant",
    "date": "10-11-2026, 12:21",
    "alreadyReady": true,
  },
  {
    "imgPath": "assets/img/icons/renewable.png",
    "title": "Expiration de DMA",
    "content": "La date d'expiration de votre DMATelephone est le"
        " 02-12-2026. Veuillez renouveller le maintenant",
    "date": "10-11-2026, 12:21",
    "alreadyReady": true,
  },
  {
    "imgPath": "assets/img/icons/renewable.png",
    "title": "Expiration de DMA",
    "content": "La date d'expiration de votre DMATelephone est le"
        " 02-12-2026. Veuillez renouveller le maintenant",
    "date": "10-11-2026, 12:21",
    "alreadyReady": null,
  },
  {
    "imgPath": "assets/img/icons/renewable.png",
    "title": "Expiration de DMA",
    "content": "La date d'expiration de votre DMATelephone est le"
        " 02-12-2026. Veuillez renouveller le maintenant",
    "date": "10-11-2026, 12:21",
    "alreadyReady": null,
  },
  {
    "imgPath": "assets/img/icons/renewable.png",
    "title": "Expiration de DMA",
    "content": "La date d'expiration de votre DMATelephone est le"
        " 02-12-2026. Veuillez renouveller le maintenant",
    "date": "10-11-2026, 12:21",
    "alreadyReady": false,
  },
  {
    "imgPath": "assets/img/icons/renewable.png",
    "title": "Expiration de DMA",
    "content": "La date d'expiration de votre DMATelephone est le"
        " 02-12-2026. Veuillez renouveller le maintenant",
    "date": "10-11-2026, 12:21",
    "alreadyReady": false,
  },
  {
    "imgPath": "assets/img/icons/renewable.png",
    "title": "Expiration de DMA",
    "content": "La date d'expiration de votre DMATelephone est le"
        " 02-12-2026. Veuillez renouveller le maintenant",
    "date": "10-11-2026, 12:21",
    "alreadyReady": false,
  },
  {
    "imgPath": "assets/img/icons/renewable.png",
    "title": "Expiration de DMA",
    "content": "La date d'expiration de votre DMATelephone est le"
        " 02-12-2026. Veuillez renouveller le maintenant",
    "date": "10-11-2026, 12:21",
    "alreadyReady": true,
  },
];

Map<String, dynamic> userData = {
  "imgCoverPath": "assets/img/background02.jpg",
  "profilImage": "assets/img/user_image.jpg",
  "fullname": "DJOSSOU Ulrich",
  "email": "uldjoss56@gmail.com",
  "birthday": "20-07-2004",
  "gender": "Masculin",
  "numTelephone": "+229 64548929",
  "langue": "French",
};

List<Map<String, dynamic>> bottomList = [
  {
    'label': 'Accueil',
    'icon': Image.asset(
      'assets/img/icons/home.png',
      width: 25,
    ),
    'active_icon': Image.asset(
      'assets/img/icons/home_white.png',
      width: 25,
    ),
    "screen": const Home(),
  },
  {
    'label': 'Distributeur Officiel',
    'icon': Image.asset(
      'assets/img/icons/electronic.png',
      width: 25,
    ),
    'active_icon': Image.asset(
      'assets/img/icons/electronic01.png',
      width: 25,
    ),
    "screen": const DistributeurOffiDetail(),
  },
  {
    'label': '',
    'icon': null,
    'active_icon': null,
    "screen": null,
  },
  {
    'label': 'Notifications',
    'icon': Image.asset(
      'assets/img/icons/notification01.png',
      width: 25,
    ),
    'active_icon': Image.asset(
      'assets/img/icons/notification.png',
      width: 25,
    ),
    "screen": const NotificationPage(),
  },
  {
    'label': 'Profil',
    'icon': Image.asset(
      'assets/img/icons/user_01.png',
      width: 25,
    ),
    'active_icon': Image.asset(
      'assets/img/icons/user_white.png',
      width: 25,
    ),
    "screen": const UserProfil(),
  },
];

List<Map<String, dynamic>> profilCardData = [
  {
    "theKey": "fullname",
    "label": "Saisissez votre nom",
    "text": "Nom & Prénom",
  },
  {
    "theKey": "username",
    "label": "Saisissez votre om d'utilisateur",
    "text": "Nom d'utilisateur"
  },
  {
    "theKey": "mail",
    "label": "Saisissez votre email",
    "text": "Adresse mail",
  },
];

List<String> languages = [
  "Français",
  "English",
  "España",
];

List<String> equimentList = [
  "Aucun équipement",
  "Ordinateur Portable",
  " Smartphone",
  "Poste téléviseur",
  " Climatiseur",
];

List<Map<String, dynamic>> paymentMethodData = [
  {
    "imgPath": "assets/img/icons/paypal.png",
    "title": "Paypal",
  },
  {
    "imgPath": "assets/img/icons/Visa-Logo-PNG10.png",
    "title": "Visa",
  },
  {
    "imgPath": "assets/img/icons/mastercard.png",
    "title": "Visa",
  },
];

List<Map<String, dynamic>> countriesList = [
  {
    "img": "assets/img/flags/benin.png",
    "noum": "Bénin",
  },
  {
    "img": "assets/img/flags/cote-d-ivoire.png",
    "noum": "Côte d'Ivoire",
  },
  {
    "img": "assets/img/flags/togo.png",
    "noum": "Togo",
  },
  {
    "img": "assets/img/flags/nigeria.png",
    "noum": "Nigeria",
  },
  {
    "img": "assets/img/flags/niger.png",
    "noum": "Niger",
  },
  {
    "img": "assets/img/flags/angola.png",
    "noum": "Angola",
  },
  {
    "img": "assets/img/flags/south-africa.png",
    "noum": "Afrique du Sud",
  },
  {
    "img": "assets/img/flags/namibia.png",
    "noum": "Namibie",
  },
];

List<Map<String, dynamic>> notifData = [
  {
    "key": "CmdNotification",
    "title": "Commande de DMA",
    "content":
        "Vous avez reçu une commande de DMA, appuyer pour en savoir plus."
  },
  {
    "key": "ValidInscription",
    "title": "Validation d'inscription",
    "content":
        "Vous avez une demande d'inscription, appuyer pour en savoir plus."
  },
  {
    "key": "MsgNotification",
    "title": "Nouveau message reçu",
    "content": "Vous avez reçu un nouveau message, appuyer pour en savoir plus."
  },
];

List<String> pdgOptions = [
  "Liste des vendeurs",
  "Liste des distributeurs",
  "Liste des distributeurs pays",
];

List<String> pdgOptionsImg = [
  "assets/img/list.jpg",
  "assets/img/list.jpg",
  "assets/img/list.jpg",
];
