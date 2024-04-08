import 'package:flutter/material.dart';
import 'package:gia_pdg_partenaire/components/notification/notification_page.dart';
import 'package:gia_pdg_partenaire/ui/partner_ui/screen/distributeur_officiel/distributeur_off_detail.dart';
import 'package:gia_pdg_partenaire/ui/partner_ui/screen/partner_home.dart';

import '../profil_partner/user_profil_partner.dart';

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
  "Mes DMAs",
  "Nos autres produits & services",
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
    "screen": const PartnerHome(),
  },
  {
    'label': 'Chat',
    'icon': Image.asset(
      'assets/img/icons/distribution_01.png',
      width: 25,
    ),
    'active_icon': Image.asset(
      'assets/img/icons/distribution.png',
      width: 25,
    ),
    "screen": const DistributeurOffiDetail(),
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
    "screen": const PartnerProfil(),
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

  // {
  //   "theKey": "birthday",
  //   "label": "Saisissez votre date de naissance",
  //   "text": "Année de naissance"
  // },
  // {
  //   "theKey": "country",
  //   "label": "Saisissez votre pays",
  //   "text": "Pays",
  // },
  // {
  //   "theKey": "sexe",
  //   "label": "Saisissez votre sexe",
  //   "text": "Sexe",
  // },
];

List<String> languages = [
  "Français",
  "English",
  "España",
];
